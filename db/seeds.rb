# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Supplier.create(
  source: 'https://api.myjson.com/bins/gdmqa',
  key_collection: {
    hotel_id: 'Id',
    destination_id: 'DestinationId',
    name: 'Name',
    location: {
      lat: 'Latitude',
      lng: 'Longitude',
      address: 'Address',
      city: 'City',
      country: 'Country'
    },
    description: 'Description',
    amenities: {
      general: 'Facilities'
    }
  }
)

Supplier.create(
  source: 'https://api.myjson.com/bins/1fva3m',
  key_collection: {
    hotel_id: 'hotel_id',
    destination_id: 'destination_id',
    name: 'hotel_name',
    location: {
      address: 'location.address',
      country: 'location.country'
    },
    description: 'details',
    amenities: {
      general: 'amenities.general',
      room: 'amenities.room'
    },
    images: {
      rooms: 'images.rooms',
      site: 'images.site',
      item: {
        link: 'link',
        description: 'caption'
      }
    },
    booking_conditions: 'booking_conditions'
  }
)

Supplier.create(
  source: 'https://api.myjson.com/bins/j6kzm',
  key_collection: {
    hotel_id: 'id',
    destination_id: 'destination',
    name: 'name',
    location: {
      lat: 'lat',
      lng: 'lng',
      address: 'address'
    },
    description: 'info',
    amenities: {
      general: 'amenities'
    },
    images: {
      rooms: 'images.rooms',
      amenities: 'images.amenities',
      item: {
        link: 'url',
        description: 'description'
      }
    }
  }
)
