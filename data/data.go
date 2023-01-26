package data

import (
	"gorm.io/driver/sqlite"
	_ "gorm.io/driver/sqlite"
	"gorm.io/gorm"
	_ "gorm.io/gorm"
)

// ChatList /*
type ChatList struct {
	Id       int    `gorm:"primary_key;auto_increment;not null"`
	NickName string `gorm:"type:varchar(255);not null"`
	Content  string `gorm:"type:varchar(255);not null"`
	DateTime string `gorm:"type:dateTime;not null"`
}

func InitData() {
	db, err := gorm.Open(sqlite.Open("data.db"), &gorm.Config{})
	if err != nil {
		panic("failed to connect database")
	}
	// 自动迁移模式
	if db.AutoMigrate(&ChatList{}) != nil {
		panic("failed to migrate database")
	}

}

func GetAllChats() []ChatList {
	db, err := gorm.Open(sqlite.Open("data.db"), &gorm.Config{})
	if err != nil {
		panic("failed to connect database")
	}
	var chatList []ChatList
	db.Find(&chatList)
	return chatList
}

func AddChat(nickName string, content string, dateTime string) {
	db, err := gorm.Open(sqlite.Open("data.db"), &gorm.Config{})
	if err != nil {
		panic("failed to connect database")
	}
	db.Create(&ChatList{NickName: nickName, Content: content, DateTime: dateTime})
}

func ClearAll() {
	db, err := gorm.Open(sqlite.Open("data.db"), &gorm.Config{})
	if err != nil {
		panic("failed to connect database")
	}
	db.Where("id != -1").Delete(&ChatList{})
}
