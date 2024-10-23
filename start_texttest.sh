#!/bin/sh

if [ ! -d "venv" ]; then
    python3 -m venv venv
fi
. venv/bin/activate
venv/bin/pip install texttest
venv/bin/texttest -d . -con "$@"
