# To change this template, choose Tools | Templates
# and open the template in the editor.

module FoursquareDocument
  module Config
    Configuration = Struct.new(:client_id,:client_secret)
    FS_CONFIG = Configuration.new

    def self.configure(&block)
      yield FS_CONFIG
    end
    
    def self.get_client
      raise "Please set FoursquareDocument::Config::FS_INFO['client_id']" unless FS_INFO.has_key?('client_id')
      raise "Please set FoursquareDocument::Config::FS_INFO['client_secret']" unless FS_INFO.has_key?('client_secret')
      @client = Foursquare2::Client.new(:client_id => FS_INFO['client_id'], :client_secret => FS_INFO['client_secret'])
    end
  end
end
