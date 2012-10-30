# (c) 2012 Wep'IT bvba
class FoursquarePhoto
  include Mongoid::Document
  include Mongoid::Timestamps::Updated
  
  field :id,        :type => String
  field :createdAt, :type => DateTime
  field :prefix,    :type => String
  field :suffix,    :type => String
  field :source,    :type => Hash
  
  embedded_in :foursquare_cache, :inverse_of => :photo
  
  attr_accessible :id,:createdAt,:prefix,:suffix,:source
end
