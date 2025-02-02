# Running OpenWebUI for OLLAMA and OpenAI with Caddy server! 

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


______
## Testing 

### Docker run command

#### Creating a docker container for open web ui locally:
```sh
docker run -d  --network=host -e OLLAMA_BASE_URL=http://11.0.0.2:11434 -v open-webui:/app/backend/data --name open-webui --restart always ghcr.io/open-webui/open-webui:main
```

