# frozen_string_literal: true

class HotelsController < ApplicationController
  def index
    @hotels = Hotel
    @hotels = @hotels.where(destination_id: destination_params) if destination_params.present?
    @hotels = @hotels.where(hotel_id: hotels_params) if hotels_params.present?

    render json: @hotels.all
  end

  def hotels_params
    params[:hotels] || []
  end

  def destination_params
    params[:destination]
  end
end
