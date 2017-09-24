require 'rails_helper'

RSpec.describe 'Resumes', type: :request do
  describe 'POST /resumes' do
    context 'with a well formatted json' do
      let(:json_file) { fixture_file_upload("#{RSpec.configuration.fixture_path}/files/resume.json", 'application/json') }
      let(:valid_parameters) { { resume: json_file } }

      before { post '/resumes', params: valid_parameters, xhr: true }

      it 'matchs with the jquery call' do
        expect(response.body).to match(/\$\(\"#resume\"\)\.html/)
      end

      it 'matchs with some of the content' do
        expect(response.body).to match("Hello World!")
      end
    end

    context 'with invalid json file' do
      let(:json_file) { fixture_file_upload("#{RSpec.configuration.fixture_path}/files/error.json", 'application/json') }
      let(:invalid_parameters) { { resume: json_file } }

      before { post '/resumes', params: invalid_parameters, xhr: true }

      it 'matchs with the jquery call' do
        expect(response.body).to match(/\$\(\"#resume\"\)\.html/)
      end

      it 'matches with `alert`' do
        expect(response.body).to match(/alert/)
      end
    end

    context 'with different json file' do
      let(:json_file) { fixture_file_upload("#{RSpec.configuration.fixture_path}/files/different.json", 'application/json') }
      let(:invalid_parameters) { { resume: json_file } }

      before { post '/resumes', params: invalid_parameters, xhr: true }

      it 'matchs with the jquery call' do
        expect(response.body).to match(/\$\(\"#resume\"\)\.html/)
      end

      it 'doesn\'t match with `alert`' do
        expect(response.body).not_to match(/alert/)
      end
    end
  end
end
