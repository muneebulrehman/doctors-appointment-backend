require 'swagger_helper'
require 'rails_helper'

# Write tests for the user API here.
RSpec.describe 'api/users', type: :request do
  path '/api/users' do
    post 'Creates a user' do
      tags 'Users'
      consumes 'application/json'
      parameter name: :user, in: :body, schema:
      {
        type: :object,
        properties: {
          user_name: { type: :string },
          email: { type: :string }
        },
        required: ['user_name', 'email']
      }
      response '201', 'User created successfully' do
        let(:user) {{user_name: 'aquaman', email: 'aquaman@gmail.com'}}
        run_test!
      end

      response '422', 'invalid request' do
        let(:user) { { user_name: 'birdman' } }
        run_test!
      end
    end
  end
end
  