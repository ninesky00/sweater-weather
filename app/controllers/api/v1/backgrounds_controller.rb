class Api::V1::BackgroundsController < ApplicationController
  def index
    if params[:location].present?
      render json: ImageSerializer.new(ImageFacade.search_image(params[:location]))
    else
      render status: 400
    end
  end
end