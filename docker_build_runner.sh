docker rm -f bi_metabase_2
docker run -d -p 3001:3000 \
    --name bi_metabase_2 \
    --env-file $(pwd)/env.stage \
    metabase/metabase:latest
