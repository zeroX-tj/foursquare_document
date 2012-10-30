class FoursquareCache
  include Mongoid::Document
  include Mongoid::Timestamps::Updated
  
  field :name,        :type => String
  field :description, :type => String
  field :categories,  :type => Array
  field :location,    :type => Hash
  field :id,          :type => Moped::BSON::ObjectId
  field :contact,     :type => Hash
  field :url,         :type => String
  attr_accessible :name,:description,:categories,:location,:id,:url,:contact
  
  embedded_in :fs_doc,:polymorphic => true
  embeds_one :foursquare_photo, :as => :photo
  
  
  def add_foursquare_photo
    client = FoursquareDocument::Config::get_client
    raw_info = client.venue_photos(self.id)
    if raw_info.has_key?('items') && raw_info['items'].count > 0
      self.photo = FoursquarePhoto.new(raw_info['items'][0])
    end
  end
end
