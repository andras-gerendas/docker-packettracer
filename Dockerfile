FROM ubuntu:20.04

# $DISPLAY from the host
ARG display
# Packet Tracer binary file. You have to download this yourself.
ARG ptbin

ENV DEBIAN_FRONTEND=noninteractive

VOLUME $HOME/.Xauthority:/home/pt/.Xauthority:rw
VOLUME /tmp/.X11-unix:/tmp/.X11-unix

# The package setup of ca-certificates fails if installed as a dependency
# Qt needs a platform plugin in order to start
RUN apt update && apt install -y ca-certificates qtwayland5

COPY $ptbin .

# Accepting the EULA and installing Packet Tracer
RUN echo packettracer PacketTracer_800_amd64/accept-eula select true | debconf-set-selections
RUN apt install -y --no-install-recommends /$ptbin

RUN useradd pt && mkhomedir_helper pt
USER pt

ENV DISPLAY="unix$display"
ENV LD_LIBRARY_PATH=/opt/pt/bin

CMD ["/opt/pt/bin/PacketTracer"]
