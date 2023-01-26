package main

// 引入 gin static
import (
	"SHChattingBackend/data"
	"SHChattingBackend/public"
	"SHChattingBackend/server"
	"github.com/gin-gonic/gin"
	_ "net/http"
)

func main() {
	// 数据库初始化
	data.InitData()
	gin.SetMode(gin.ReleaseMode)
	router := gin.Default()
	// font end load
	public.InitIndex(router)
	server.Router(router)
	println("服务启动: 运行在8087端口 http://localhost:8087")
	if err := router.Run(":8087"); err != nil {
		return
	}
}
