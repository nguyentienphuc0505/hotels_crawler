# frozen_string_literal: true

require 'net/http'

class CrawlHotelsJob < ApplicationJob
  def perform
    CrawlHotelsService.new.process
  end
end
