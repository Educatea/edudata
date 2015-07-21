# Edudata

This gem allows an easy communication with [EduData](http://data.educatea.com.ar).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'edudata', github: 'juangesino/edudata'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install edudata

Now you will need to create an account at [EduData](http://data.educatea.com.ar) and get a token. Once you have your token, we recommend you add it as an environment variable or at least in your application.rb:

```ruby
ENV['EDU-TOKEN'] = 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
``` 
  
 You can also specify a hostname:

```ruby
ENV['HOST-NAME'] = 'MyAwesomeServer'
``` 
  Note: Heroku users should always include a hostname as Heroku tends to change hostnames with every deploy.  


## Usage

To start using it 

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Details

Created by [Juan Gesino](https://github.com/juangesino) for [Educatea](http://educatea.com.ar)

## Contributing

1. Fork it ( https://github.com/juangesino/edudata/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
