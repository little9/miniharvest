require "miniharvest/version"


module MiniHarvest
  require 'net/http'
  require 'nokogiri'
  require 'logger'

  class MiniHarvest 
    
    attr_accessor :oai_base_uri, :set, :from, :marc_collection, :logger, :initial_res, :initial_token
    
    def initialize(oai_base_uri, set, from)
      @oai_base_uri = oai_base_uri
      @set = set
      @from = from
      @marc_collection = Nokogiri::XML('<collection xmlns="http://www.loc.gov/MARC21/slim">')
      @logger = Logger.new(STDOUT)

      params = { :verb => 'ListRecords', :set => self.set, :metadataPrefix => 'marc21', :from => self.from }
      @initial_res = oai_request(self.oai_base_uri,params)
      @initial_token = get_resumption_token(@initial_res)
    end

    def get_records(token)
      params = { :verb => 'ListRecords', :resumptionToken => token[0].text }
      doc = oai_request(self.oai_base_uri,params)
      resumption_token = process_request(doc)
      
      if resumption_token != false
        get_records(resumption_token)
      else
        return self.marc_collection.root
      end
    end

    private # private methods
    
    def append_to_collection(records)
      self.marc_collection.root.add_child(records)
    end

    def oai_request(uri,params)
      oai_uri = URI(uri)
      oai_uri.query = URI.encode_www_form(params)
      @logger.info(oai_uri.query)

      res = Net::HTTP.get_response(oai_uri)

      doc = Nokogiri::XML(res.body)
      doc.remove_namespaces!

      return doc
    end

    def get_resumption_token(doc)
      resumption_token =  doc.xpath('//resumptionToken')
      if resumption_token.length == 1
        return resumption_token
      else
        return false
      end
    end

    def process_request(doc)
      token = get_resumption_token(doc)
      if token != false
        records =  doc.xpath('//record')
        append_to_collection(records)
        return token
      else
        return false
      end
    end

<<<<<<< HEAD
    
=======
    def dedupe_records(node)
      seen = Hash.new(0)
      node.traverse {|n| n.unlink if (seen[n.to_xml] += 1) > 1}
      return node
    end


    def get_records(token)
      params = { :verb => 'ListRecords', :resumptionToken => token[0].text }
      doc = oai_request(self.oai_base_uri,params)
      resumption_token = process_request(doc)
      
      if resumption_token != false
        get_records(resumption_token)
      else
        return dedupe_records(self.marc_collection.root)
      end
    end
>>>>>>> 60aefec64147b712bb5a7da519cd66e852d9925c
  end
end
