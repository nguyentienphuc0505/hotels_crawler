# frozen_string_literal: true

class CreateHotels < ActiveRecord::Migration[6.0]
  def change
    create_table :hotels do |t|
      t.string :hotel_id, null: false, index: { unique: true }
      t.integer :destination_id, null: false
      t.string :name
      t.jsonb :location, default: {}
      t.string :description
      t.jsonb :amenities, default: {}
      t.jsonb :images, default: {}
      t.string :booking_conditions, array: true, default: []
    end
  end
end
