#!/bin/bash

# Tweak PATH for Travis
export PATH=$PATH:$HOME/gopath/bin

OPTIONS="-config=test-integration/dbconfig.yml -env sqlite"

set -ex

modl-migrate status $OPTIONS
modl-migrate up $OPTIONS
modl-migrate down $OPTIONS
modl-migrate redo $OPTIONS
modl-migrate status $OPTIONS

# Should have used the custom migrations table
sqlite3 test.db "SELECT COUNT(*) FROM migrations"
