# Statically linked cpc

Statically linked [cpc] container image with [Bash]

> ~ 2M (1,1M bash)

```bash
ghcr.io/awesome-containers/static-cpc:latest
ghcr.io/awesome-containers/static-cpc:1.9.1

docker.io/awesomecontainers/static-cpc:latest
docker.io/awesomecontainers/static-cpc:1.9.1
```

Slim statically linked [cpc] container image with [Bash] and packaged with [UPX]

> ~ 928K (578K bash)

```bash
ghcr.io/awesome-containers/static-cpc:latest-slim
ghcr.io/awesome-containers/static-cpc:1.9.1-slim

docker.io/awesomecontainers/static-cpc:latest-slim
docker.io/awesomecontainers/static-cpc:1.9.1-slim
```

[cpc]: https://github.com/probablykasper/cpc
[Bash]: https://github.com/awesome-containers/static-bash
[UPX]: https://upx.github.io/

<!--
```bash
image="localhost/${PWD##*/}"

podman build -t "$image:latest" .
podman build -t "$image:latest-slim" -f Containerfile-slim \
  --build-arg STATIC_CPC_IMAGE="$image" \
  --build-arg STATIC_CPC_VERSION=latest --no-cache .

echo "$image:latest"
podman inspect "$image:latest" | jq '.[].Size' | numfmt --to=iec
echo "$image:latest-slim"
podman inspect "$image:latest-slim" | jq '.[].Size' | numfmt --to=iec

```
-->
