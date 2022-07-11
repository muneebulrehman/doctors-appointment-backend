require 'swagger_helper'

RSpec.describe 'APPOINTMENTS API', type: :request do
  path '/api/appointments' do
    get 'Retrieves existing appointments' do
      tags 'Appointments'
      consumes 'application/json'
      parameter name: 'Cookie', in: :header, type: :string

      response '200', 'appointments retrieved' do
        first_user = User.all[0]
        let('Cookie') { "user_name=#{first_user.user_name}" }
        # let('Cookie') { 'fingerprint_hash=whatever;other_data=true;' }
        run_test!
      end

      response '422', 'invalid request' do
        let('Cookie') { 'FAKE_COOKIE' }
        run_test! do |res|
          expect(res.body).to eq({ error: appointment_error(:index) }.to_json)
        end
      end
    end
  end
end
