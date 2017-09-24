class ResumesController < ApplicationController
  # POST /resumes
  def create
    @resume = Resume.new(permitted_params)
  end

  private

  def permitted_params
    params.permit(:resume)
  end
end
