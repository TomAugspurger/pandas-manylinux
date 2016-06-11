manylinux wheel builder for pandas

To use.

```bash
docker build -t pandas-ml .
docker create --name build-container pandas-ml
docker start build-container
docker logs -f build-container
docker cp build-container:/wheelhouse .
```

