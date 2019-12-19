RSpec.describe Api::V1::PerformanceDataController, type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:credentials) { user.create_new_auth_token }
  let(:headers) { { HTTP_ACCEPT: 'application/json' }.merge!(credentials) }

  describe 'POST /api/v1/performance_data' do
    before do
      post '/api/v1/performance_data', 
      params: {
        performance_data: { 
          data: { 
            message: 'Average' 
          } 
        }
      }, 
      headers: headers
    end

    it 'successfully creates a data entry' do
      entry = PerformanceData.last
      expect(entry.data).to eq 'message' => 'Average'
    end

    it 'returns a 200 response status' do
      expect(response.status).to eq 200
    end

    it 'returns a success message' do
      expect(response_json['message']).to eq 'all good'
    end
  end

  describe 'GET /api/v1/performance_data' do
    before do
      5.times { 
        create(
          :performance_data,
          data: { 
            message: 'Average' 
          },
          user: user
        ) 
      }
      
      get '/api/v1/performance_data', headers: headers
    end
  
    it 'returns a collection of performance data' do
      expect(response_json['entries'].count).to eq 5
    end
  
    it 'returns a 200 response status' do
      expect(response.status).to eq 200
    end
  end
end