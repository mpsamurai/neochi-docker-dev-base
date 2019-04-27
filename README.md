# neochi-docker-dev-base

Neoch-Solver's development environment containing OpenCV, redis-py and flask.

It works both on x64 and Raspberry Pi Zero W.

You can pull the image from Docker Hub [mpsamurai/neochi-dev-base](https://hub.docker.com/r/mpsamurai/neochi-dev-base).

## Run image

### Run arm32v6 image on Raspberry Pi

```bash
docker pull mpsamurai/neochi-dev-base:20190424-arm32v6
docker run -it mpsamurai/neochi-dev-base:20190424-arm32v6
```

### Run x64 image on x64

```bash
docker pull mpsamurai/neochi-dev-base:20190424-x64
docker run -it mpsamurai/neochi-dev-base:20190424-x64
```

### Install Docker on Raspberry Pi Zero W

If you do not install Docker on your Raspberry Pi, you need to install it.

```bash
git clone https://github.com/mpsamurai/neochi-docker-dev-base.git
cd neochi-docker-dev-base
sudo ./docker-installer.sh
```
## Build image

### Build Image for Raspberry Pi on Ubuntu

If you build arm32v6 image on your x64 Ubuntu, you need to install QEMU.

```bash
sudo apt update
sudo apt install -y qemu qemu-user-static qemu-user
```

```bash
git clone https://github.com/mpsamurai/neochi-docker-dev-base.git
cd neochi-docker-dev-base
cp /usr/bin/qemu-arm-static .
docker-compose -f docker-compose-arm32v6-run-on-x64.yml build
```

### Build Image for x64

```bash
git clone https://github.com/mpsamurai/neochi-docker-dev-base.git
cd neochi-docker-dev-base
cp /usr/bin/qemu-arm-static .
docker-compose -f docker-compose-x64.yml build
```
