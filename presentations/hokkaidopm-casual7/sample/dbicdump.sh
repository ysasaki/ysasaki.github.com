#!/bin/bash

carton exec -- dbicdump -o dump_directory=./sample/lib -o debug=1 D::Schema 'dbi:SQLite:dbname=sample/my.db'
