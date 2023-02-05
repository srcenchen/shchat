appName="SHChat"

BuildDev() {
  rm -rf .git/
  mkdir -p "dist"
  # Build For arm64
  BASE="https://musl.nn.ci/"
  FILES=(aarch64-linux-musl-cross)
  for i in "${FILES[@]}"; do
    url="${BASE}${i}.tgz"
    curl -L -o "${i}.tgz" "${url}"
    sudo tar xf "${i}.tgz" --strip-components 1 -C /usr/local
  done
  OS_ARCHES=(linux-musl-arm64 windows-mingw-amd64)
  CGO_ARGS=(aarch64-linux-musl-gcc x86_64-w64-mingw32-gcc)
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
  # why? Because some target platforms seem to have issues with upx compression
  mv SHChat-* dist
  cd dist
  upx -9 ./SHChat-linux*
  upx -9 ./SHChat-windows*
  find . -type f -print0 | xargs -0 md5sum >md5.txt
  cat md5.txt
}


BuildRelease() {
  rm -rf .git/
  mkdir -p "build"
  # Build For arm64
  BASE="https://musl.nn.ci/"
  FILES=(aarch64-linux-musl-cross)
  for i in "${FILES[@]}"; do
    url="${BASE}${i}.tgz"
    curl -L -o "${i}.tgz" "${url}"
    sudo tar xf "${i}.tgz" --strip-components 1 -C /usr/local
  done
  OS_ARCHES=(linux-musl-arm64 windows-mingw-amd64)
  CGO_ARGS=(aarch64-linux-musl-gcc x86_64-w64-mingw32-gcc)
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
  # why? Because some target platforms seem to have issues with upx compression
  upx -9 ./SHChat-linux-amd64
  upx -9 ./SHChat-windows*
  mv SHChat-* build
}

MakeRelease() {
  cd build
  mkdir compress
  for i in $(find . -type f -name "$appName-linux-*"); do
    cp "$i" SHChat
    tar -czvf compress/"$i".tar.gz SHChat
    rm -f SHChat
  done
  for i in $(find . -type f -name "$appName-darwin-*"); do
    cp "$i" SHChat
    tar -czvf compress/"$i".tar.gz SHChat
    rm -f SHChat
  done
  for i in $(find . -type f -name "$appName-windows-*"); do
    cp "$i" SHChat.exe
    zip compress/$(echo $i | sed 's/\.[^.]*$//').zip SHChat.exe
    rm -f SHChat.exe
  done
  cd compress
  find . -type f -print0 | xargs -0 md5sum >md5.txt
  cat md5.txt
  cd ../..
}

if [ "$1" = "dev" ]; then
    BuildDev
  fi
elif [ "$1" = "release" ]; then
    BuildRelease
    MakeRelease
  fi
else
  echo -e "Parameter error"
fi
