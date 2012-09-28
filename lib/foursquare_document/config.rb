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
      @client = Foursquare2::Client.new(:client_id => FS_CONFIG.client_id, :client_secret => FS_CONFIG.client_id)
    end
  end
end
