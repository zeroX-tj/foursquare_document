require "foursquare_document/version"
require "foursquare_document/models/foursquare_cache"
require "foursquare_document/config"
module FoursquareDocument
  module InstanceMethods
    def add_foursquare_info
      client = FoursquareDocument::Config::get_client
      venue_info = client.venue(self.send(@fs_symbol))
      self.foursquare_cache = FoursquareCache.new(venue_info)
      self.foursquare_cache.save!
      DashboardItem.update_fs_known_loc_info_history(self.id)
    end
  end

  module ClassMethods
    def foursquare_id(symbol,index=false)
      @fs_symbol = symbol
      field symbol, :type => Moped::BSON::ObjectId

      add_foursquare_callback(symbol)

      if index
        index({symbol => 1})
      end
      
      attr_accessible @fs_symbol, :foursquare_cache
      accepts_nested_attributes_for :foursquare_cache

    end

    def add_foursquare_callback(symbol)
      set_callback(:save,:after) do |doc|
        if doc.send("#{symbol}_changed?") &&
            (doc.foursquare_cache.blank? || !doc.foursquare_cache_changed?)
          doc.add_foursquare_info
        end
      end

    end
  end


  def self.included(base)
    # no need for activesupport::concern
    base.send :include, InstanceMethods
    base.send :extend, ClassMethods

    base.class_eval do
      embeds_one :foursquare_cache, :as => :fs_doc
    end
  end
end
