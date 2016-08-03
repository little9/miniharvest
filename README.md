# MiniHarvest

[![Build Status](https://travis-ci.org/little9/miniharvest.svg?branch=master)](https://travis-ci.org/little9/miniharvest)

MiniHarvest is used to harvest sets of MARCXML records from an OAI-PMH endpoint.The records are appended to a single MARCXML file that can be ingested with SolrMarc or other used with other sofware.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'miniharvest'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install miniharvest

## Usage

On the command line:

```bash
miniharvest http://oai-pmh/endpoint/ setname 201607 marc.xml
```
The first argument is the OAI-PMH endpoint, the second is the set you want to harvest, the third is a from date, and the
last is the file to write the output to. 

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

