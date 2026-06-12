if [ -f "$HOME/.profile" ]; then
    . "$HOME/.profile"
fi

if command -v fish >/dev/null 2>&1; then
    exec fish
fi
