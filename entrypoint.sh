#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid file for Rails
rm -f /app/tmp/pids/server.pid

# Check if the database exists and run migrations if it does
bundle exec rails db:prepare # Creates DB if needed, then runs migrations

# Then executes the main container command
exec "$@"