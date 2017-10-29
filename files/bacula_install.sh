#!/bin/bash

wget -qO- http://bacula.us/current | tar -xzvf - -C /usr/src
apt-get install -y build-essential libreadline6-dev zlib1g-dev liblzo2-dev mt-st mtx postfix libacl1-dev libssl-dev libmysql++-dev
cd /usr/src/bacula-9* && ./configure --with-readline=/usr/include/readline --disable-conio --bindir=/usr/bin --sbindir=/usr/sbin --with-scriptdir=/etc/bacula/scripts --with-working-dir=/var/lib/bacula --with-logdir=/var/log --enable-smartalloc --with-mysql --with-archivedir=/mnt/backup --with-job-email=your@email.com --with-hostname=`hostname`.bhp.org.bw
make -j8 && make install && make install-autostart
service bacula-fd start

