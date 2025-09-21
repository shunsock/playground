package main

import (
	"context"
	"fmt"
	"net/http"

	"github.com/danielgtaylor/huma/v2"
	"github.com/danielgtaylor/huma/v2/adapters/humachi"
	"github.com/danielgtaylor/huma/v2/humacli"
	"github.com/go-chi/chi/v5"
)

type Options struct {
	Port int `help:"Port to listen on" short:"p" default:"8888"`
}

type GreetingOutput struct {
	Body struct {
		Message string `json:"message" example:"Hello, world!" doc:"Greeting message"`
	}
}

func main() {
	cli := humacli.New(func(hooks humacli.Hooks, options *Options) {
		router := chi.NewMux()
		api := humachi.New(router, huma.DefaultConfig("My API", "1.0.0"))

		// Register GET /greeting/{name} handler.
		huma.Get(
			api,
			"/greeting/{name}",
			func(
				ctx context.Context,
				input *struct {
					Name string `path:"name" maxLength:"30" example:"world" doc:"Name to greet"`
				},
			) (*GreetingOutput, error) {
				resp := &GreetingOutput{}
				resp.Body.Message = fmt.Sprintf("Hello, %s!", input.Name)
				return resp, nil
			},
		)

		hooks.OnStart(func() {
			fmt.Printf("Starting server on port %d...\n", options.Port)
			http.ListenAndServe(fmt.Sprintf(":%d", options.Port), router)
		})
	})

	cli.Run()
}
