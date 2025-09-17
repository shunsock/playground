package main

import (
	"fmt"
	"log"
	"net/http"

	"github.com/shunsock/hubuki/internal/server"
)

func main() {
	http.HandleFunc("/", server.HomeHandler)
	http.HandleFunc("/health", server.HealthHandler)

	fmt.Println("Starting server on :8080")
	if err := http.ListenAndServe(":8080", nil); err != nil {
		log.Fatal("Server failed to start:", err)
	}
}
