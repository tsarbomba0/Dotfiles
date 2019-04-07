#!/bin/bash

pwdold=$(pwd)
cd /home/comfy/st
sudo make clean install >/tmp/make.st.log 2>/tmp/make.st.error 
cd $pwdold
unset pwdold
