package handles

import (
	"SHChattingBackend/data"
	"github.com/gin-gonic/gin"
)

func GetAllChats(c *gin.Context) {
	result := data.GetAllChats()
	// 数组转json
	c.JSON(200, result)
}

func AddChat(c *gin.Context) {
	// 获取raw
	data.AddChat(c.PostForm("nickname"), c.PostForm("content"), c.PostForm("time"))
	c.JSON(200, gin.H{
		"status": "success",
	})
}

func ClearAll(c *gin.Context) {
	data.ClearAll()
	c.JSON(200, gin.H{
		"status": "success",
	})
}
