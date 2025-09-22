package main

import (
	"strings"
	"testing"

	"github.com/danielgtaylor/huma/v2/humatest"
)

func TestGetGreeting(t *testing.T) {
	_, api := humatest.New(t)

	addRoutes(api)

	resp := api.Get("/greeting/shunsock")
	if !strings.Contains(resp.Body.String(), "Hello, shunsock!") {
		t.Fatalf("Unexpected response: %s", resp.Body.String())
	}
}

