docker start metabase_builder
docker exec metabase_builder bash /home/node/build.sh
docker stop metabase_builder
docker start bi_metabase
docker cp target/uberjar/metabase.jar bi_metabase:/app/
docker restart bi_metabase