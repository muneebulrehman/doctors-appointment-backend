require 'swagger_helper'

RSpec.describe 'APPOINTMENTS API', type: :request do
  path '/api/appointments' do
    get 'Retrieves existing appointments' do
      tags 'Appointments'
      consumes 'application/json'

      # response '200', 'appointments retrieved' do
      #   let(:Authorization) { "user_name=#{User.all[0].user_name}" }
      #   run_test!
      # end

      response '422', 'invalid request' do
        let(:Authorization) {''}
        run_test! do |res|
          expect(res.body).to eq({error: appointment_error(:index)}.to_json)
        end
      end
    end
  end
end
