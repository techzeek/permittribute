# Permittribute

We sometimes face scenarios where we need same permitted attributes for a model in different controllers and end up re-writing all attributes again (violating DRY).

Permittribute is meant to:

- reuse same permitted attributes at different locations/controllers.
- scope permitted attributes base on roles like admin, api etc.
- group permitted attributes at a single reference point in their respective scopes.

## Usage

This is used with <a href='https://github.com/rails/strong_parameters'>rails/strong_parameters</a> which is now incorporated since rails 4.x.


We use strong parameters something like:

    # in controllers/articles_controller.rb
    def article_params
      params.require(:article).permit([:title, :author_id, :published_at, :publication])
    end

    # in controllers/admin/articles_controller.rb
    def article_params
      params.require(:article).permit([:title, :author_id, :published_at, :publication])
    end

    # in controllers/api/articles_controller.rb
    def article_params
      params.require(:article).permit([:title, :author_id, :published_at, :publication])
    end

With <b>Permittribute</b> we can do:

    # in lib/permittribute/default.rb
    Permittribute.configure do
      config.articles = [:title, :author_id, :published_at, :publication]
      # Use as #permittribute_articles
    end

    # in lib/permittribute/admin.rb
    Permittribute.configure(:admin) do
      config.articles = [:title, :author_id, :published_at, :publication]
      # Use as #permittribute_admin_articles
    end

    # in lib/permittribute/api.rb
    Permittribute.configure(:api) do
      config.articles = [:title, :author_id, :published_at, :publication]
      # Use as #permittribute_api_articles
    end

And

    # in controllers/articles_controller.rb
    def article_params
      params.require(:article).permit(permittribute_articles)
    end

    # in controllers/admin/articles_controller.rb
    def article_params
      params.require(:article).permit(permittribute_admin_articles)
    end

    # in controllers/api/articles_controller.rb
    def article_params
      params.require(:article).permit(permittribute_api_articles)
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

- create three configurations file, `lib/permittribute/default.rb`, `lib/permittribute/admin.rb` and `lib/permittribute/api.rb`. These contains some example configurations.
- adds `config.eager_load_paths += ["#{Rails.root}/lib/permittribute"]` in `config/application.rb`. To eager load created config files.

## TODO

- Add specs.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/permittribute/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
