require "rack/blank/version"
require 'json'

module Rack
  class Blank

    def initialize(app, options = {})
      @app  = app
      @path = options[:path] || '/blank'
    end

    def call(env)
      request_path = "#{::File.dirname(env['PATH_INFO'])}/#{::File.basename(env['PATH_INFO'], '.*')}"
      request_ext  = ::File.extname(env['PATH_INFO'])
      if request_path == @path
        body = ''
        content_type = 'text/plain'
        if env['CONTENT_TYPE'] == 'application/json' || request_ext == '.json'
          body = JSON.generate({})
          content_type = 'application/json'
        end
        headers = {
          "Content-Length" => body.bytesize.to_s,
          "Content-Type" => content_type
        }
        return [200, headers, [body]]
      end
      return @app.call(env)
    end

  end
end
