# docker run command:

```sh
docker run -d \
    --name ollama-proxy \
    -p 80:80 \
    -v ~/work/ollama-openwebui/nginx-docker/conf/nginx.conf:/etc/nginx/nginx.conf \
    -v ~/work/ollama-openwebui/nginx-docker/logs:/var/log/nginx \
    nginx
```

# creating a docker container for open web ui locally:
```sh
docker run -d  --network=host -e OLLAMA_BASE_URL=http://11.0.0.2:11434 -v open-webui:/app/backend/data --name open-webui --restart always ghcr.io/open-webui/open-webui:main
```

