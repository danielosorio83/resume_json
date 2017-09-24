require 'rails_helper'

RSpec.describe 'Resumes', type: :request do
  describe 'POST /resumes' do
    let(:valid_parameters) { { resume: '' } }

    before { post '/resumes', params: valid_parameters, xhr: true }

    it 'matchs with the jquery call' do
      expect(response.body).to match(/\$\(\"#resume\"\)\.html/)
    end

    it 'matchs with some of the content' do
      expect(response.body).to match("Hello World!")
    end
  end
end
