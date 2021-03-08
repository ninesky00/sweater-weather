class Api::V1::MunchiesController < ApplicationController
  def index
    if params[:destination].present? && params[:start].present? && params[:food].present?
      render json: MunchieSerializer.new(MunchieFacade.make_munchies(params))
    else
      render status: 400
    end
  end
end