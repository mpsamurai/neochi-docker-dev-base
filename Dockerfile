FROM arm32v6/python:3.6-alpine

COPY qemu-arm-static /usr/bin/qemu-arm-static

WORKDIR /tmp
RUN apk update && apk upgrade && apk --no-cache add \
    --virtual=build-dependencies \
    build-base \
    clang \
    clang-dev ninja \
    cmake \
    freetype-dev \
    g++ \
    jpeg-dev \
    lcms2-dev \
    libffi-dev \
    libgcc \
    libxml2-dev \
    libxslt-dev \
    linux-headers \
    make \
    musl \
    musl-dev \
    openjpeg-dev \
    openssl-dev \
    zlib-dev && \
    apk add --no-cache \
    bash \
    curl \
    freetype \
    gcc \
    jpeg \
    libjpeg \
    openjpeg \
    tesseract-ocr \
    zlib \
    wget && \
    pip install numpy && \
    wget -O opencv.zip https://github.com/opencv/opencv/archive/3.4.4.zip && \
    wget -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/3.4.4.zip && \
    unzip opencv.zip && \
    unzip opencv_contrib.zip && \
    mv opencv-3.4.4 opencv && \
    mv opencv_contrib-3.4.4 opencv_contrib && \
    rm opencv.zip opencv_contrib.zip && \
    cmake -D CMAKE_BUILD_TYPE=RELEASE \
        -D CMAKE_INSTALL_PREFIX=/usr/local \
        -D INSTALL_PYTHON_EXAMPLES=OFF \
        -D INSTALL_C_EXAMPLES=OFF \
        -D OPENCV_ENABLE_NONFREE=OFF \
        -D OPENCV_EXTRA_MODULES_PATH=/tmp/opencv_contrib/modules \
        -D PYTHON_EXECUTABLE=/usr/local/bin/python \
        -D BUILD_EXAMPLES=OFF opencv &&\
    make -j11 && make install &&\
    ln -s /usr/local/python/cv2/python-3.6/cv2.cpython-36m-x86_64-linux-gnu.so /usr/local/python/cv2/python-3.6/cv2.so && \
    rm -Rf /tmp/*

COPY ./requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt && \
    rm requirements.txt

WORKDIR /code
COPY ./src /code/

COPY ./entrypoint.sh /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

CMD ["bash"]