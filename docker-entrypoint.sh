#!/bin/sh
set -e

DIR=/opt/eugenio/docker-entrypoint.d

if test -d "$DIR"
then
	# use run-parts from the debianutils package
	/bin/run-parts --verbose --regex '\.sh$' "$DIR" || exit 1
fi

exec "$@"
