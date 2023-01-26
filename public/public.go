package public

import (
	"embed"
	"github.com/gin-contrib/static"
	_ "github.com/gin-contrib/static"
	"github.com/gin-gonic/gin"
	"io/fs"
	"net/http"
	"strings"
)

//go:embed dist
var dist embed.FS

//go:embed dist/index.html
var IndexHtml string

type embedFileSystem struct {
	http.FileSystem
}

func (e embedFileSystem) Exists(prefix string, path string) bool {
	_, err := e.Open(path)
	if err != nil {
		return false
	}
	return true
}

func EmbedFolder(fsEmbed embed.FS, targetPath string) static.ServeFileSystem {
	fileSys, err := fs.Sub(fsEmbed, targetPath)
	if err != nil {
		panic(err)
	}
	return embedFileSystem{
		FileSystem: http.FS(fileSys),
	}
}

func InitIndex(router *gin.Engine) {
	// 获取 assets
	// distSub, _ := fs.Sub(dist, "dist")
	router.Use(static.Serve("/", EmbedFolder(dist, "dist")))

	// 检测是否为html请求，如果是则返回index.html 就不转发了
	router.NoRoute(func(c *gin.Context) {
		accept := c.Request.Header.Get("Accept")
		flag := strings.Contains(accept, "text/html")
		if flag {
			c.Writer.WriteHeader(200)
			if _, err := c.Writer.Write([]byte(IndexHtml)); err != nil {
				panic(err)
			}
			c.Writer.Flush()
		}
	})
}
