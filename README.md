# 도커 빌드 환경 테스트용 저장소

Dockerfile을 통해 빌드 환경 구축/공유 테스트
Docker 내에서 clang을 이용한 c++ build test

### Docker Build & Hub push
```bash
$ docker build . -t <hub ID>/cpp-builder
$ docker push <hub ID>/cpp-builder
```

### Build the images for multi arch using Buildx
```bash
$ docker buildx create --name multiarch-builder --use
$ docker buildx inspect --bootstrap
Name:          multiarch_builder
Driver:        docker-container
Last Activity: 2024-12-15 08:16:16 +0000 UTC

Nodes:
Name:                  multiarch_builder0
Endpoint:              desktop-linux
Status:                running
BuildKit daemon flags: --allow-insecure-entitlement=network.host
BuildKit version:      v0.18.1
Platforms:             linux/arm64, linux/amd64, linux/amd64/v2, linux/riscv64, linux/ppc64le, linux/s390x, linux/386, linux/arm/v7, linux/arm/v6

$ docker buildx build \
    --push \
    --platform linux/arm64/v8,linux/amd64 \
    --tag jonhalee/cpp-builder .
```
