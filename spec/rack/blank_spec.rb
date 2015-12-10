require 'spec_helper'

describe Rack::Blank do
  app = lambda { |env|
    [200, {'Content-Type' => 'text/plain'}, ["Hello, World!"]]
  }

  context 'confirm to Rack::Lint' do
    subject do
      Rack::Lint.new( Rack::Blank.new(app) )
    end
    it do
      response = Rack::MockRequest.new(subject).get('/')
      expect(response.body).to eq 'Hello, World!'
    end
  end

  context 'return blank response' do
    subject do
      Rack::Lint.new(Rack::Blank.new(app, path: "/v1/blank"))
    end
    it do
      response = Rack::MockRequest.new(subject).get('/v1/blank')
      expect(response.successful?).to be_truthy
      expect(response.body).to eq ''
      expect(response.headers["Content-Type"]).to eq "text/plain"
    end
  end

  context 'return blank json response' do
    subject do
      Rack::Lint.new(Rack::Blank.new(app, path: "/v1/blank"))
    end
    it do
      response = Rack::MockRequest.new(subject).get('/v1/blank', "CONTENT_TYPE" => 'application/json')
      expect(response.successful?).to be_truthy
      expect(response.body).to eq '{}'
      expect(response.headers["Content-Type"]).to eq "application/json"
    end
  end

  context 'return blank json response with json ext' do
    subject do
      Rack::Lint.new(Rack::Blank.new(app, path: "/v1/blank"))
    end
    it do
      response = Rack::MockRequest.new(subject).get('/v1/blank.json')
      expect(response.successful?).to be_truthy
      expect(response.body).to eq '{}'
      expect(response.headers["Content-Type"]).to eq "application/json"
    end
  end

end

