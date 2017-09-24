require 'rails_helper'

RSpec.describe 'Root', type: :request do
  describe 'GET /' do
    before { get '/' }

    it 'matchs with the resumes path' do
      expect(response.body).to match(resumes_path)
    end
  end
end
