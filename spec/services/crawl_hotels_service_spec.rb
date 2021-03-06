# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CrawlHotelsService, type: :service do
  describe '#process' do
    context 'when crawl hotels and removes unimported hotel' do
      let(:supplier) do
        create(:supplier, key_collection: {
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
               })
      end
      let(:source_1) do
        File.read(Rails.root.join('spec/support/source_1.json'))
      end

      before do
        expect(Net::HTTP)
          .to receive(:get_response)
          .with(URI.parse(supplier.source))
          .and_return(double(body: source_1))
      end

      it 'creates new hotel' do
        expect { described_class.new(supplier).process }.to change(Hotel, :count).by(3)
      end
    end
  end
end
