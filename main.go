package main

import (
	"net/http"

	"gaebp/dispatch"
)

func init() {
	http.Handle("/", dispatch.NewMux())
}
