#!/bin/bash
docker compose run --no-deps web rails new . --force --database=postgresql
sudo chown -R $USER:$USER .
docker compose build
rm config/database.yml
cp database.yml config/database.yml
