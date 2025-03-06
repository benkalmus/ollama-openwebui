#! /bin/bash
set -o pipefail

# pulls latest image of openwebui
# restarts container
docker pull ghcr.io/open-webui/open-webui:main &&
    docker compose down &&
    docker compose up -d

# TODO: run on cron and automatically update if there's a new latest version
