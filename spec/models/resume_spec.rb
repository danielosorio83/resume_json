require 'rails_helper'

RSpec.describe Resume, type: :model do
  # Accessors
  it { is_expected.to respond_to(:json) }
  it { is_expected.to respond_to(:message) }

  describe '#initialize(params)' do
    let(:params) { { resume: '' } }

    context 'when `JSON.parse` don\'t raise error' do
      before do
        allow(JSON).to receive(:parse).and_return('Something')
      end
      it 'assigns the parsed json to `json`' do
        resume = Resume.new(params)
        expect(resume.json).not_to be_nil
      end
    end

    context 'when `JSON.parse` raise error' do
      let(:error) { 'Some Error' }
      before do
        allow(JSON).to receive(:parse).and_raise(error)
      end
      it 'assigns the error message to `message`' do
        resume = Resume.new(params)
        expect(resume.message).to eq(error)
      end
    end
  end
end
