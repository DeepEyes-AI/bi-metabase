docker rm -f bi_metabase
docker run -d -p 3000:3000 \
    --name bi_metabase \
    --env-file $(pwd)/env.stage \
    bi_metabase:latest
