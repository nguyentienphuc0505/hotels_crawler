# frozen_string_literal: true

require 'net/http'

class CrawlHotelsService
  attr_accessor :supplier

  def initialize(supplier)
    self.supplier = supplier
  end

  def process
    supplier.imported_ids.clear
    keys = OpenStruct.new(supplier.key_collection)

    resp = Net::HTTP.get_response(URI.parse(supplier.source))
    result = JSON.parse(resp.body)

    unless result.empty?
      result.each do |hotel_data|
        hotel_id = hotel_data[keys.hotel_id]

        hotel = Hotel.where(hotel_id: hotel_id).first_or_initialize
        serives_for_attributes.each do |attribute, service|
          hotel[attribute] = service.new(hotel_data, hotel, keys.try(attribute)).process
        end

        supplier.imported_ids << hotel.hotel_id if hotel.save
      end
    end

    supplier.save
  end

  private

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
