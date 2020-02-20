# frozen_string_literal: true

require 'net/http'

class CrawlHotelsJob < ApplicationJob
  def perform
    Supplier.find_in_batches do |suppliers|
      suppliers.map { |s| CrawlHotelsService.new(s).process }
    end

    imported_ids = Supplier.pluck(:imported_ids).flatten.uniq
    Hotel.where.not(hotel_id: imported_ids).delete_all
  end
end
