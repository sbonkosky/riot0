FROM raspbian/stretch

COPY /start_stream.sh /start_stream.sh
RUN chmod +x /start_stream.sh

RUN apt-get update \
    && apt-get install -y git \
    && apt-get install -y build-essential \
    && apt-get install -y --no-install-recommends libraspberrypi-bin \ 
    && apt-get install -y --no-install-recommends libraspberrypi-dev

RUN echo SUBSYSTEM=="vchiq",MODE="0666" > /etc/udev/rules.d/99-camera.rules

# Install dev version of libjpeg
RUN apt-get install -y libjpeg62-dev

# Install cmake
RUN apt-get install -y cmake

# Download mjpg-streamer with raspicam plugin
RUN git clone https://github.com/jacksonliam/mjpg-streamer.git ~/mjpg-streamer

# Change directory
# Compile
# Replace old mjpg-streamer
RUN cd ~/mjpg-streamer/mjpg-streamer-experimental \
    && make clean all \
    && rm -rf /opt/mjpg-streamer \
    && mv ~/mjpg-streamer/mjpg-streamer-experimental /opt/mjpg-streamer \
    && rm -rf ~/mjpg-streamer

# Begin streaming
ENTRYPOINT [ "/start_stream.sh" ]

# to have it stay running even if sh file is done
#CMD ["tail", "-f", "/dev/null"]