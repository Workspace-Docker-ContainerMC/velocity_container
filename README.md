
## Docker container JDK with Velocity ##
### About container: ###

This container is based on [ubi9-minimal](https://hub.docker.com/r/redhat/ubi9-minimal), and uses [eclipse-temurin 17 JDK](https://adoptium.net/temurin/releases/).
The container is built specifically for use as a minecraft proxy. [This issues](https://github.com/graalvm/container/issues/73) has been fixed in it.
This allows you to fully use it as a server container without errors related to some plugins.

All builds take place automatically without human intervention. If the [main repository](https://github.com/PaperMC/Velocity) is updated, the build process starts and you get the latest version.

### About configuration: ###

In ```entrypoint.sh```, the flags for launching are used with reference to [this](https://flags.sh/) website.

By default, containers are set to use 80% of the available RAM (using the parameters ```-XX:MaxRAMPercentage=80``` and ```-XX:MinRAMPercentage=80```). This percentage is based on the amount of RAM you specify when creating the container (via the ```--memory``` parameter or the ```memory``` setting in the ```deploy``` section of ```docker-compose```). This helps prevent RAM overflow. By default, these parameters are set to ```MaxRAMPercentage=25``` and ```MinRAMPercentage=50```, which does not allow for efficient use of the container's memory. For this reason, these parameters are explicitly defined in the ```entrypoint.sh``` file. Example: You specified in ```memory``` 1GB, Java will get 824MB.

Why is this better than specifying a variable? It simplifies the launch process and eliminates concerns about allocating too much or too little RAM. Java will automatically determine how much memory it can use based on the amount of memory allocated to the container.

**If you need to change the JDK or flags,** you need to create the container yourself. You can find out how to do this in the how to [build section](https://github.com/Workspace-Docker-ContainerMC/velocity_container?tab=readme-ov-file#build).

## Download ##
### How to download ###

Get docker image you can take [here](https://hub.docker.com/r/workspacedockermc/el9-java17-velocity)

Get the latest version сontainer:
```bash
docker pull workspacedockermc/el9-java17-velocity:latest
```

## Use ##
### How to use ###
You can run container with the docker command:
```
docker run --detach --name=proxy --interactive \
    --tty --restart=unless-stopped --publish 25565:25565/tcp \
    --cpus=2 --memory 5G --volume /home/$USER/server/proxy:/proxy:rw,Z \
    docker.io/workspacedockermc/el9-java17-velocity:latest
```

Or use [this](https://github.com/Workspace-Docker-ContainerMC/compose-files) docker-composes files:
```
docker-compose -f <NAME_DOCKER_COMPOSE_FILES> up -d
```

## Build ##
### How to build ###
Clone repo
```bash
git clone https://github.com/Workspace-Docker-ContainerMC/velocity_container
```

Go to directory
```bash
cd velocity_container
```

Get started build
```bash
docker build -t docker.io/$USER/el9-java17-velocity:latest .
```

## Contributer's & Credit's ##
### I express my gratitude to these projects: ###
- [Red Hat](https://github.com/RedHatOfficial)
- [GraalVM](https://github.com/graalvm)
- [Adoptium](https://github.com/adoptium)
- [Docker](https://docker.com)
- [PaperMC](https://github.com/PaperMC)
