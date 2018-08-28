#!/bin/bash
#Install NGINX from SourceCode

# cd /usr/src/nginx_build
# wget http://nginx.org/download/nginx-1.7.9.tar.gz

cd /usr/src/nginx_build
unzip ./nginx.zip
cd nginx-branches-*

./auto/configure --prefix=/opt/nginx
#--with-pcre --with-openssl-opt=no-krb5 --with-http_ssl_module --without-mail_pop3_module --without-mail_smtp_module --without-mail_imap_module --with-http_stub_status_module --with-http_secure_link_module --with-http_flv_module --with-http_mp4_module --with-http_sub_module --with-http_stub_status_module
#--add-module=../naxsi-core-*/naxsi_src --with-openssl
make && make install

sed -i '1s/^/daemon off;\n/' /opt/nginx/conf/nginx.conf
rm -f /usr/sbin/nginx
ln -s /opt/nginx/sbin/nginx /usr/sbin/nginx
