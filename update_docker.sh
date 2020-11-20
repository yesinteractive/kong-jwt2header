#helpful script to deploy plugin to docker container

read -p "Enter container ID or name: "  container
#read -p "Enter working subdirectory /usr/local/share/lua/5.1/kong/plugins/"  dir
dir="kong-jwt2header" 

docker exec -it --user root $container mkdir /usr/local/share/lua/5.1/kong/plugins/$dir
echo "directory created or verified"
docker cp plugin/. $container:/usr/local/share/lua/5.1/kong/plugins/$dir
echo "contents copied to /usr/local/share/lua/5.1/kong/plugins/$dir"
docker exec --user root -e KONG_PLUGINS="bundled,$dir" $container kong reload -vv
echo "Kong restarted with $dir plugin enabled"
