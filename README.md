# dotnet-api-example

A minimal **.NET 10 Web API** example, containerized with Docker and shipped through a GitHub Actions CI/CD pipeline.

## Overview

- **Framework:** ASP.NET Core (.NET 10, Minimal APIs)
- **API docs:** OpenAPI + [Scalar](https://scalar.com/) UI (Development environment only)
- **Container:** multi-stage Docker build on Alpine images
- **CI/CD:** GitHub Actions (build, test and publish to Docker Hub)

## Endpoints

### `POST /echo`

Receives a message and returns it prefixed with `Your message is:`.

Request:

```json
{ "message": "hello" }
```

Response `200 OK`:

```json
{ "message": "Your message is: hello" }
```

## Getting started

### Prerequisites

- [.NET 10 SDK](https://dotnet.microsoft.com/download)
- [Docker](https://www.docker.com/) (optional)

### Run locally

```bash
dotnet run --project DotNetApiExample
```

The API listens on `http://localhost:5080`. In Development, the interactive docs are available at `http://localhost:5080/scalar/v1`.

### Run with Docker

```bash
docker build -t dotnet-api-example .
docker run --rm -p 8080:80 dotnet-api-example
```

```bash
curl -X POST http://localhost:8080/echo \
  -H "Content-Type: application/json" \
  -d '{"message":"hello"}'
```

The container runs in the `production` environment, so OpenAPI and Scalar are not exposed.

## CI/CD

A single workflow, [`.github/workflows/ci-cd.yml`](.github/workflows/ci-cd.yml), runs two jobs:

| Event | Build and Test | Publish to Docker Hub |
|---|---|---|
| Pull request (any branch) | yes | no |
| Push to `main` | yes | yes, after build and test pass |

The image is published to Docker Hub as `<owner>/<repo>:latest`. The workflow requires a `DOCKERHUB_PASSWORD` repository secret.

## License

See [LICENSE](LICENSE).
