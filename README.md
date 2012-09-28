# FoursquareDocument

Quick and easy foursquare venue_info cache in your mongo documents

## Installation

Add this line to your application's Gemfile:

    gem 'foursquare_document'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install foursquare_document

## Usage

include FoursquareDocument in your document and assign a field to contain the foursquare_id.
This will automatically embed a foursquare_cache document in your model. It is set using a after_save callback.

```ruby
class Venue
  include Mongoid::Document
  include FoursquareDocument

  foursquare_id :fs_id
end
```

Create an initializer to set the foursquare credentials
```ruby
FoursquareDocument::Config.configure do |c|
 c.client_id = <your-id>
 c.client_secret = <your-secret>
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
