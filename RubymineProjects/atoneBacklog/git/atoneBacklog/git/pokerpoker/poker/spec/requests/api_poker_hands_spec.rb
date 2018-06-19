require 'rails_helper'
require_relative '../../app/controllers/concerns/common'

RSpec.describe "Poker_hands", type: :request do
  describe "GET api/Poker_hands" do

    include Common

    it 'リクエストが200 OK となること' do
      expect(response.status).to eq 200
    end
    it ' :topを表示すること' do
      expect(response).to render_template :top
    end

    context '役判定される' do
      it 'ストレートフラッシュになる(check)' do
        @post = "S9 S10 S11 S12 S13"
        expect(check{@post}).to eq card: "S9 S10 S11 S12 S13",hands: "ストレートフラッシュ", best: 9
      end
    end

    context 'validationにはじかれる(valid)' do
      it 'validation 1 にはじかれる' do
        @post = "S9S10 S11 S12 S13"
        expect(check{@post}).to eq card: "S9S10 S11 S12 S13",hands: "ストレートフラッシュ", best: 0
      end
      it 'validation 2 にはじかれる' do
        @post = "9 S10 S11 S12 S13"
        expect(check{@post}).to eq card: "9 S10 S11 S12 S13",hands: "ストレートフラッシュ", best: 0
      end
    end

  end
end

