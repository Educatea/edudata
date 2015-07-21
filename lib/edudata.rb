require "edudata/version"
require "net/http"
require "uri"
require "json"
require 'ostruct'
require 'active_support/core_ext/hash'

module Edudata
  module Benchmarks

  def self.set_token(token = ENV['EDU-TOKEN'])
    @token = token
  end


  extend self

  def measurements
    @measurements || = []
  end

  def find_by_name(name)
    self.measurements.each do |measurement|
      if measurement.name == name
        return measurement
      end
    end
    []
  end

  def clear(token = nil, host_name = '')

    if ENV['HOST-NAME']
      host_name = ENV['HOST-NAME']
    else
      if host_name.empty?
        host_name = Socket.gethostname
      end
    end

    self.measurements.each do |measurement|
      values = measurement.values
      
      if token
      	self.set_token(token)
      else
      	self.set_token
      end
      
      tag = measurement.name
      unit = measurement.unit

      if values.class != Array
        values = [values]
      end

      # uri = URI.parse("http://data.educatea.com.ar/api/v1/measurements")
      # http = Net::HTTP.new(uri.host, uri.port)
      # http.use_ssl = false
      # request = Net::HTTP::Post.new(uri.request_uri)
      # request.set_form_data({"values" => "#{values}", "token" => self.token, "tag" => tag, "host" => host_name, "unit" => unit})
      # response = http.request(request)
      # response = JSON.parse(response.body)
      puts {"values" => "#{values}", "token" => self.token, "tag" => tag, "host" => host_name, "unit" => unit}

    end

    @measurements = []
  end

  def add(name, values, unit = '')
    if !@measurements || @measurements.empty?
      @measurements = []
    end
    old_benchmark = Benchmarks.find_by_name(name)
    if old_benchmark.class == Array
      @measurements.push(Benchmark.new(name, values, unit))
    else
      old_benchmark.values = old_benchmark.values + values
      old_benchmark.new_values
    end
  end

  class Benchmark

    attr_accessor :name, :values, :unit, :max, :min, :average

    def initialize(name, values, unit)
      self.name = name
      self.values = values
      self.unit = unit
      self.max = values.max
      self.min = values.min
      self.average = (values.inject(:+).to_f / values.length).round(3)
    end

    def new_values
      self.max = self.values.max
      self.min = self.values.min
      self.average = self.values.inject(:+).to_f / self.values.length
    end

  end

  class Timer

    attr_accessor :name, :start_value, :end_value, :final_value

    def initialize
      self.start_value = Time.now
      self.end_value = nil
      self.final_value = nil
    end

    def end(name)
      self.end_value = Time.now
      self.final_value = ((self.end_value - self.start_value)*1000).round(2)
      Benchmarks.add(name, [self.final_value], 'ms')
    end

  end

end
end
