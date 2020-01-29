#!/bin/bash

cd /home/ubuntu/appjs
node seeds seed.js
sudo npm install
sudo npm start
