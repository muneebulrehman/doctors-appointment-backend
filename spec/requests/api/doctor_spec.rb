require 'swagger_helper'
require 'rails_helper'

RSpec.describe '/api/doctors', type: :request do
  path '/api/doctors' do
    get 'Retrieves all doctors' do
      tags 'Doctors'
      produces 'application/json'

      response '200', 'list of doctors' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   name: { type: :string },
                   speciality: { type: :string },
                   image: { type: :string },
                   price: { type: :number },
                   bio: { type: :string },
                   created_at: { format: 'date-time' },
                   updated_at: { format: 'date-time' }
                 }
               }
        run_test!
      end
    end
  end
end