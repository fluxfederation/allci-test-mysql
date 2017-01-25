FROM ubuntu:14.04

RUN echo "deb mirror://mirrors.ubuntu.com/mirrors.txt trusty main restricted universe multiverse" > /etc/apt/sources.list && \
	echo "deb mirror://mirrors.ubuntu.com/mirrors.txt trusty-updates main restricted universe multiverse" >> /etc/apt/sources.list && \
	echo "deb mirror://mirrors.ubuntu.com/mirrors.txt trusty-security main restricted universe multiverse" >> /etc/apt/sources.list
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
	DEBIAN_FRONTEND=noninteractive apt-get -y upgrade && \
	DEBIAN_FRONTEND=noninteractive apt-get -y --no-install-recommends install mysql-server && \
	apt-get clean -y && \
	rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

COPY extra.cnf /etc/mysql/conf.d/extra.cnf
EXPOSE 3306

CMD ["/usr/sbin/mysqld", "--skip-grant-tables"]
