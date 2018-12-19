FROM php:7.1.25-fpm-stretch

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        libc-client-dev \
        libbz2-dev \
        libfreetype6-dev \
        libgmp-dev \
        libicu-dev \
        libjpeg62-turbo-dev \
        libldap2-dev \
        libmagickwand-dev \
        libmcrypt-dev \
        libpng-dev \
        libtidy-dev \
        libxml2-dev \
        libxslt1-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-install -j"$(nproc)" \
        bcmath \
        bz2 \
        calendar \
        dba \
        exif \
        gettext \
        gmp \
        intl \
        ldap \
        mcrypt \
        mysqli \
        pcntl \
        pdo_mysql \
        soap \
        sockets \
        sysvmsg \
        sysvsem \
        sysvshm \
        tidy \
        xmlrpc \
        xsl \
        zip \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j"$(nproc)" gd \
    && pecl install \
        imagick \
        oauth \
        redis \
        xdebug \
    && docker-php-ext-enable \
        imagick \
        oauth \
        redis \
        xdebug

ENV PHP_CONFDIR=/usr/local/etc/php/conf.d
ENV PHP_CONFIG_REGISTER_GLOBALS=Off
ENV PHP_CONFIG_ALLOW_URL_FOPEN=On
ENV PHP_CONFIG_ALLOW_URL_INCLUDE=Off
ENV PHP_CONFIG_MAGIC_QUOTES_GPC=On
ENV PHP_CONFIG_EXPOSE_PHP=On
ENV PHP_CONFIG_MBSTRING_FUNC_OVERLOAD=0
ENV PHP_CONFIG_MEMORY_LIMIT=128M
ENV PHP_CONFIG_MAX_EXECUTION_TIME=30
ENV PHP_CONFIG_UPLOAD_MAX_FILESIZE=2M
ENV PHP_CONFIG_MAX_FILE_UPLOADS=20
ENV PHP_CONFIG_MAX_INPUT_VARS=1000
ENV XDEBUG_IDE_KEY=docker
ENV XDEBUG_REMOTE_HOST=localhost
ENV XDEBUG_REMOTE_PORT=9000
ENV XDEBUG_PROFILER_ENABLE=Off

# XDEBUG configuration
RUN { \
    echo "xdebug.idekey=\${XDEBUG_IDE_KEY}"; \
    echo "xdebug.remote_enable=On"; \
    echo "xdebug.remote_connect_back=Off"; \
    echo "xdebug.remote_autostart=\${XDEBUG_REMOTE_AUTOSTART}"; \
    echo "xdebug.remote_host=\${XDEBUG_REMOTE_HOST}"; \
    echo "xdebug.remote_port=\${XDEBUG_REMOTE_PORT}"; \
    echo; \
    echo "xdebug.profiler_enable=\${XDEBUG_PROFILER_ENABLE}"; \
    echo "xdebug.profiler_enable_trigger=\${XDEBUG_PROFILER_ENABLE_TRIGGER}"; \
    echo "xdebug.profiler_enable_trigger_value=\${XDEBUG_PROFILER_ENABLE_TRIGGER_VALUE}"; \
    echo "xdebug.profiler_output_dir=\${XDEBUG_PROFILER_OUTPUT_DIR}"; \
    echo "xdebug.profiler_output_name=\${XDEBUG_PROFILER_OUTPUT_NAME}"; \
    echo; \
    echo "register_globals=\${PHP_CONFIG_REGISTER_GLOBALS}"; \
    echo "allow_url_fopen=\${PHP_CONFIG_ALLOW_URL_FOPEN}"; \
    echo "allow_url_include=\${PHP_CONFIG_ALLOW_URL_INCLUDE}"; \
    echo "magic_quotes_gpc=\${PHP_CONFIG_MAGIC_QUOTES_GPC}"; \
    echo "expose_php=\${PHP_CONFIG_EXPOSE_PHP}"; \
    echo "mbstring.func_overload=\${PHP_CONFIG_MBSTRING_FUNC_OVERLOAD}"; \
    echo "memory_limit=\${PHP_CONFIG_MEMORY_LIMIT}"; \
    echo "max_execution_time=\${PHP_CONFIG_MAX_EXECUTION_TIME}"; \
    echo "upload_max_filesize=\${PHP_CONFIG_UPLOAD_MAX_FILESIZE}"; \
    echo "max_file_uploads=\${PHP_CONFIG_MAX_FILE_UPLOADS}"; \
    echo "max_input_vars=\${PHP_CONFIG_MAX_INPUT_VARS}"; \
} | tee "${PHP_CONFDIR}/pos-market.ini"

USER www-data:www-data
