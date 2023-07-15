#!/bin/bash

copy_dir() {
    mkdir $HOME/src
    mkdir -p $HOME/pix/wal
    $super cp src/wal1.png $HOME/pix/wal/
    $super cp -r src/dwm $HOME/src
    $super cp -r src/st $HOME/src
    $super cp -r src/dmenu $HOME/src
    $super cp -r src/scroll $HOME/src
    $super cp src/xinitrc $HOME/.xinitrc
}

make_install() {
    compile="$super make"
    install="$super make install"
    cd $HOME/src
    cd dwm && $compile && $install && cd ..
    cd dmenu && $compile && $install && cd ..
    cd scroll && $compile && $install && cd ..
    cd st && $compile && $install && cd ..

    echo && echo "Done."
    echo "You can edit the files in the home/(your username)/src folder."
    echo "Make sure you have picom, feh and xsetroot installed to use this rice!"
}

run_with_sudo() {
    copy_dir
    cd $HOME/src
    super=sudo
    make_install
}

run_with_doas() {
    copy_dir
    cd $HOME/src
    super=doas
    make_install
}

if command -v sudo >/dev/null 2>&1; then
    run_with_sudo
elif command -v doas >/dev/null 2>&1; then
    run_with_doas
else
    echo "ERROR: Neither sudo nor doas is available on this system." && echo
    exit 1
fi
