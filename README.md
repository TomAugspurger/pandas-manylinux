# Pandas manylinux


Wheel builder for pandas.
The build was timing out on Travis, so we're doing this on a local
docker engine.

To use, run `./build.sh`, which just does

```bash
docker build -t pandas-ml .
docker create --name build-container pandas-ml
docker start build-container
docker logs -f build-container
docker cp build-container:/wheelhouse .
```

