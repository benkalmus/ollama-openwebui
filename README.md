# docker run command:

```sh
docker run -d \
    --name ollama-proxy \
    -p 80:80 \
    -v ~/work/ollama-openwebui/nginx-docker/conf/nginx.conf:/etc/nginx/nginx.conf \
    -v ~/work/ollama-openwebui/nginx-docker/logs:/var/log/nginx \
    nginx
```
