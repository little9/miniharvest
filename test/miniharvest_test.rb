require 'test_helper'

class MiniHarvestTest < Minitest::Test

  def setup
    @mh = MiniHarvest::MiniHarvest.new('https://na03.alma.exlibrisgroup.com/view/oai/01UOML_INST/request', 'udvd', '2016-07-01')
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

  def test_that_you_can_get_a_resumption_token
    assert_kind_of(Nokogiri::XML::Node,@mh.get_resumption_token(@mh.initial_res)[0])
  end

  def test_that_you_dont_get_a_resumption_token_if_there_is_none
    mh = MiniHarvest::MiniHarvest.new('http://sp.library.miami.edu/oai/oai.php', '', '')
    assert_equal(false, mh.get_resumption_token(mh.initial_res))
  end



end
