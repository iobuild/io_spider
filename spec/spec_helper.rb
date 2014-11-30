# -*- coding: utf-8 -*-

ENV['RACK_ENV'] = 'test'
require "bundler"
require './lib/io_spider'


Bundler.require(:default, :test)
