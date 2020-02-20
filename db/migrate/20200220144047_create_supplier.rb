# frozen_string_literal: true

class CreateSupplier < ActiveRecord::Migration[6.0]
  def change
    create_table :suppliers do |t|
      t.string :source, null: false, index: { unique: true }
      t.jsonb :key_collection, default: {}
      t.string :imported_ids, array: true, default: []
    end
  end
end
