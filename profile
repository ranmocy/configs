# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022


if [ "$DESKTOP_SESSION" = "i3" ]; then
  export XMODIFIERS=@im=fcitx
  export XIM=fcitx
  export XIM_PROGRAM=fcitx
  export GTK_IM_MODULE=fcitx
  export QT_IM_MODULE=fcitx
fi

if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
    fi
fi
