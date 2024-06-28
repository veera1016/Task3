#!/bin/sh

# # Generate required environment variables using Node.js crypto module
# export APP_KEYS=$(node -e "console.log(require('crypto').randomBytes(32).toString('hex'))")
# export API_TOKEN_SALT=$(node -e "console.log(require('crypto').randomBytes(16).toString('base64'))")
# export ADMIN_JWT_SECRET=$(node -e "console.log(require('crypto').randomBytes(16).toString('base64'))")
# export TRANSFER_TOKEN_SALT=$(node -e "console.log(require('crypto').randomBytes(16).toString('base64'))")

# Start Strapi application
exec "$@"
