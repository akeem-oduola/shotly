require 'rubygems'
require 'spork'
require "phantomjs"
require 'database_cleaner'

Spork.prefork do
  require "coveralls"
  require "phantomjs"
  Coveralls.wear!

  require "codeclimate-test-reporter"
  CodeClimate::TestReporter.start

  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'capybara/rspec'

  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  DatabaseCleaner.strategy = :truncation

  RSpec.configure do |config|
    config.mock_with :rspec
    config.include FactoryGirl::Syntax::Methods
    config.use_transactional_fixtures = true
    config.infer_base_class_for_anonymous_controllers = false
    config.order = "random"

    require "capybara/poltergeist"
    Capybara.javascript_driver = :poltergeist
    Capybara.register_driver :poltergeist do |app|
      Capybara::Poltergeist::Driver.new(app,
                js_errors: true, port: 446_78 + ENV["RAILS_ENV"].to_i,
                  phantomjs_options: ["--proxy-type=none"], timeout: 180)
    end
  end
end

Spork.each_run do
  require "coveralls"
  require "phantomjs"
  Coveralls.wear!

  require "codeclimate-test-reporter"
  CodeClimate::TestReporter.start

  FactoryGirl.reload
  DatabaseCleaner.clean
end
