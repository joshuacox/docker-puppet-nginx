FROM    joshuacox/docker-puppet
MAINTAINER Josh Cox <josh 'at' webhosting coop>

RUN apt-get -y -q install wget git-core
ADD Puppetfile /
RUN librarian-puppet install
RUN puppet apply --pluginsync --modulepath=/modules -e "class { 'nginx': }"
RUN puppet apply --pluginsync --debug --verbose --modulepath=/modules -e "nginx::resource::vhost { 'localhost': www_root => '/var/www/',} "
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
EXPOSE 80
CMD ["nginx"]
