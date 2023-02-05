appName="shchat"

BuildDev() {
  rm -rf .git/
  BASE="https://musl.nn.ci/"
  FILES=(aarch64-linux-musl-cross)
  for i in "${FILES[@]}"; do
    url="${BASE}${i}.tgz"
    curl -L -o "${i}.tgz" "${url}"
    sudo tar xf "${i}.tgz" --strip-components 1 -C /usr/local
  done
  OS_ARCHES=(linux-musl-arm64)
  CGO_ARGS=(aarch64-linux-musl-gcc)
  for i in "${!OS_ARCHES[@]}"; do
    os_arch=${OS_ARCHES[$i]}
    cgo_cc=${CGO_ARGS[$i]}
    echo building for ${os_arch}
    export GOOS=${os_arch%%-*}
    export GOARCH=${os_arch##*-}
    export CC=${cgo_cc}
    export CGO_ENABLED=1
    go build -o ./dist/$appName-$os_arch -tags=jsoniter .
  done
  xgo -targets=linux/amd64,windows/amd64,darwin/amd64 -out "$appName" -tags=jsoniter .
  mkdir -p "dist"
  mv $appName-* dist
  cd dist
  upx -9 ./$appName-linux*
  upx -9 ./$appName-windows*
  find . -type f -print0 | xargs -0 md5sum >md5.txt
  cat md5.txt
}


BuildRelease() {
  rm -rf .git/
  mkdir -p "build"
  BASE="https://musl.nn.ci/"
  FILES=(aarch64-linux-musl-cross)
  for i in "${FILES[@]}"; do
    url="${BASE}${i}.tgz"
    curl -L -o "${i}.tgz" "${url}"
    sudo tar xf "${i}.tgz" --strip-components 1 -C /usr/local
  done
  OS_ARCHES=(linux-musl-arm64)
  CGO_ARGS=(aarch64-linux-musl-gcc)
  for i in "${!OS_ARCHES[@]}"; do
    os_arch=${OS_ARCHES[$i]}
    cgo_cc=${CGO_ARGS[$i]}
    echo building for ${os_arch}
    export GOOS=${os_arch%%-*}
    export GOARCH=${os_arch##*-}
    export CC=${cgo_cc}
    export CGO_ENABLED=1
    go build -o ./build/$appName-$os_arch -tags=jsoniter .
  done
  xgo -targets=linux/amd64,windows/amd64,darwin/amd64 -out "$appName" -tags=jsoniter .
  # why? Because some target platforms seem to have issues with upx compression
  upx -9 ./$appName-linux-amd64
  upx -9 ./$appName-windows*
  mv $appName-* build
}

MakeRelease() {
  cd build
  mkdir compress
  for i in $(find . -type f -name "$appName-linux-*"); do
    cp "$i" $appName
    tar -czvf compress/"$i".tar.gz $appName
    rm -f $appName
  done
  for i in $(find . -type f -name "$appName-darwin-*"); do
    cp "$i" $appName
    tar -czvf compress/"$i".tar.gz $appName
    rm -f $appName
  done
  for i in $(find . -type f -name "$appName-windows-*"); do
    cp "$i" $appName.exe
    zip compress/$(echo $i | sed 's/\.[^.]*$//').zip $appName.exe
    rm -f $appName.exe
  done
  cd compress
  find . -type f -print0 | xargs -0 md5sum >md5.txt
  cat md5.txt
  cd ../..
}

if [ "$1" = "dev" ]; then
  BuildDev
elif [ "$1" = "release" ]; then
  BuildRelease
  MakeRelease
else
  echo "Usage: $0 [dev|release]"
fi
