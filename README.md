need to make sure raspi-config is set to enable the camera on the HOST before this will work

move code from mac to pi (from mac, be in Projects folder):
scp -r riot0 pi@192.168.1.183:

build on pi
docker build -t riot0 riot0/

run on pi
docker run --device /dev/vchiq --device=/dev/vcsm -v /opt/vc:/opt/vc --env LD_LIBRARY_PATH=/opt/vc/lib --name riot0 -d -p 8080:8080 riot0

run portainer
docker run -d -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer:linux-arm

ssh to a given container
docker exec -it _container_name_ /bin/bash

to monitor the pi itself
docker run --device=/dev/vchiq \
--device=/dev/vcsm \
--volume=/opt/vc:/opt/vc \
--volume=/boot:/boot \
--volume=/sys:/dockerhost/sys:ro \
--volume=/etc:/dockerhost/etc:ro \
--volume=/proc:/dockerhost/proc:ro \
--volume=/usr/lib:/dockerhost/usr/lib:ro \
-p=8888:8888 \
--name="rpi-monitor" \
-d \
michaelmiklis/rpi-monitor:latest


install node in raspbian image
# RUN apt-get update
# RUN apt-get install -y libatomic1
# RUN wget https://nodejs.org/dist/v12.18.3/node-v12.18.3-linux-armv7l.tar.xz
# RUN tar -xf node-v12.18.3-linux-armv7l.tar.xz
# # have the && because cd wont follow you on the next RUN command. Each command executed in separate bash
# RUN cd node-v12.18.3-linux-armv7l/ \
#     && chown -R $(whoami) /usr/local/bin \
#     && cp -R * /usr/local/