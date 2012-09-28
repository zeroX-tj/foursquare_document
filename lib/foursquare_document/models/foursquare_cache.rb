class FoursquareCache
  include Mongoid::Document
  include Mongoid::Timestamps::Updated
  
  field :name,        :type => String
  field :description, :type => String
  field :categories,  :type => Array
  field :location,    :type => Hash
  field :id,          :type => Moped::BSON::ObjectId
  
  attr_accessible :name,:description,:categories,:location,:id
  
  embedded_in :fs_doc,:polymorphic => true
end
