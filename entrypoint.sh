#!/usr/bin/env sh

set -euo pipefail

openssl enc -d -aes256 -pbkdf2 -in ${environment}.enc --pass pass:$pass | tar x -C /app/config/

exec "$@"
