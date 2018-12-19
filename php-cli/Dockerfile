FROM php:7.1.25-cli-stretch

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        apache2-utils \
        git \
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
        mercurial \
        patch \
        ssh-client \
        subversion \
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

ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME /tmp
ENV COMPOSER_SHA384 93b54496392c062774670ac18b134c3b3a95e5a5e5c8f1a9f115f203b75bf9a129d5daa8ba6a13e2cc8a1da0806388a8
ENV COMPOSER_VERSION 1.6.5
ENV PHP_CONFDIR=/usr/local/etc/php/conf.d
ENV PHP_CONFIG_REGISTER_GLOBALS=Off
ENV PHP_CONFIG_ALLOW_URL_FOPEN=On
ENV PHP_CONFIG_ALLOW_URL_INCLUDE=Off
ENV PHP_CONFIG_MAGIC_QUOTES_GPC=On
ENV PHP_CONFIG_EXPOSE_PHP=On
ENV PHP_CONFIG_MBSTRING_FUNC_OVERLOAD=0
ENV PHP_CONFIG_MEMORY_LIMIT=-1
ENV PHP_CONFIG_MAX_EXECUTION_TIME=0
ENV PHP_CONFIG_UPLOAD_MAX_FILESIZE=2M
ENV PHP_CONFIG_MAX_FILE_UPLOADS=20
ENV PHP_CONFIG_MAX_INPUT_VARS=1000
ENV XDEBUG_IDE_KEY=docker
ENV XDEBUG_REMOTE_HOST=localhost
ENV XDEBUG_REMOTE_PORT=9000
ENV XDEBUG_PROFILER_ENABLE=Off

RUN { \
    echo "date.timezone=\${PHP_TIMEZONE:-UTC}"; \
    echo; \
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

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php -r "if (hash_file('SHA384', 'composer-setup.php') === getenv('COMPOSER_SHA384')) { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
    && php composer-setup.php --install-dir=/usr/local/bin --filename=composer --version=${COMPOSER_VERSION} \
    && php -r "unlink('composer-setup.php');"
