# PHP Docker image

## Components

- PHP 7
- FFmpeg
- ImageMagick (HEIC support)

### PHP extensions

- gd
- exif
- pdo_mysql
- pcntl
- zip
- imagick

## Environment variables

| Parameter                    | Description                                                  |
| :--------------------------- | :----------------------------------------------------------- |
| `TZ`                         | Time zone (default: `Asia/Seoul`)                            |
| `XDEBUG_REMOTE_ENABLE`       | xdebug.remote_enable (default: `1`)                          |
| `XDEBUG_REMOTE_AUTOSTART`    | xdebug.remote_autostart (default: `0`)                       |
| `XDEBUG_REMOTE_HANDLER`      | xdebug.remote_handler (default: `dbgp`)                      |
| `XDEBUG_REMOTE_CONNECT_BACK` | xdebug.remote_connect_back (default: `0`)                    |
| `XDEBUG_REMOTE_PORT`         | xdebug.remote_port (default: `9000`)                         |
| `XDEBUG_REMOTE_HOST`         | xdebug.remote_host (default: `docker.for.win.host.internal`) |
| `XDEBUG_IDEKEY`              | xdebug.idekey (default: `VSCODE`)                            |
