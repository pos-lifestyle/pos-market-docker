FROM php:7.1.18-cli-stretch

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
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
ENV COMPOSER_SHA384 544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061
ENV COMPOSER_VERSION 1.6.5
ENV PHP_CONFDIR=/usr/local/etc/php/conf.d
ENV XDEBUG_IDE_KEY=docker
ENV XDEBUG_REMOTE_HOST=localhost
ENV XDEBUG_REMOTE_PORT=9000
ENV XDEBUG_PROFILER_ENABLE=Off

RUN { \
    echo "memory_limit=-1"; \
    echo; \
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
} | tee "${PHP_CONFDIR}/pos-market.ini"

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php -r "if (hash_file('SHA384', 'composer-setup.php') === getenv('COMPOSER_SHA384')) { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
    && php composer-setup.php --install-dir=/usr/local/bin --filename=composer --version=${COMPOSER_VERSION} \
    && php -r "unlink('composer-setup.php');"
