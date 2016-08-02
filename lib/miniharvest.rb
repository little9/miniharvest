require "miniharvest/version"

module MiniHarvest
  require 'net/http'
  require 'nokogiri'
  require 'open-uri'

  class MiniHarvest 
     
    attr_accessor :oai_base_uri, :set, :from, :marc_collection

     def append_to_collection(records)
       self.marc_collection.root.add_child(records)
    end

    def oai_request(uri,params)
      oai_uri = URI(uri)
      oai_uri.query = URI.encode_www_form(params)
      return Net::HTTP.get_response(oai_uri)
    end

    def process_request(res)
      doc = Nokogiri::XML(res.body)
      doc.remove_namespaces!
      records =  doc.xpath('//record')
      append_to_collection(records)
      
      resumption_token =  doc.xpath('//resumptionToken')
      return resumption_token.text
    end
    
    def initial_request
      params = { :verb => 'ListRecords', :set => self.set, :metadataPrefix => 'marc21', :from => self.from }
      res = oai_request(self.oai_base_uri,params)
      get_records(process_request(res))
    end

    def get_records(token)
      params = { :verb => 'ListRecords', :resumptionToken => token }
      res = oai_request(self.oai_base_uri,params)
      resumption_token = process_request(res)
      if resumption_token != ""
        get_records(resumption_token)
      else
        return self.marc_collection
      end
    end
  end
end
