#!/bin/bash
set -e

# usage: file_env VAR [DEFAULT]
#    ie: file_env 'XYZ_DB_PASSWORD' 'example'
# (will allow for "$XYZ_DB_PASSWORD_FILE" to fill in the value of
#  "$XYZ_DB_PASSWORD" from a file, especially for Docker's secrets feature)
file_env() {
	local var="$1"
	local fileVar="${var}_FILE"
	local def="${2:-}"
	if [ "${!var:-}" ] && [ "${!fileVar:-}" ]; then
		echo >&2 "error: both $var and $fileVar are set (but are exclusive)"
		exit 1
	fi
	local val="$def"
	if [ "${!var:-}" ]; then
		val="${!var}"
	elif [ "${!fileVar:-}" ]; then
		val="$(< "${!fileVar}")"
	fi
	export "$var"="$val"
	unset "$fileVar"
}

file_env 'TZ' 'Asia/Seoul'
ln -snf /usr/share/zoneinfo/$TZ /etc/localtime
echo $TZ > /etc/timezone
echo date.timezone = $TZ > /usr/local/etc/php/conf.d/docker-php-ext-timezone.ini

file_env 'XDEBUG_MODE' 'develop,debug'
file_env 'XDEBUG_START_WITH_REQUEST' 'trigger'
file_env 'XDEBUG_CLIENT_PORT' '9000'
file_env 'XDEBUG_CLIENT_HOST' 'host.docker.internal'
file_env 'XDEBUG_FILE_LINK_FORMAT' ''
file_env 'XDEBUG_IDEKEY' 'VSCODE'
echo "xdebug.mode=$XDEBUG_MODE" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
echo "xdebug.start_with_request=$XDEBUG_START_WITH_REQUEST" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
echo "xdebug.client_port=$XDEBUG_CLIENT_PORT" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
echo "xdebug.client_host=$XDEBUG_CLIENT_HOST" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
echo "xdebug.log=/var/log/xdebug.log" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
echo "xdebug.file_link_format=\"$XDEBUG_FILE_LINK_FORMAT\"" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
echo "xdebug.idekey=$XDEBUG_IDEKEY" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

file_env 'DOCUMENT_ROOT' '/var/www/html'
sed -i "s@DocumentRoot .*@DocumentRoot $DOCUMENT_ROOT@g" /etc/apache2/sites-available/000-default.conf

exec apache2-foreground
