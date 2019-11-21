package server

import (
	"net/http"

	"github.com/go-chi/chi"
	"github.com/go-chi/chi/middleware"
)

func NewRouter() *chi.Mux {
	router := chi.NewRouter()

	router.Use(
		BodyCloser,
		// Secure,
		middleware.StripSlashes,
		middleware.DefaultCompress,
		middleware.RequestID,
		middleware.RealIP,
		middleware.Logger,
		PanicHandler,
		TraceHandler,
		Cors(),
	)

	//router.Method(http.MethodGet, "/", Version())
	router.Method(http.MethodGet, "/health", Health("OK"))
	router.Method(http.MethodHead, "/health", Health())

	return router
}
