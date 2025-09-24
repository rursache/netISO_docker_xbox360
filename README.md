# NetISO Xbox 360 wine docker container

Stop wasting time converting (decompressing) 360 ISOs to GOD and mount the ISOs directly!

Linux/macOS supported!

Point the `/games` volume to your folder of 360 ISOs and follow the [NetISO](https://consolemods.org/wiki/Xbox_360:Playing_Games_over_Network_(NetISO)) instructions ([mirror](wiki.pdf))

```sh
docker build -t netiso360 .
```

```sh
docker run -d \
  --name netiso360 \
  --restart always \
  --network host \
  -e TZ=Europe/Bucharest \
  -v /path/to/360/isos:/games:ro \
  netiso360
```