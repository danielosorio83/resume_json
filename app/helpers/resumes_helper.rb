module ResumesHelper
  def partial_name(resume)
    resume.message.blank? ? 'resume' : 'error'
  end

  def json_to_html(json)
    json.inject('') do |html, arr|
      html << parse_struct(arr.first, arr.last)
      html
    end.html_safe
  end

  def parse_struct(text, struct)
    html_tag = struct['html_tag']
    return '' if html_tag.blank?
    inner_html = parse_html(struct['innerHTML'])
    after_html = parse_html(struct['afterHTML'])
    css = parse_css(struct['css'])
    text ||= struct['text']
    "<#{html_tag} style=\"#{css}\">#{text}#{inner_html}</#{html_tag}>\n#{after_html}"
  end

  def parse_css(css)
    css ||= {}
    css.inject('') do |style, arr|
      style << "#{arr.first}:#{arr.last};"
      style
    end
  end

  def parse_html(array)
    array ||= []
    array.inject('') do |html, struct|
      html << parse_struct(nil, struct)
      html
    end
  end
end
