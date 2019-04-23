FROM ubuntu:18.04

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y python3-dev && \
    apt-get install -y python3-pip && \
    apt-get install -y build-essential cmake unzip pkg-config && \
    apt-get install -y libjpeg-dev libpng-dev libtiff-dev && \
    apt-get install -y libavcodec-dev libavformat-dev libswscale-dev libv4l-dev && \
    apt-get install -y libxvidcore-dev libx264-dev && \
    apt-get install -y libgtk-3-dev && \
    apt-get install -y libatlas-base-dev gfortran && \
    apt-get install -y wget

WORKDIR /tmp
COPY ./requirements.txt .
RUN pip3 install numpy
RUN wget -O opencv.zip https://github.com/opencv/opencv/archive/3.4.4.zip && \
    wget -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/3.4.4.zip && \
    unzip opencv.zip && \
    unzip opencv_contrib.zip && \
    mv opencv-3.4.4 opencv && \
    mv opencv_contrib-3.4.4 opencv_contrib

WORKDIR /tmp/opencv
RUN mkdir build

WORKDIR /tmp/opencv/build
RUN cmake -D CMAKE_BUILD_TYPE=RELEASE \
        -D CMAKE_INSTALL_PREFIX=/usr/local \
        -D INSTALL_PYTHON_EXAMPLES=OFF \
        -D INSTALL_C_EXAMPLES=OFF \
        -D OPENCV_ENABLE_NONFREE=OFF \
        -D OPENCV_EXTRA_MODULES_PATH=/tmp/opencv_contrib/modules \
        -D PYTHON2_EXECUTABLE=/usr/bin/python \
        -D PYTHON_EXECUTABLE=/usr/bin/python3 \
        -D BUILD_EXAMPLES=OFF ..
RUN make -j11 && make install && ldconfig
RUN ln -s /usr/local/python/cv2/python-3.6/cv2.cpython-36m-x86_64-linux-gnu.so /usr/local/python/cv2/python-3.6/cv2.so

RUN pip3 install -r requirements.txt

WORKDIR /code
RUN rm -Rf /tmp/*

COPY ./entrypoint.sh /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

CMD ["bash"]