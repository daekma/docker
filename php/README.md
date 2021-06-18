# PHP Docker image

## Components

-   FFmpeg
-   ImageMagick (HEIC support)
-   Node.js 14

### PHP extensions

-   gd
-   exif
-   pdo
-   pdo_mysql
-   pdo_sqlsrv
-   pcntl
-   imagick
-   xdebug
-   zip
-   redis
-   opcache
-   apcu
-   intl

## Environment variables

| Parameter                   | Description                                                  |
| :-------------------------- | :----------------------------------------------------------- |
| `TZ`                        | Time zone (default: `Asia/Seoul`)                            |
| `DOCUMENT_ROOT`             | Apache DocumentRoot (default: `/var/www/html`)               |
| `XDEBUG_MODE`               | xdebug.mode (default: `develop,debug`)                       |
| `XDEBUG_START_WITH_REQUEST` | xdebug.start_with_request (default: `trigger`)               |
| `XDEBUG_CLIENT_PORT`        | xdebug.client_port (default: `9003`)                         |
| `XDEBUG_CLIENT_HOST`        | xdebug.client_host (default: `docker.for.win.host.internal`) |
| `XDEBUG_IDEKEY`             | xdebug.idekey (default: `VSCODE`)                            |
