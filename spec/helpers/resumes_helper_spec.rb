require 'rails_helper'

RSpec.describe ResumesHelper, type: :helper do
  let(:json_file) { fixture_file_upload("#{RSpec.configuration.fixture_path}/files/resume.json", 'application/json') }
  let(:resume) { Resume.new({ resume: json_file }) }
  let(:json) { resume.json }
  let(:text) { json.first.first }
  let(:struct) { json.first.last }

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

  describe '#json_to_html' do
    it 'calls `parse_struct` for each key' do
      expect(helper).to receive(:parse_struct).exactly(json.keys.size).and_return('')
      helper.json_to_html(json)
    end
  end

  describe '#parse_struct(text, struct)' do
    it 'calls `parse_html`' do
      expect(helper).to receive(:parse_html).exactly(2).and_return('')
      helper.parse_struct(text, struct)
    end

    it 'calls `parse_css`' do
      expect(helper).to receive(:parse_css).at_least(1).and_return('')
      helper.parse_struct(text, struct)
    end

    it 'returns the expected html string' do
      html_tag = struct['html_tag']
      inner_html = helper.parse_html(struct['innerHTML'])
      after_html = helper.parse_html(struct['afterHTML'])
      css = helper.parse_css(struct['css'])
      expected_html = "<#{html_tag} style=\"#{css}\">#{text}#{inner_html}</#{html_tag}>\n#{after_html}"
      expect(helper.parse_struct(text, struct)).to eq(expected_html)
    end
  end

  describe '#parse_css(css)' do
    context 'when `css` is nil' do
      it 'returns the empty string' do
        expect(helper.parse_css(nil)).to eq('')
      end
    end

    context 'when `css` is a hash' do
      it 'returns the expected string' do
        css = struct['css']
        code = css.inject('') do |style, arr|
          style << "#{arr.first}:#{arr.last};"
          style
        end
        expect(helper.parse_css(css)).to eq(code)
      end
    end
  end

  describe '#parse_html(array)' do
    context 'when `array` is nil' do
      it 'returns the empty string' do
        expect(helper.parse_html(nil)).to eq('')
      end
    end

    context 'when `array` is an array' do
      it 'calls `parse_struct` as many elements' do
        array = struct['afterHTML']
        expect(helper).to receive(:parse_struct).exactly(array.size).and_return('')
        helper.parse_html(array)
      end
    end
  end
end
