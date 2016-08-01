# MiniHarvest

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
miniharvest http://oai-pmh/endpoint/ setname > marc.xml
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

