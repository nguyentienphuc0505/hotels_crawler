# frozen_string_literal: true

require 'net/http'

class CrawlHotelsService
  attr_accessor :imported_ids

  SOURCES = ['https://api.myjson.com/bins/gdmqa',
             'https://api.myjson.com/bins/1fva3m',
             'https://api.myjson.com/bins/j6kzm'].freeze

  def initialize
    self.imported_ids = []
  end

  def process
    SOURCES.each do |source|
      process_for source
    end

    Hotel.where.not(hotel_id: imported_ids.compact.uniq).delete_all
  end

  private

  def process_for(source)
    resp = Net::HTTP.get_response(URI.parse(source))
    result = JSON.parse(resp.body)

    unless result.empty?
      result.each do |hotel_data|
        hotel_id = hotel_data['Id'] || hotel_data['hotel_id'] || hotel_data['id']

        hotel = Hotel.where(hotel_id: hotel_id).first_or_initialize
        serives_for_attributes.each do |attribute, service|
          hotel[attribute] = service.new(hotel_data, hotel).process
        end

        imported_ids << hotel.hotel_id if hotel.save
      end
    end
  end

  def serives_for_attributes
    {
      destination_id: ProcessDestinationIdService,
      name: ProcessNameService,
      location: ProcessLocationService,
      description: ProcessDescriptionService,
      amenities: ProcessAmenitiesService,
      images: ProcessImagesService,
      booking_conditions: ProcessBookingConditionsService
    }
  end
end
