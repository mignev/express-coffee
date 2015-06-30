express = require 'express'
stylus = require 'stylus'
assets = require 'connect-assets'
mongoose = require 'mongoose'
session = require('express-session')
cookieParser = require('cookie-parser')
bodyParser = require("body-parser")

#### Basic application initialization
# Create app instance.
app = express()

# Define Port & Environment
app.ip = process.env.OPENSHIFT_NODEJS_IP or "127.0.0.1"
app.port = process.env.OPENSHIFT_NODEJS_PORT or process.env.VMC_APP_PORT or 3000
env = process.env.NODE_ENV or "development"

# Config module exports has `setEnvironment` function that sets app settings depending on environment.
config = require "./config"
config.setEnvironment env

if config?.DB_URI?
  db_config = config.DB_URI
else
  db_config = "mongodb://#{config.DB_USER}:#{config.DB_PASS}@#{config.DB_HOST}:#{config.DB_PORT}/#{config.DB_NAME}"

# if env != 'production'
#   mongoose.connect 'mongodb://localhost/example'
# else
#   console.log('If you are running in production, you may want to modify the mongoose connect path')

#### View initialization
# Add Connect Assets.
app.use assets()
# Set the public folder as static assets.
app.use express.static(process.cwd() + '/public')

# Express Session
console.log "setting session/cookie"
app.use cookieParser()
app.use session(
  secret: "keyboard cat"
  key: "sid"
  cookie:
    secure: true
)

# Set View Engine.
app.set 'view engine', 'jade'

# [Body parser middleware](http://www.senchalabs.org/connect/middleware-bodyParser.html) parses JSON or XML bodies into `req.body` object
app.use bodyParser()


#### Finalization
# Initialize routes
routes = require './routes'
routes(app)


# Export application object
module.exports = app

