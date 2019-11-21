BINARIES=$$(go list ./cmd/...)
TESTABLE=$$(go list ./...)
GCP_REGION?=europe-west1
GCP_PROJECT?=<<SAMPLE_PROJECT>>
APP_NAME?=sample-api
PORT?=5000

.PHONY: deps test build publish local

all: test build publish deploy

deps:
	@go get -u -v all && go mod tidy

test:
	@go test -v $(TESTABLE)

build:
	@docker build --tag eu.gcr.io/$(GCP_PROJECT)/$(APP_NAME) .

publish:
	@gcloud auth configure-docker -q && docker push eu.gcr.io/$(GCP_PROJECT)/$(APP_NAME)

deploy:
	@gcloud beta run deploy $(APP_NAME) \
		--image eu.gcr.io/$(GCP_PROJECT)/$(APP_NAME) \
		--platform managed \
		--region europe-west1 \
		--allow-unauthenticated \
		--project $(GCP_PROJECT) \
		--memory 2G \
		--quiet

local:
	@docker run -ti -p $(PORT):$(PORT) -e PORT=$(PORT) eu.gcr.io/$(GCP_PROJECT)/$(APP_NAME)