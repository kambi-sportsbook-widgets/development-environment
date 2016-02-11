# development-environment
A set of tools for setting up development environment

This is a short guide about setting up Docker for a virtual machine development environment. It requires some bash and Apache knowledge

# Tested on OSX EL Capitan, Windows 10 only

## TODO: Verify installation and setup on Windows and Linux machines

##Installation

1. install [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
2. Install [Docker](https://docs.docker.com/mac/)
3. Run Docker Quickstart Terminal after installation is complete
4. Run `docker-machine start default`
5. Run `eval $(docker-machine env)` on OSX,  `eval $("C:\Program Files\Docker Toolbox\docker-machine.exe" env default)` on Windows
6. Add to your `hosts` file this line `192.168.99.100 kambi-widgets.dev` - you can get your Docker ip by running `docker-machine config`
7. Run `docker-compose up -d`. `-d` parameter is optional, tells Docker to run in "detached" mode ( in background )

## Apache VirtualHost Configuration

To change virtualhost configuration, edit the file `apache/sites-enabled/widgets-vhost.conf`.
To add a virtualhost, add aliases as in the examples provided:
- `Alias /league "/var/www/git/league-widget/src/"`, where `/league` is the directory for the path "( kambi-widgets.dev/league )" set in `client-widgets.js`,
- `"/var/www/git/league-widget/src/"` points to project root in Docker Container.
- `/var/www/git` is configured as projects root on the Docker Virtual Machine, are set in `Dockerfile` and `docker-compose.yml` by default, should only be changed if you need to create another image, beside the default one (`globalmouth/apache24`)
- `league-widget/src` is the path to be added/changed

To apply the virtualhost configuration, stop the container (`docker stop kambi-container`) and start it again (`docker-compose up -d`). you can check anytime the current running containers with `docker ps`.

All the widgets, documentation-tools, widget-library..., should be on the same directory level, as well as this repository:

```
/Users/xyz/project/
+-- widget-library
+-- livenow-widget
+-- facebook-widget
+-- league-widget               <-- The new widget repository
+-- development-environment     <-- This repository
...
```

Files in this repository:
- `apache/sites-enabled/widgets-vhost.conf` - Holds the virtual host for apache, where we can add/remove widgets aliases
- `apache/httpd.conf` - a default Apache 2.4 configuration file, in which was included the linking to the vhosts file
- `docker-compose.yml` - configuration for running the Docker Container. It holds the port mapping ( 80:80 -> host port : docker port ), container name, volumes to be mounted on virtual machine
- `Dockerfile` - configuration for building Docker Image, should be only used if a new image is needed.

### TIPS:If you\'re using phpStorm/webStorm, install Docker support plugin, can be quite helpful
