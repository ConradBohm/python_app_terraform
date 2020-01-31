#!/bin/bash

cd /home/ubuntu/appjs
sudo npm install
export DB_HOST=mongodb://${db_priv_ip}:27017/posts
node seeds/seed.js
node app.js
