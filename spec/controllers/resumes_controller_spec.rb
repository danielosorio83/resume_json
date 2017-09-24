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

    it 'assigns @resume' do
      post :create, params: valid_parameters, xhr: true
      expect(assigns(:resume)).not_to be_nil
    end

    it 'calls `Resume.new`' do
      expect(Resume).to receive(:new).with(kind_of(ActionController::Parameters))
      post :create, params: valid_parameters, xhr: true
    end
  end
end
