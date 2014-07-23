PWD=$(pwd)
docker run -d -v ${PWD}/log:/usr/local/var/log/couchdb -v ${PWD}/data:/usr/local/var/lib/couchdb -p 5984:5984 alexindigo/docker-couchdb
