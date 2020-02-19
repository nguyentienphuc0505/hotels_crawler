# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HotelsController, type: :controller do
  describe 'GET index' do
    let!(:hotel1) { create(:hotel) }
    let!(:hotel2) { create(:hotel) }
    let!(:hotel3) { create(:hotel) }
    let(:parsed_json) { JSON.parse(response.body) }
    let(:response_ids) { parsed_json.map { |item| item['id'] } }

    context 'when there is no params' do
      it 'returns all hotels' do
        get :index

        expect(response_ids).to match_array [hotel1.id, hotel2.id, hotel3.id]
      end
    end

    context 'when there is destination params' do
      it 'returns hotels correctly' do
        get :index, params: { destination: hotel1.destination_id }

        expect(response_ids).to match_array [hotel1.id]
      end
    end

    context 'when there is hotels params' do
      it 'returns hotels correctly' do
        get :index, params: { hotels: [hotel3.hotel_id, hotel2.hotel_id] }

        expect(response_ids).to match_array [hotel3.id, hotel2.id]
      end
    end
  end
end
