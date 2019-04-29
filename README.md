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

## How to construct your own development environment on your x64 PC.

1. Clone a neochi solver's component repository and move to the directory,
2. Create ```Dockerfile``` and ```.dockerignore``` files,
3. Set ```mpsamurai/neochi-dev-base:20190424-x64``` as the base image,
4. Do something necessary in the ```Dockerfile```,
5. Create ```docker-compose.yml``` like ```docker-compose-x64.yml```,
6. Build and run it.

### Example of Dockerfile

```dockerfile
FROM mpsamurai/neochi-dev-base:20190424-x64

COPY ./requirements.txt /tmp
RUN pip install --no-cache-dir -r /tmp/requirements.txt && rm /tmp/requirements.txt

WORKDIR /code
COPY ./src:/code

CMD ["nosetests", "--with-coverage", "--cover-html", "--cover-package", "neochi"]
```

### Example of docker-compose.yml

```yaml
version: "3"

services:
  redis:
    image: redis
    ports:
      - 6379:6379
  neochi:
    build:
      context: .
      dockerfile: Dockerfile-x64
    volumes:
      - ./src:/code
      - /path/to/neochi-core/src/neochi:/code/neochi
    depends_on:
      - redis
```
