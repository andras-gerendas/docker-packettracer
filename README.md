# Docker Packet Tracer

Running Packet Tracer in Docker requires a few configuration tricks, which are added in this Dockerfile.

Note that you need to supply your own Packet Tracer .deb in order to use this Dockerfile to avoid any licensing issues.

## Usage

Building the image (this example uses the file name packettracer.deb):

```
docker build --build-arg display=$DISPLAY --build-arg ptbin=packettracer.deb -t packettracer .
```

Running the image:

```
docker run --net=host packettracer
```
