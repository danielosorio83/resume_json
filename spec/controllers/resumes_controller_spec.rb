require 'rails_helper'

RSpec.describe ResumesController, type: :controller do
  describe 'POST #create' do
    let(:valid_parameters) { { resume: '' } }

    it 'returns http success' do
      post :create, params: valid_parameters, xhr: true
      expect(response).to have_http_status(:success)
    end

    it 'render `create`' do
      post :create, params: valid_parameters, xhr: true
      expect(response).to render_template('create')
    end
  end
end
