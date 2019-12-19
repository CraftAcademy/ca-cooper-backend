require 'rails_helper'

RSpec.describe Api::V0::PingsController, type: :request do
  describe 'GET /v0/pings' do
    before do
      get '/api/v0/pings'
    end

    it 'should return a 200 response' do
      expect(response.status).to eq 200
    end
    
    it 'should return Pong' do
      expect(response_json['message']).to eq 'Pong'
    end
  end
end