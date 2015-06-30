#### Config file
# Sets application config parameters depending on `env` name
exports.setEnvironment = (env) ->
  console.log "set app environment: #{env}"
  switch(env)
    when "development"
      exports.DEBUG_LOG = true
      exports.DEBUG_WARN = true
      exports.DEBUG_ERROR = true
      exports.DEBUG_CLIENT = true
      exports.DB_HOST = process.env.STARTAPP_MONGODB_HOST
      exports.DB_PORT = process.env.STARTAPP_MONGODB_PORT
      exports.DB_NAME = process.env.STARTAPP_MONGODB_DATABASE
      exports.DB_USER = process.env.STARTAPP_MONGODB_USER
      exports.DB_PASS = process.env.STARTAPP_MONGODB_PASS

    when "testing"
      exports.DEBUG_LOG = true
      exports.DEBUG_WARN = true
      exports.DEBUG_ERROR = true
      exports.DEBUG_CLIENT = true

    when "production"
      exports.DEBUG_LOG = false
      exports.DEBUG_WARN = false
      exports.DEBUG_ERROR = true
      exports.DEBUG_CLIENT = false
      exports.DB_URI = process.env.OPENSHIFT_MONGODB_DB_URL
      console.log "environment #{env} not found"
