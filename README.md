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
6. Add this line to your `hosts` file `192.168.99.100 kambi-widgets.dev` - you can get your Docker ip by running `docker-machine config`
7. Navigate to the folder where you've checked out the development-environment
8. Create the .env file in the section below
9. Run `docker-compose up -d`. `-d` parameter is optional, tells Docker to run in "detached" mode ( in background )

## Apache VirtualHost Configuration

a. To change virtualhost configuration, add a file named `.env` to the root of this project with contents based on the following example.

__`.env`__

```

WIDGET1=livenow-widget/src/
WIDGET2=combo-widget/src/
WIDGET3=single-liveevent-widget/src/
WIDGET4=poll-widget/src/
LIBRARY=/var/www/git/widget-library/
TRANSLATE=/var/www/git/widget-core-translate/

```

The example above follows specifies apache environments variables ( key, value -> PARAM=VALUE ). The .env file is ignored in git and should not be commited.

b. To assign a widget (league-widget) to the `WIDGET1` iframe for example, simply specify the repository name ( `league-widget` ) followed by `/src/` for source files or `/dist/` for the compiled widget.

c. Apply the virtualhost configuration by stopping the container (`docker stop kambi-container`) and starting it again (`docker-compose up -d`).
You can check anytime the current running containers with `docker ps -a`.

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
