# typora :warning: draft

[Typora](https://typora.io/) gives you a seamless experience as both a reader and a writer. It removes the preview window, mode switcher, syntax symbols of markdown source code, and all other unnecessary distractions. Instead, it provides a real live preview feature to help you concentrate on the content itself.

## Build

```shell script
docker build -t ware/typora  .
```

## Usage

```shell script
docker run --rm \
--volume /tmp/.X11-unix:/tmp/.X11-unix \
--volume ~/workspace:/home/workspace \
ware/typora 
```

Got error:

```shell script
Failed to move to new namespace: PID namespaces supported, Network namespace supported, but failed: errno = Operation not permitted
Trace/breakpoint trap (core dumped)
```
Above, we made the container's processes interactive, forwarded our DISPLAY environment variable, mounted a volume for the X11 unix socket, and recorded the container's ID. This will fail at first and look something like this, but that's ok:

```shell script
No protocol specified
Error: Unable to initialize GTK+, is DISPLAY set properly?
```

We can then adjust the permissions the X server host.

```shell script
xhost +local:docker
```

**Optional:**

```shell script
docker run --rm \
--volume /tmp/.X11-unix:/tmp/.X11-unix \
--env DISPLAY=unix:$DISPLAY \
--env LANG=$LANG \
--env RUNUSER_UID=$(id -u) \
--volume ~/workspace:~/workspace:/home/workspace \
ware/kicad
```
