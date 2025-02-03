# Running OpenWebUI for OLLAMA and OpenAI with Caddy server! 

## Features:
- Caddy reverse proxy with HTTPS/SSL
- OpenWEBUI
- Load balance multiple ollama instances!
    - If one of your ollama servers is down, a backup will be used!
        - for example, if you shut down your home PC, but still want access to OpenWebUI

## Demo: 

[My self hosted ollama web UI.](https://manchesteriswindy.ddns.net) 

## Prereqs

Assumes you are already running ollama ( `ollama serve` ) on a private network (in my case 11.0.0.0).
Inside the compose file, you can change the environment variable that tells open-webui to connect to OLLAMA `OLLAMA_BASE_URL`.
- [!NOTE] If ollama is running somewhere else, make sure it is bound to 0.0.0.0 not 127.0.0.1 !!
    - Append the following to `/etc/systemd/system/ollama.service` file:
    - Environment="OLLAMA_HOST=0.0.0.0:11434"



## Run

Simply run: 
```sh
docker compose -f caddy-localopenweb.yml up -d
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


______
## Testing 

### Docker run command

#### Creating a docker container for open web ui locally:
```sh
docker run -d  --network=host -e OLLAMA_BASE_URL=http://11.0.0.2:11434 -v open-webui:/app/backend/data --name open-webui --restart always ghcr.io/open-webui/open-webui:main
```

