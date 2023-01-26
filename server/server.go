package server

import (
	"SHChattingBackend/server/handles"
	"github.com/gin-gonic/gin"
)

func Router(router *gin.Engine) {
	api := router.Group("/api")
	api.GET("/getChatList", handles.GetAllChats)
	api.POST("/addChat", handles.AddChat)
	api.GET("/clearAll", handles.ClearAll)

}
