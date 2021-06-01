#!/bin/sh
# This is a wrapper script to ensure wp-cli can run as the www-data user in docker container
sudo -E -u www-data /bin/wp-cli.phar "$@"
