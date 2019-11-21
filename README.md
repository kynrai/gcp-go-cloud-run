# GCP Cloud Run for Golang server

Template for deploying production ready APIs on googles new Cloud Run service.

- Uses github actions for deployment

## Usage

1. Clone repo
2. Update the variables in the `Makefile` and `.github/workflows/*.yaml`
3. Setup `PROJECT_ID`, `APP_NAME` and `GOOGLE_APPLICATION_CREDENTIALS` secrets in github repo.
4. Make sure the service account used for GCP has the following roles:

    ```
    Cloud Build Service Account
    Service Account User
    Cloud Run Admin
    Storage Object Creator
    Viewer
    ```