appname="SHChat"
rm -rf .git/
xgo -targets=linux/amd64,linux/arm64,windows/amd64,darwin/amd64 -out "$appName" -ldflags="$ldflags" -tags=jsoniter .
mkdir -p "dist"
mv alist-* dist
cd dist
upx -9 ./alist-linux*
upx -9 ./alist-windows*
find . -type f -print0 | xargs -0 md5sum >md5.txt
cat md5.txt
