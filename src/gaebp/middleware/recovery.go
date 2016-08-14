package middleware

import (
	"net/http"

	"github.com/celrenheit/lion"
	"golang.org/x/net/context"
)

// A RecoveryHandler for panics.
type RecoveryHandler struct{}

// ServeNext implements lion.Middleware interface.
func (h *RecoveryHandler) ServeNext(next lion.Handler) lion.Handler {
	return lion.HandlerFunc(func(c context.Context, w http.ResponseWriter, r *http.Request) {
		defer func() {
			if err := recover(); err != nil {
				w.WriteHeader(http.StatusInternalServerError)
				w.Write([]byte("Panic"))
			}
		}()

		next.ServeHTTPC(c, w, r)
	})
}
