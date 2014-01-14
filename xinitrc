emacs --daemon &

# xrandr --output eDP1 --auto --output DP1 --auto --left-of eDP1 &

xmodmap .xmodmap &

export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus
ibus-daemon --daemonize --xim &

wicd-client -t &
#nm-applet &
net agent &

# exec awesome
exec ck-launch-session startkde
