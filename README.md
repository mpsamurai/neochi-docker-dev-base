# neochi-docker-dev-base

Neoch-Solver's development environment.

This image works on Raspberry Pi.

You can pull the image from Docker Hub [mpsamurai/neochi-dev-base
](https://hub.docker.com/r/mpsamurai/neochi-dev-base)

```bash
docker pull mpsamurai/neochi-dev-base
```

## Build Image

### Build image on Ubuntu

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

### Run image on Raspberry Pi

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
docker-compose up
```