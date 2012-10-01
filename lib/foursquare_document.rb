require "foursquare_document/version"
require "foursquare_document/models/foursquare_cache"
require "foursquare_document/config"
module FoursquareDocument
  module ClassMethods
    def foursquare_id(symbol,index=false)
      field symbol, :type => Moped::BSON::ObjectId


      if index
        index({symbol => 1})
      end
      
      attr_accessible symbol, :foursquare_cache
      accepts_nested_attributes_for :foursquare_cache

      class_eval <<-RUBY, __FILE__, __LINE__+1
        define_callbacks :add_foursquare_info

        set_callback(:save,:after) do |doc|
            if doc.#{symbol}_changed? &&
            (doc.foursquare_cache.blank? || !doc.foursquare_cache.changed?)
              doc.add_foursquare_info
            end
        end


        def add_foursquare_info
          run_callbacks :add_foursquare_info do
            client = FoursquareDocument::Config::get_client
            venue_info = client.venue(self.#{symbol})
            self.foursquare_cache = FoursquareCache.new(venue_info)
            self.foursquare_cache.save!         
          end
        end
      RUBY
    end
  end


  def self.included(base)
    # no need for activesupport::concern
    base.send :extend, ClassMethods

    base.class_eval do
      embeds_one :foursquare_cache, :as => :fs_doc
    end
  end
end
