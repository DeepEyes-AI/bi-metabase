docker start metabase_builder
docker exec metabase_builder ./build.sh
docker stop metabase_builder
docker rm -f bi_metabase
docker build -f Dockerfile_run -t bi_metabase:latest .