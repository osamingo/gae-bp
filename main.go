package main

import (
	"net/http"

	"gaebp/route"
)

func init() {
	http.Handle("/", route.NewMux())
}
