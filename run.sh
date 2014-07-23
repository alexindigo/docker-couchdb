#!/bin/bash
BASEPATH=$(dirname $(perl -MCwd=realpath -e "print realpath '$0'"))

# if extra arguments present run it in interactive mode
# otherwise daemonize
if [ $# -eq 0 ]
then
RUN_MODE="-d"
else
RUN_MODE="-t -i"
fi

# run container
docker run ${RUN_MODE} --name couchdb -v ${BASEPATH}/log:/usr/local/var/log/couchdb -v ${BASEPATH}/data:/usr/local/var/lib/couchdb -p 5984:5984 alexindigo/couchdb "$@"
