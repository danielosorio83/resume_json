class Resume
  attr_accessor :json, :message

  def initialize(params = {})
    file_content = params[:resume].try(:read)
    self.json = JSON.parse(file_content)
  rescue => e
    self.message = e.message
  end
end
