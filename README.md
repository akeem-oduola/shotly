[![Circle CI](https://circleci.com/gh/andela-aoduola/shotly.svg?style=svg)](https://circleci.com/gh/andela-aoduola/shotly)
[![Coverage Status](https://coveralls.io/repos/andela-aoduola/shotly/badge.svg?branch=master&service=github)](https://coveralls.io/github/andela-aoduola/shotly?branch=master)

# README
## Overview

The need to have short, easy-to-remember urls is the main major motivation behind Shotly. The app enable users create short, simple memorable urls, for various engagements on the internet. It provides a free, flexible customization options such that users get to decide what they want their shortened url to be. Long, complex urls can be shortened to just a single digit or letter using Shotly.

Shotly elegantly and seamlessly redirects request to any shortened url to their original target url; while also keeping tabs of the visitors statistics.

Users can manage their url. Users can redirect the target of their shortened url, deactivate and/or delete their them. Requests to deactivated and/or deleted shortened url will redirected with the appropriate error message.

## Using the Application

### Dependencies

Shotly is built with the Rails framework (version 4.2.4) using the Ruby programming language (version 2.2.3). Chances are you already have Ruby and Rails installed. You can run __which ruby__ and __which rails__ to check for their installation.

*   if Ruby is not installed checkout the [ruby installation guide](https://www.ruby-lang.org/en/downloads/) for guidelines to setup Ruby on your machine
*   if Rails is not installed checkout the [Rails installation guide](http://rubyonrails.org/download/) for guidelines to setup rails on you machine.

Also check for and confirm the [installation of gem](http://guides.rubygems.org/rubygems-basics/) and [bundler](http://rubygems.org) on your machine. These will allow you install other libraries ( _gems_ ) required by Shotly.

### Running the application

First [clone this repo](clone). Then from your terminal (or command prompt) navigate to the folder where you have cloned Shotly( __cd path/to/shotly/__ ).

*   Run __bundle install__ to install all Shotly dependencies.
*   Run __rake db:migrate__ to setup the app database
*   Run __rails server__ to start the rails server

You now good to go. Visit the app on your browser to use Shotly (localhost:3000)

### Running the tests

Shotly prides it's self in being fully tested. Shotly is tested using [rspec](http://rspec.info/), [capybara](http://jnicklas.github.io/capybara/), [faker](https://github.com/stympy/faker) and [factory_girl](http://www.rubydoc.info/gems/factory_girl/file/GETTING_STARTED.md) gems. To start the test, first migrate the test database by running __rake db:migrate__. Next run __bin/rspec spec__ to run all tests. You can also specify a particular test from the spec folder to run. Run tests with the _-fd_ flag to view the tests documentation.

## App features

*   Shortens users' url if no custom string is provided
*   Creates customized shortened url for users if given a custom string
*   Keeps tabs of most recent shortened urls
*   Keeps tabs of popular shortened urls
*   Provides visit statistics for registered users
*   Allows users to change the target of their shortened url
*   Allows users to deactivate their shortened url
*   Allows users to delete their shortened url

## Contributing
1. Fork the repo.
2. Run the tests. We only take pull requests with passing tests, and it's great
to know that you have a clean slate: `bundle && bundle exec rake`
3. Add a test for your change. Only refactoring and documentation changes
require no new tests. If you are adding functionality or fixing a bug, we need
a test!
4. Make the test pass.
5. Push to your fork and submit a pull request.
