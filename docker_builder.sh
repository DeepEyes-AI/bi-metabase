docker rm -f metabase_builde
docker build -t metabase_builder:latest .
docker run -it \
    --name metabase_builder \
    --mount type=bind,source=$(pwd),target=/home/node \
    metabase_builder:latest bash