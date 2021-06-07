# ParentSquare Texting Service Interview Project

The ParentSquare SMS API is hosted at https://parentsquare-sms-api.herokuapp.com/

The app runs on Ruby 2.6.7 and Rails 6.1.3.2

## Table of Contents

* [Install Requirements](#install-requirements)
* [Running the app in Development](#running-the-app-in-development)

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

Open a port to accept incoming webhook requests locally. Then update the TextMessage model's CALLBACK_URL in app/models/text_message.rb, line 20.

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