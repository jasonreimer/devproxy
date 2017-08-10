DevProxy
===

An nginx based proxy for working on javascript frontends (like react)

# Why?

I work on a few projects that have a strong separation of concerns between back-end and front-end. This means that
there's an API server that handles the data and there's a web server that serves the UI. In many cases, there are
multiple API servers based on environment such as development, testing, production, etc.

The UI's I work on are all react based and are webpack'd down to a bundle.js that is served from a simple webserver as
a static website. The problem that arises is that we typically build these UI's into a Docker container and if you
subscribe to the immutable infrastructure paradigms, you'll know that a container should be deployable into any
environment and be configured by environment variables.

Well, if you're building a static bundle.js that runs on the client, you can't configure anything about your frontend.
So how do you point that UI your dev API in one environment and the production API in another? You could build a
dev container and prod container, but that's kind of an anti-pattern. The common solution is to always run the API
and UI on the same domain so that all your UI calls are relative. *This also addresses the annoying CORS problems*

What about locally? You can't run the API on the same domain (usually `localhost`) because its a separate server. So you
change the API server in the `config.js` or whatever... but, if you change the config to develop locally, how likely are
you to remember to change it when you build for production?


That's what the DevProxy is for. The DevProxy runs on your local machine (via docker) and serves your API on one path
while serving your UI at the root. That way all development can point to the same domain name (`localhost`) and the proxy
takes care of sending the API calls to the correct backend (whether its dev, prod, or even running locally too!)

# Running the Proxy

## Configuration Environment Variables

  * API_HOST - the host where your api is located *default: localhost*
  * API_PORT - the port your api server is listening on *default: 8080*
  * UI_HOST - the host your UI server is listening on *default: localhost*
  * UI_PORT - the port your UI server is listening on *default: 3000*
  * SERVER_NAME - optional nginx server name *default: localhost*
  * API_PATH - the path your api responds on *default: /api*

## Example execution

The development API endpoint is located at http://development.com/api
The UI I'm working on is on http://localhost:3000

```
docker run \
  -p 9999:80 \
  -e API_HOST=development.com \
  -e API_PORT=80 \
  -e API_PATH='/api' \
  parabuzzle/devproxy:latest
```

Now I can browse to http://localhost:9999/api to interact with http://development.com/api...
and more importantly, I can visit http://localhost:9999 to see my local frontend that's running on port 3000.
