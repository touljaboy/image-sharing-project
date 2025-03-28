package main

import (
	"net/http"
	"server/actions"

	// "time"

	// "github.com/gin-contrib/cors"

	"github.com/gin-gonic/gin"
)

type TfRequestBody struct {
	Action     string            `json:"action"`
	TfCall     string            `json:"tfcall"`
	Parameters map[string]string `json:"parameters"`
}

func main() {

	router := gin.Default()
	// router.Use(cors.New(cors.Config{
	// 	AllowOrigins:     []string{"http://localhost:5500"},
	// 	AllowMethods:     []string{"GET", "POST"},
	// 	AllowHeaders:     []string{"Content-Type"},
	// 	ExposeHeaders:    []string{"Content-Length"},
	// 	AllowCredentials: true,
	// 	MaxAge:           12 * time.Hour,
	// }))
	router.POST("/v1/tf/", performTfAction)

	// should also have endpoints for ansible based actions if needed
	router.Run("localhost:9090")
}

func performTfAction(context *gin.Context) {
	var body TfRequestBody

	if err := context.BindJSON(&body); err != nil {
		context.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	if err := handleTfRequest(body); err != nil {
		context.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	context.JSON(http.StatusOK, gin.H{"received": body.Action})
}

// logic for adding an azure vm
func handleTfRequest(body TfRequestBody) error {
	// DEPRECATED decode the params from json
	// var raw map[string]interface{}
	// json.Unmarshal([]byte(body.Parameters), &raw)
	// var result map[string]string
	// mapstructure.Decode(raw, &result)
	return actions.TfDeployment(body.Action, body.TfCall, body.Parameters)
}
