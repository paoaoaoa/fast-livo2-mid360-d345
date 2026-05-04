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

echo_and_run cd "/home/zyh/fast_livo2_mid360_ws/src/rpg_vikit/vikit_py"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/zyh/fast_livo2_mid360_ws/install/lib/python3/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/zyh/fast_livo2_mid360_ws/install/lib/python3/dist-packages:/home/zyh/fast_livo2_mid360_ws/build/lib/python3/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/zyh/fast_livo2_mid360_ws/build" \
    "/usr/bin/python3" \
    "/home/zyh/fast_livo2_mid360_ws/src/rpg_vikit/vikit_py/setup.py" \
     \
    build --build-base "/home/zyh/fast_livo2_mid360_ws/build/rpg_vikit/vikit_py" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/zyh/fast_livo2_mid360_ws/install" --install-scripts="/home/zyh/fast_livo2_mid360_ws/install/bin"
