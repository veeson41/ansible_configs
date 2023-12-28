#! /usr/bin/sh

env CGO_ENABLED=0 go install -ldflags="-s -w" github.com/gokcehan/lf@latest
#sudo cp /home/veeson/go/bin/lf /usr/bin 
#sudo rm -rf /home/veeson/go
