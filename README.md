# Permittribute

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'permittribute'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install permittribute

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it ( https://github.com/[my-github-username]/permittribute/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request


Add
In application.rb
  config.to_prepare do
    ["../lib/permittributes.rb"].collect do |path|
      Dir.glob(File.join(File.dirname(__FILE__), path))
    end.flatten.each do |c|
      Rails.configuration.cache_classes ? require(c) : load(c)
    end
  end

  config.eager_load_paths += ["#{Rails.root}/lib"]

In application_controller.rb
  include Permittribute::StrongParams

create file lib/permittributes.rb
  module Permittributes
    configure do
      @@articles = [:title, :summary, :author_id, :published_at, :publication]
      @@books = [:title, :summary, :author_id, :published_at, :publication, :price, :status]
      @@authors = [:name, :language, :age]
    end
  end
