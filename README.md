## Docker container JDK with Velocity ##
### About the container: ###

This container is based on [ubi9-minimal](https://hub.docker.com/r/redhat/ubi9-minimal), and uses [graalvm-ce 17 JDK](https://www.graalvm.org).
The container is built specifically for use as a minecraft proxy. [This issues](https://github.com/graalvm/container/issues/73) has been fixed in it.
This allows you to fully use it as a server container without errors related to some plugins.

All builds take place automatically without human intervention. If the [main repository](https://github.com/PaperMC/Velocity) is updated, the build process starts and you get the latest version.

## Download ##
### How to download ###

Get docker image you can [here](https://hub.docker.com/r/workspacedockermc/el9-java17-velocity)

Get the latest version сontainer:
```bash
docker pull workspacedockermc/el9-java17-velocity:latest
```

## Contributer's & Credit's ##
### I express my gratitude to these projects: ###
- [Red Hat](https://github.com/RedHatOfficial)
- [GraalVM](https://github.com/graalvm)
- [Docker](https://docker.com)