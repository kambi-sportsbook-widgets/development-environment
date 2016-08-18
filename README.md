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
5. Run `eval $(docker-machine env)` and add it to `.bash_profile` on OSX, `eval $("C:\Program Files\Docker Toolbox\docker-machine.exe" env default)` on Windows
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
CORE_LIB=widget-core-library/src/
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

### TIPS:If you\'re using phpStorm/webStorm, install Docker support plugin, can be quite helpful.

### For debugging on mobile devices, yo can use [SquidMan](http://squidman.net/squidman/):
- Install Squidman
- In General tab, HTTP Port should be 8080.
- In Clients tab, add a new entry, containing ip range for your network, eg: '192.168.68.0/24'
- In Template tab, find the line `http_access deny to_localhost` and comment it out, so it becomes `#http_access deny to_localhost`
- Same Template tab, add `hosts_file /etc/hosts`
- On your mobile device, go to Wifi settings of the wifi network connected to and add a proxy ip address, which should point to the ip of your development machine, eg: `192.168.68.60`.
- If everything was set correctly, you should be able to access 'kambi-widgets-dev' from your mobile.

### Trust self signed certificate (OS X)
- Open `keychain Access`
- Select `System` in the keychains section and then select `Certificates` in the Category section
- Click the padlock in the upper left corner to enable changes
- In the File menu select `Import items` or press `Shift Cmd i`
- Navigate to the apache/ssl/ directory in this repository and select kambi-widgets.dev.cert
- Double click the cert in the list and expand the Trust section
- For the first option "When using this certificate" select "Always trust"
- Close the certificate window

You might need to open the url in a new window for the browser to pick up the changes
