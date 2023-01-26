appName="SHChat"

rm -rf .git/
mkdir -p "build"
muslflags="--extldflags '-static -fpic' $ldflags"
BASE="https://musl.nn.ci/"
FILES=(x86_64-linux-musl-cross aarch64-linux-musl-cross arm-linux-musleabihf-cross mips-linux-musl-cross mips64-linux-musl-cross mips64el-linux-musl-cross mipsel-linux-musl-cross powerpc64le-linux-musl-cross s390x-linux-musl-cross)
for i in "${FILES[@]}"; do
  url="${BASE}${i}.tgz"
  curl -L -o "${i}.tgz" "${url}"
  sudo tar xf "${i}.tgz" --strip-components 1 -C /usr/local
done
OS_ARCHES=(linux-musl-amd64 linux-musl-arm64 linux-musl-arm)
CGO_ARGS=(x86_64-linux-musl-gcc aarch64-linux-musl-gcc arm-linux-musleabihf-gcc)
for i in "${!OS_ARCHES[@]}"; do
  os_arch=${OS_ARCHES[$i]}
  cgo_cc=${CGO_ARGS[$i]}
  echo building for ${os_arch}
  export GOOS=${os_arch%%-*}
  export GOARCH=${os_arch##*-}
  export CC=${cgo_cc}
  export CGO_ENABLED=1
  go build -o ./build/$appName-$os_arch -ldflags="$muslflags" -tags=jsoniter .
done
# xgo -out "$appName" -ldflags="$ldflags" -tags=jsoniter .
# why? Because some target platforms seem to have issues with upx compression
upx -9 ./SHChat-linux-amd64
upx -9 ./SHChat-windows*
mv SHChat-* build

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
