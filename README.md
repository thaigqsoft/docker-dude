Howto run
#clone data from github \
git clone https://github.com/thaigqsoft/docker-dude.git  docker-dude
cd  docker-dude

##build from script Docker \
docker build -t mikrotik-the-dude . \

####RUN CMD   \
    docker run --name dude \\\
      --privileged \\\
      --detach \\\
      --volume /etc/localtime:/etc/localtime:ro \\\
      --publish 2211:2211 \\\
      --publish 2210:2210 \\\
      --publish 514:514/udp \\\
      mikrotik-the-dude:latest \


#####and your Dude is ready. You can stop it with

    docker stop dude

######and run it again with

    docker start dude
