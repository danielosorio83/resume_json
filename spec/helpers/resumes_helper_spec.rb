require 'rails_helper'

RSpec.describe ResumesHelper, type: :helper do
  let(:json_file) { fixture_file_upload("#{RSpec.configuration.fixture_path}/files/resume.json", 'application/json') }
  let(:resume) { Resume.new(json_file) }

  describe '#partial_name(resume)' do
    context 'when `message` is blank' do
      before do
        allow(resume).to receive(:message).and_return(nil)
      end
      it 'returns `resume' do
        expect(helper.partial_name(resume)).to eq('resume')
      end
    end

    context 'when `message` is NOT blank' do
      before do
        allow(resume).to receive(:message).and_return('something')
      end
      it 'returns `error`' do
        expect(helper.partial_name(resume)).to eq('error')
      end
    end
  end
end
