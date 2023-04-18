#!/usr/bin/env bash

curl https://pyenv.run | bash
export PATH="$HOME/.pyenv/bin:$PATH" && eval "$(pyenv init --path)" && echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n eval "$(pyenv init -)"\nfi' >> ~/.bashrc
pyenv install 3.8.10
pyenv global 3.8.10
python --version 
exec $SHELL
