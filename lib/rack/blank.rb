require "rack/blank/version"
require 'json'

module Rack
  class Blank

    def initialize(app, options = {})
      @app  = app
      @path = options[:path] || '/blank'
    end

    def call(env)
      if @path && env['PATH_INFO'] == @path
        body = if env['CONTENT_TYPE'] == 'application/json'
          JSON.generate({})
        else
          ''
        end
        headers = {
          "Content-Length" => body.bytesize.to_s,
          "Content-Type" => env['CONTENT_TYPE'] || ''
        }
        res = [200, headers, [body]]
        return res
      end
      res = @app.call(env)
      return res
    end

  end
end
