#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
    DESTDIR_ARG="--root=$DESTDIR"
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/vigneshnuc/laptop_ws/src/Sensors/nmea_navsat_driver"

# snsure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/vigneshnuc/laptop_ws/install/lib/python2.7/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/vigneshnuc/laptop_ws/install/lib/python2.7/dist-packages:/home/vigneshnuc/laptop_ws/build/lib/python2.7/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/vigneshnuc/laptop_ws/build" \
    "/usr/bin/python" \
    "/home/vigneshnuc/laptop_ws/src/Sensors/nmea_navsat_driver/setup.py" \
    build --build-base "/home/vigneshnuc/laptop_ws/build/Sensors/nmea_navsat_driver" \
    install \
    $DESTDIR_ARG \
    --install-layout=deb --prefix="/home/vigneshnuc/laptop_ws/install" --install-scripts="/home/vigneshnuc/laptop_ws/install/bin"
