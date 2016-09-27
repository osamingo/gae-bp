package dispatch

import (
	"errors"
	"net/http"

	"gaebp/middleware"

	"github.com/celrenheit/lion"
	"golang.org/x/net/context"
)

// NewMux return a global router.
func NewMux() *lion.Router {

	mux := lion.New()
	mux.Use(new(middleware.RecoveryHandler))

	mux.GetFunc("/", func(c context.Context, w http.ResponseWriter, r *http.Request) {
		w.Write([]byte("OK"))
	})
	mux.GetFunc("/panic", func(c context.Context, w http.ResponseWriter, r *http.Request) {
		panic(errors.New("ops"))
	})

	return mux
}
