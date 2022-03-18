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
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/oscar/3drobot/src/mpu_6050_imu"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/oscar/3drobot/install/lib/python3/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/oscar/3drobot/install/lib/python3/dist-packages:/home/oscar/3drobot/build/lib/python3/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/oscar/3drobot/build" \
    "/usr/bin/python3" \
    "/home/oscar/3drobot/src/mpu_6050_imu/setup.py" \
     \
    build --build-base "/home/oscar/3drobot/build/mpu_6050_imu" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/oscar/3drobot/install" --install-scripts="/home/oscar/3drobot/install/bin"
