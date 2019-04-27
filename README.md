# neochi-docker-dev-base

Neoch-Solver's development environment.

This image works on Raspberry Pi.

You can pull the image from Docker Hub [mpsamurai/neochi-dev-base](https://hub.docker.com/r/mpsamurai/neochi-dev-base) and run it on Raspberry Pi.

```bash
docker pull mpsamurai/neochi-dev-base:20190424
docker run -it mpsamurai/neochi-dev-base:20190424
```

If you want run with Redis, you can use docker-compose.

```bash
docker-compose -f docker-compose-pi.yml up
docker-compose -f docker-compose-pi.yml run neochi bash
```

## Build Image for arm32v6 on Ubuntu and run it on Raspberry Pi

### Build Image for arm32v6 on Ubuntu

You need to install QEMU by using the following commands.

```bash
sudo apt update
sudo apt install -y qemu qemu-user-static qemu-user
```

Then execute the following command.

```bash
git clone https://github.com/mpsamurai/neochi-docker-dev-base.git
cd neochi-docker-dev-base
cp /usr/bin/qemu-arm-static .
docker-compose -f docker-compose-build.yml build
```

### Run image for arm32v6 on Raspberry Pi

Clone ```neochi-docker-dev-base``` repository from GitHub on your Pi.

```bash
git clone https://github.com/mpsamurai/neochi-docker-dev-base.git
cd neochi-docker-dev-base
```

#### Install docker to Pi

```bash
sudo ./docker-installer.sh
```

#### Pull and Run image on Pi

```bash
docker-compose -f docker-compose-pi.yml up
```

### x64 Image

If you can not install QEMU on your x64 computer, you can use x64-apline image.

```bash
docker pull mpsamurai/neochi-dev-base:20190424-x64
```

or 

```bash
docker-compose -f docker-compose-x64-alpine.yml up 
```
