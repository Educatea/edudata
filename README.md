# Edudata

This gem allows an easy communication with [EduData](http://data.educatea.com.ar).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'edudata', github: 'Educatea/edudata'
```

And then execute:

    $ bundle

Now you will need to create an account at [EduData](http://data.educatea.com.ar) and get a token. Once you have your token, we recommend you add it as an environment variable or at least in your application.rb:

```ruby
ENV['EDU-TOKEN'] = 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
``` 

Alternatively you can set the token:

```ruby
Edudata::Benchmarks.set_token('XXXXXXXXXXXXXXXXXXX')
``` 
  
 You can also specify a hostname:

```ruby
ENV['HOST-NAME'] = 'MyAwesomeServer'
``` 
  Note: Heroku users should always include a hostname as Heroku tends to change hostnames with every deploy.  


## Usage

To start using it you can track a specific event:

```ruby
Edudata::Benchmarks.add('MEASUREMENT-TAG-NAME', [ARRAY-OF-VALUES], "UNITS")
``` 
  The second parameter must always be an array of integers or floats, even if you have just one value. The units are optional.

Or you could use our Timer to track times:

```ruby
c = Edudata::Benchmarks::Timer.new
# Your code 
c.end('MY-TAG')
``` 

## Example

```ruby
# First let's set the token:    
ENV['EDU-TOKEN'] = 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'  

# Or:    
Edudata::Benchmarks.set_token('XXXXXXXXXXXXXXXXXXX')   

# Let's see if it was set correctly:   
Edudata::Benchmarks.show_token
# => 'XXXXXXXXXXXXXXXXXXX'
    
# You can now check if there are any measurements pending to be sent:    
Edudata::Benchmarks.measurements   
# => []
    
# You can now easily create a measurement for a purchase in your site
Edudata::Benchmarks.add('ShoppingCart', [20, 15, 12], '$')
   
# And another one 
Edudata::Benchmarks.add('ShoppingCart', [260], '$')
   
# Now our Edudata::Benchmarks.measurements array will contain a Benchmark object 
Edudata::Benchmarks.measurements   
# => [#<Edudata::Benchmarks::Benchmark:0x0000000296b3b8 @name="ShoppingCart", @values=[260, 20, 15, 12], @unit="$", @max=260, @min=12, @average=76.75>]  
  
# As you can see, benchmarks with same name are group together.
  
# To track time events, we created a special Timer object. Start the timer by creating an instance:
my_awesome_timer = Edudata::Benchmarks::Timer.new   
# Your awesome code goeas here...  
my_awesome_timer.end('AwesomeController')  
# With the end method you can give the timer a name.

```
## Send the data
So we have a bunch of measurements in our Edudata::Benchmarks.measurements array. How do we send all this to EduData? Easy.

```ruby
Edudata::Benchmarks.clear('OPTIONAL-HOST-NAME')
``` 

That's it. That will clear the array and send everything to EduData. Take into account that the priority for the host name is: 
  
  ENV['HOST-NAME'] > 'OPTIONAL-HOST-NAME' > Detected hostname    

To clear the array withour sending any data to EduData:

```ruby
Edudata::Benchmarks.destroy
``` 

## Benchmark my controllers
 You can easily use the Timer object to benchmark your controllers. Add to your application_controller.rb:

```ruby
before_action :start_benchmark  

def start_benchmark
	@controller_benchmark = Edudata::Benchmarks::Timer.new
end  
  
def render *args
	@controller_benchmark.end("#{params[:controller]}##{params[:action]}") # Give it the name you want!
	super
end
``` 


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Details

Created by [Juan Gesino](https://github.com/juangesino) for [Educatea](http://educatea.com.ar)

## Contributing

1. Fork it ( https://github.com/Educatea/edudata/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
