# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CrawlHotelsService, type: :service do
  describe '#process' do
    context 'when crawl hotels and removes unimported hotel' do
      let!(:hotel) { create :hotel }
      let(:source_1) do
        File.read(Rails.root.join('spec/support/source_1.json'))
      end
      let(:source_2) do
        File.read(Rails.root.join('spec/support/source_2.json'))
      end
      let(:source_3) do
        File.read(Rails.root.join('spec/support/source_3.json'))
      end

      before do
        expect(Net::HTTP)
          .to receive(:get_response)
          .with(URI.parse(described_class::SOURCES[0]))
          .and_return(double(body: source_1))
        expect(Net::HTTP)
          .to receive(:get_response)
          .with(URI.parse(described_class::SOURCES[1]))
          .and_return(double(body: source_2))
        expect(Net::HTTP)
          .to receive(:get_response)
          .with(URI.parse(described_class::SOURCES[2]))
          .and_return(double(body: source_3))
      end

      it 'creates new hotel' do
        expect { described_class.new.process }.to change(Hotel, :count).by(2)
        expect(Hotel.find_by_id(hotel.id)).to be_nil
      end
    end
  end
end
