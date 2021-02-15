# PHP Docker image

## Components

- PHP 7.3
- FFmpeg
- ImageMagick (HEIC support)
- Node.js 14

### PHP extensions

- gd
- exif
- pdo_mysql
- pcntl
- zip
- imagick
- redis

## Environment variables

| Parameter                   | Description                                                  |
| :-------------------------- | :----------------------------------------------------------- |
| `TZ`                        | Time zone (default: `Asia/Seoul`)                            |
| `DOCUMENT_ROOT`             | Apache DocumentRoot (default: `/var/www/html`)               |
| `XDEBUG_MODE`               | xdebug.mode (default: `debug`)                               |
| `XDEBUG_START_WITH_REQUEST` | xdebug.start_with_request (default: `yes`)                   |
| `XDEBUG_CLIENT_PORT`        | xdebug.client_port (default: `9000`)                         |
| `XDEBUG_CLIENT_HOST`        | xdebug.client_host (default: `docker.for.win.host.internal`) |
| `XDEBUG_IDEKEY`             | xdebug.idekey (default: `VSCODE`)                            |
