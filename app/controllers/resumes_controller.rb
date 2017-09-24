class ResumesController < ApplicationController
  # POST /resumes
  def create
  end

  private

  def permitted_params
    params.permit(:resume)
  end
end
