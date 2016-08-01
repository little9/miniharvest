require 'test_helper'

class MiniHarvestTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::MiniHarvest::VERSION
  end

  def test_that_you_get_some_xml
    mh = MiniHarvest::MiniHarvest.new
    mh.oai_base_uri = 'https://memory.loc.gov/cgi-bin/oai2_0'
    mh.set = 'musdibib'
    doc = mh.get_records(mh.initial_request)
    refute_nil doc
  end
end
