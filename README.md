# README

Just a super simple rails app to try out GitHub oauth2. Everything is self implemented with HTTP requests for better understanding. This shouldn't be used for production, instead use on of the many oauth2 gems out there :smile:

## Setup

You need to have [ngrok](https://ngrok.com/) installed in development to expose the app to the internet for the GitHub callbacks.

## Rails app
- ``bundle install``
- ``rails s``
- Expose the rails app to the internet with ``ngrok http 3000``
- Take the ngrok URL you got and enter it in ``app/controllers/index_controller.rb`` ``BASE_URL``

### GitHub
- GitHub -> Settings -> Developer Settings -> OAuth apps
- New OAuth App
- Fill out the form (Homepage url is the URL you got from ngrok, authorization callback URL is the ngrok URL + ``/callback``)
- Take the credentials and add them also to the ``app/controllers/index_controller.rb`` and enter ``CLIENT_ID`` and ``CLIENT_SECRET``
- Surf to ``localhost:3000/login`` and click on ``Login with GitHub``
