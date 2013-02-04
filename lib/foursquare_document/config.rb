require "foursquare2"
module FoursquareDocument
  module Config
    Configuration = Struct.new(:client_id,:client_secret)
    FS_CONFIG = Configuration.new

    def self.configure(&block)
      yield FS_CONFIG
    end

    def self.get_client(extra_options={})
      options = {:client_id => FS_CONFIG.client_id, :client_secret => FS_CONFIG.client_secret,:api_version => "20121030"}.merge!(extra_options)
      @client = Foursquare2::Client.new(options)
    end
  end
end
