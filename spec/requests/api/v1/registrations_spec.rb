RSpec.describe 'User Registration', type: :request do
  let!(:registered_user) { create(:user, email: 'coach@craftacademy.se')}
  let(:headers) { { HTTP_ACCEPT: 'application/json' } }

  describe 'with valid credentials' do
    before do
      post '/api/v1/auth', 
      params: { 
        email: 'example@craftacademy.se',
        password: 'password',
        password_confirmation: 'password'
      }, 
      headers: headers
    end

    it 'returns a 200 response status' do
      expect(response.status).to eq 200
    end

    it 'returns a success message' do
      expect(response_json['status']).to eq 'success'
    end
  end

  context 'when user submits' do
    describe 'a non-matching password confirmation' do
      before do
        post '/api/v1/auth', 
        params: { 
          email: 'example@craftacademy.se',
          password: 'password',
          password_confirmation: 'wrong_password'
        }, 
        headers: headers
      end
      
      it 'returns an error message' do
        expect(response_json['errors']['password_confirmation']).to eq ["doesn't match Password"]
      end

      it 'returns a 422 response status' do
        expect(response.status).to eq 422
      end
    end

    describe 'an invalid email address' do
      before do
        post '/api/v1/auth', 
        params: { 
          email: 'example@craft',
          password: 'password',
          password_confirmation: 'password'
        }, 
        headers: headers
      end
      
      it 'returns an error message' do
        expect(response_json['errors']['email']).to eq ['is not an email']
      end

      it 'returns a 422 response status' do
        expect(response.status).to eq 422
      end
    end

    describe 'an already registered email' do
      before do
        post '/api/v1/auth', 
        params: { 
          email: 'coach@craftacademy.se',
          password: 'password',
          password_confirmation: 'password'
        }, 
        headers: headers


      end
      it 'returns an error message' do
        expect(response_json['errors']['email']).to eq ['has already been taken']
      end

      it 'returns a 422 response status' do
        expect(response.status).to eq 422
      end
    end
  end
end