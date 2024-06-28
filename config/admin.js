module.exports = ({ env }) => ({
  auth: {
    secret: env('ADMIN_JWT_SECRET','GW9n5AREUXe9rUJNoEljHA=='),
  },
  apiToken: {
    salt: env('API_TOKEN_SALT','U8U2UYNVZESGpVKlr6hYBA=='),
  },
  transfer: {
    token: {
      salt: env('TRANSFER_TOKEN_SALT','EP3S7sG+w86M5MF3l+eSVA=='),
    },
  },
  flags: {
    nps: env.bool('FLAG_NPS', true),
    promoteEE: env.bool('FLAG_PROMOTE_EE', true),
  },
});
