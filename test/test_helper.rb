require 'coveralls'
require 'simplecov'

Coveralls.wear!
SimpleCov.start

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'miniharvest'
require 'minitest/autorun'
require 'minitest/pride'

