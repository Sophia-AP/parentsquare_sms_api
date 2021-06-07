# ParentSquare Texting Service Interview Project

The ParentSquare SMS API is hosted at [parentsquare-sms-api.herokuapp.com](https://parentsquare-sms-api.herokuapp.com/)

The app runs on Ruby 2.6.7 and Rails 6.1.3.2

## Table of Contents

* [Install Requirements](#install-requirements)
* [Running the app in Development](#running-the-app-in-development)
* [Engaging with the API](#engaging-with-the-api)

## Install requirements

Ruby version management tools
  [RVM](https://rvm.io/rvm/install)
  ```
  $ \curl -sSL https://get.rvm.io | bash -s stable
  ```
  or
  [rbenv](https://github.com/rbenv/rbenv)
  ```
  $ brew install rbenv
  $ rbenv init
  ```

[Homebrew](https://brew.sh/)
```
$ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

Ruby 2.6.7
```
$ rvm install 2.6.7
```
or
```
$ rbenv install 2.6.7
$ rbenv rehash
```

Bundler
```
$ gem install bundler
$ bundle install
```

Ngrok
```
$ brew install ngrok
```

## Running the app in development

Set the Ruby version from the project's directory

```
$ rvm use 2.6.7
```
or
```
$ rbenv local 2.6.7
```

Open a port to accept incoming webhook requests locally.
Then update the TextMessage model's CALLBACK_URL in [app/models/text_message.rb](https://github.com/Sophia-AP/parentsquare_sms_api/blob/acd853c96ce82bf6e4f543a7a598f9bbb88dee13/app/models/text_message.rb#L22), line 22.

```
$ ngrok http 3000
```

Start the app locally

```
$ rails server
```

or, for short, just use

```
$ rails s
```

The app should now be running.
You can create and send messages in the browser by hitting http://localhost:3000/text_messages/new

Alternatively, you can POST messages to the JSON API directly at http://localhost:3000/text_messages/create.json

## Engaging with the API

You can interact with the application by POST-ing directly to http://localhost:3000/text_messages or  https://parentsquare-sms-api.herokuapp.com/text_messages

or

through a web browser by hitting http://localhost:3000/ or https://parentsquare-sms-api.herokuapp.com/ where you will see all text messages that have been sent.

If you'd like to send a new message, simply click the "New SMS" link and submit the form. The API response is in JSON format. To view the status of the webhook response, go back to the index page.