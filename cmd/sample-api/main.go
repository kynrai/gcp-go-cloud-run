package main

import (
	"github.com/kynrai/gcp-go-cloud-run/pkg/api/server"
)

func main() {
	server.New().Run()
}
