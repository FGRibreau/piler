express = require "express"
piles = require("../../index")

js = piles.createJSManager()
css = piles.createCSSManager()

isEmail = (s) ->
  not not s.match(/.\w+@\w+\.\w/)

app = express.createServer()
app.configure ->
   app.use express.static __dirname + '/clientscripts'

js.bind app
css.bind app

css.addFile __dirname + "/stylesheets/style.css"
css.addFile __dirname + "/stylesheets/style.styl"
css.addFile __dirname + "/stylesheets/style.less"


js.addOb "addOb global": true

js.addUrl "/remote.js"

js.addFile __dirname + "/clientscripts/jquery.js"
js.addFile __dirname + "/clientscripts/global.js"
js.addFile __dirname + "/clientscripts/global.coffee"

js.addFile "mynamespace", __dirname + "/clientscripts/namespace.js"


app.get "/namespace", (req, res) ->
  res.render "namespace.jade",
   layout: false



app.get "/", (req, res) ->
  res.exec ->
   window["response exec"] = true

  res.render "index.jade"

port = if process.env.NODE_ENV is "production" then 7001 else 7000

app.listen port
console.log "server running on port #{ port }"

