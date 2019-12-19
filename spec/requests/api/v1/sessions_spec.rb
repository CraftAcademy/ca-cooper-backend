RSpec.describe 'Sessions', type: :request do
  let(:headers) { { HTTP_ACCEPT: 'application/json' } }
  let(:user) { FactoryBot.create(:user) }
  let(:expected_response) {
    {
      'data' => {
        'id' => user.id, 'uid' => user.email, 'email' => user.email,
        'provider' => 'email', 'name' => nil, 'nickname' => nil,
        'image' => nil, 'allow_password_change' => false
      } 
    } 
  }
  describe 'POST /api/v1/auth/sign_in' do
    describe 'with valid credentials' do
      before do
        post '/api/v1/auth/sign_in', 
        params: { 
          email: user.email,
          password: user.password
        }, 
        headers: headers
      end

      it 'returns the expected response' do
        expect(response_json).to eq expected_response
      end

      it 'returns 200 response status' do
        expect(response.status).to eq 200
      end
    end

    describe 'with invalid password' do
      before do
        post '/api/v1/auth/sign_in', 
        params: { 
          email: user.email,
          password: 'wrong_password'
        }, 
        headers: headers 
      end
      
      it 'returns error message' do
        expect(response_json['errors']).to eq ['Invalid login credentials. Please try again.']
      end
      
      it 'returns 401 response status' do
        expect(response.status).to eq 401
      end
    end

    describe 'with invalid email' do
      before do
        post '/api/v1/auth/sign_in', 
        params: { 
          email: 'wrong@email.com',
          password: user.password
        }, 
        headers: headers
      end
      
      it 'returns error message' do
        expect(response_json['errors']).to eq ['Invalid login credentials. Please try again.']
      end
      
      it 'returns 401 response status' do
        expect(response.status).to eq 401
      end
    end
  end
end
