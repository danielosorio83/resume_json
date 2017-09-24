module ResumesHelper
  def partial_name(resume)
    resume.message.blank? ? 'resume' : 'error'
  end
end
