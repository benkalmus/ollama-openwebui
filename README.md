# Running OpenWebUI for OLLAMA and OpenAI with Caddy server!

## Features:

- Caddy reverse proxy with HTTPS/SSL
- OpenWEBUI
- Load balance multiple ollama instances!
  - If one of your ollama servers is down, a backup will be used!
    - for example, if you shut down your home PC, but still want access to OpenWebUI

## Prereqs

- Access to docker and docker images (may need to login to docker and github)
- domain name (please remember to rename all instances in this repo)

- Run Ollama:
  - If already running, simply change haproxy.cfg to point to local instance (default is `127.0.0.1:11434` )
  - In my setup I am already running ollama ( `ollama serve` ) on a private network (`11.0.0.0:11434`).
  - Inside the `haproxy.cfg` file, you can change the servers that tells haproxy to pick to connect to OLLAMA.
    - [!NOTE] If you want to run ollama on another machine like me, make sure it is bound to 0.0.0.0 not 127.0.0.1 !! `OLLAMA_HOST=0.0.0.0:11434`
    - Append the following to `/etc/systemd/system/ollama.service` file:
    - Environment="OLLAMA_HOST=0.0.0.0:11434"

## Run

Simply run:

```sh
docker compose -f docker-compose.yml up -d
```

### Pulling models

You can open an interactive terminal within your Ollama docker container with:

```sh
docker exec -it ollama /bin/bash

# in container:
ollama pull <model-name>
# or run it
ollama list
ollama run <model-name>
```

## How this works?

Overview diagram:

```
Web → domain-name.com (Caddy)
    → OpenWebUI :8080
        → HAProxy :11444 (Load balance)
            → Primary: 11.0.0.2:11434 (My Home Ollama instance)
            → Fallback: :11333 (Docker Ollama running on this server)
```

```mermaid
graph TD
    A[Web] -->|domain-name.com| B[Caddy Proxy]
    B -->|:8080| C[OpenWebUI]
    C -->|:11444| D[HAProxy]
    D -->|Primary 11.0.0.2:11434| E[My Home PC Ollama]
    D -->|Fallback localhost:11333| F[Docker Ollama]
```

## Updating a docker image

OpenWebUI gets frequently updated, to load the latest changes you will need to temporarily down the container.

```sh
docker pull ghcr.io/open-webui/open-webui:main
# after docker downloads the new container, remember to run:
docker compose down
docker compose up -d
#  NOTE: `docker compose restart` will not use the new image
```

---

## Testing

### Docker run command

#### Creating a docker container for open web ui locally:

```sh
docker run -d  --network=host -e OLLAMA_BASE_URL=http://11.0.0.2:11434 -v open-webui:/app/backend/data --name open-webui --restart always ghcr.io/open-webui/open-webui:main
```

---

## TODOs:

- Logging: currently a little lackluster when debugging
- Add GPU capabilities to docker compose

# Enabling Additional Features

### Ollama env

By default ollama keeps a model in memory for 5 mins, This can be a little short.
Add the following to `/etc/systemd/system/ollama.service`

```sh
Environment="OLLAMA_KEEP_ALIVE=10m"
```

### OpenAI

https://api.openai.com/v1
alloy
tts-1

### Text to speech (kokoro)

---

## Troubleshooting

Don't forget to allow firewall (e.g. jupyterlab) between the docker internal networks and host.
If you're not sure, you can always inspect with `tcpdump -i any port N -nn`

```sh
sudo ufw allow from 172.18.0.0/16 to any port 11469 proto tcp
```
