# Permittribute

We sometimes face scenarios where we need same permitted attributes for a model in different controllers and end up re-writing all attributes again (violating DRY).

Permittribute is meant to:

- reuse same permitted attributes at different locations/controllers.
- group permitted attributes at a single reference point.

## Usage

This is used with <a href='https://github.com/rails/strong_parameters'>rails/strong_parameters</a> which is now incorporated since rails 4.x.


We use strong parameters something like:

    # in controllers/articles_controller.rb
    def article_params
      params.require(:article).permit([:title, :author_id, :published_at, :publication])
    end

    # in controllers/books_controller.rb
    def book_params
      params.require(:book).permit([:title, :summary, :author_id, :published_at, :publication, :price, :status])
    end

With <b>Permittribute</b> we can do:

    # in lib/permittributes.rb
    module Permittributes
      configure do
        @@articles = [:title, :author_id, :published_at, :publication]
        @@books = [:title, :summary, :author_id, :published_at, :publication, :price, :status]
      end
    end

And

    # in controllers/articles_controller.rb
    def article_params
      params.require(:article).permit(permittribute_articles)
    end

    # in controllers/books_controller.rb
    def book_params
      params.require(:book).permit(permittribute_books)
    end

## Getting Started

Add this line to your application's Gemfile:

    gem 'permittribute'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install permittribute

After you have installed Permittribute or added it to your Gemfile, you need to run the generator:

    $ rails generate permittribute:install

This will

- create a configuration file, `lib/permittributes.rb`. This contains some example configurations.
- adds `config.eager_load_paths += ["#{Rails.root}/lib"]` in `config/application.rb`. To eager load `lib/permittributes.rb`.

## TODO

- Add scoping like admin, api etc.
- Add specs.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/permittribute/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
