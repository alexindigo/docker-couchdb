# alexindigo/couchdb
FROM  alexindigo/ubuntu-precise
MAINTAINER Alex Indigo <iam@alexindigo.com>

# URL, contains specific version
ENV COUCHDB_URL http://apache.tradebit.com/pub/couchdb/source/1.5.1/apache-couchdb-1.5.1.tar.gz

# couchdb deps
RUN apt-get install -y libmozjs185-dev libicu-dev libcurl4-gnutls-dev libtool \
                        erlang-base-hipe erlang-xmerl erlang-inets erlang-manpages erlang-dev erlang-nox erlang-eunit

# Fetch source code
RUN mkdir -p /opt/couchdb && \
    curl -s -o /opt/couchdb.tar.gz ${COUCHDB_URL} && \
    tar -C /opt/couchdb --strip-components 1 -xzf /opt/couchdb.tar.gz && \
    rm /opt/couchdb.tar.gz

# Build
RUN cd /opt/couchdb && \
    ./configure --prefix=/usr/local && \
    make && \
    make install && \
    rm -rf /opt/couchdb

# Configure
RUN cp /usr/local/etc/logrotate.d/couchdb /etc/logrotate.d/couchdb && \
    cp /usr/local/etc/init.d/couchdb /etc/init.d/couchdb && \
    update-rc.d couchdb defaults && \
    sed -i'' '/COUCHDB_USER=/d' /usr/local/etc/default/couchdb

# Reset DEBIAN_FRONTEND
ENV  DEBIAN_FRONTEND newt
