containerName=jovyan-single-use

 
if [[ $(docker ps -a --filter "status=created" | grep "$containerName") ]]; then
  
    echo "Your jovyan single use container is created. Start it.."; docker start $containerName
else
    if [[ $(docker ps -a --filter "status=exited" | grep "$containerName") ]]; then
  
        echo "Your jovyan single use container is stopped. Start it.."; docker start $containerName
    else
        if [[ $(docker ps | grep "$containerName") ]]; then
        echo "Your jovyan single use container is already running"

        fi
    fi
fi

if [[ ! $(docker ps | grep "$containerName") ]]; then
      echo "Your jovyan single use container is not found. Please, create it with 'create.sh' "
else
    # fix permissions
	docker exec -u 0:0 $containerName chown -R jovyan /tmp
	docker exec -u 0:0 $containerName chown -R jovyan /data

    # clean tmp if exists
	docker exec -u 0:0 $containerName bash -c 'rm -rf /tmp/*'
    
    echo "Please, follow the URL http://127.0.0.1:8888/lab to access your jovyan single use, by using CTRL key"
fi
