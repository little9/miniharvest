require 'test_helper'

class MiniHarvestTest < Minitest::Test

  def setup
    @mh = MiniHarvest::MiniHarvest.new('https://na03.alma.exlibrisgroup.com/view/oai/01UOML_INST/request', 'udvd', '2016-07-01')
    @mh_no_token = MiniHarvest::MiniHarvest.new('http://sp.library.miami.edu/sp/oai.php','','')
  end

  def test_that_it_has_a_version_number
    refute_nil ::MiniHarvest::VERSION
  end

  def test_it_should_initilize_with_the_first_response
    assert_kind_of(Nokogiri::XML::Document,@mh.initial_res)
  end

  def test_that_it_should_have_some_records
    refute_empty(@mh.initial_res.xpath('//record'))
  end

  def test_that_it_gets_a_resumption_token
    refute_empty(@mh.initial_token)
  end
  
  def test_that_harvests_with_resumption_token
    assert_kind_of(Nokogiri::XML::Document, @mh.marc_collection)
  end

  def test_that_it_harvests_without_resumption_token
    assert_kind_of(Nokogiri::XML::Document,@mh_no_token.marc_collection)
  end



end
