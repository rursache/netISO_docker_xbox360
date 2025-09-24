# NetISO Xbox 360 wine docker container

Stop wasting time converting (decompressing) 360 ISOs and mount them directly over the network!

#### Linux/macOS supported!

## How?

Point the `/games` volume to your folder of 360 ISOs and follow the [NetISO](https://consolemods.org/wiki/Xbox_360:Playing_Games_over_Network_(NetISO)) instructions ([mirror](wiki.pdf))

## Install

Run the prebuild docker image:
```sh
docker run -d \
  --name netiso360 \
  --restart always \
  --network host \
  -e TZ=Europe/Bucharest \
  -v /path/to/360/isos:/games:ro \
  ghcr.io/rursache/netiso_docker_xbox360:master
```

or build it yourself:
```sh
docker build -t netiso360 .
```

## Windows?
Simply run the `server.exe` inside the folder where your ISOs are

## Credits
[ConfusionRS](https://www.reddit.com/user/ConfusionRS/) for the NetISO implementation and Windows binary
