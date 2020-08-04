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

file_env 'XDEBUG_REMOTE_ENABLE' '1'
file_env 'XDEBUG_REMOTE_AUTOSTART' '0'
file_env 'XDEBUG_REMOTE_HANDLER' 'dbgp'
file_env 'XDEBUG_REMOTE_CONNECT_BACK' '0'
file_env 'XDEBUG_REMOTE_PORT' '9000'
file_env 'XDEBUG_REMOTE_HOST' 'docker.for.win.host.internal'
file_env 'XDEBUG_IDEKEY' 'VSCODE'
echo "xdebug.remote_enable=$XDEBUG_REMOTE_ENABLE" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
echo "xdebug.remote_autostart=$XDEBUG_REMOTE_AUTOSTART" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
echo "xdebug.remote_handler=$XDEBUG_REMOTE_HANDLER" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
echo "xdebug.remote_connect_back=$XDEBUG_REMOTE_CONNECT_BACK" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
echo "xdebug.remote_port=$XDEBUG_REMOTE_PORT" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
echo "xdebug.remote_host=$XDEBUG_REMOTE_HOST" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
echo "xdebug.remote_log=/var/log/xdebug.log" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
echo "xdebug.idekey=$XDEBUG_IDEKEY" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

file_env 'DOCUMENT_ROOT' '/var/www/html'
sed -i "s@DocumentRoot .*@DocumentRoot $DOCUMENT_ROOT@g" /etc/apache2/sites-available/000-default.conf

exec apache2-foreground
