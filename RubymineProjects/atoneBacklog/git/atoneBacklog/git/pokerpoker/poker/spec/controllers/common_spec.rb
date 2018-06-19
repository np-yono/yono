require_relative '../spec_helper'
require_relative '../../app/controllers/concerns/common'
include Common

RSpec.describe Common do

  describe '#check' do

    # checkアクション（役判定）
    context 'validationを抜けて役判定される' do
      it 'ストレートフラッシュになる' do
        @post = "S9 S10 S11 S12 S13"
        expect(check{@post}).to eq card: "S9 S10 S11 S12 S13",hands: "ストレートフラッシュ", best: 9
      end
      it 'ストレートになる' do
        @post = "S9 S10 S11 S12 D13"
        expect(check{@post}).to eq card: "S9 S10 S11 S12 D13",hands: "ストレート", best: 8
      end
      it 'フラッシュになる' do
        @post = "S8 S10 S11 S12 S13"
        expect(check{@post}).to eq card: "S8 S10 S11 S12 S13",hands: "フラッシュ", best: 7
      end
      it 'フォー・オブ・ア・カインドになる' do
        @post = "S12 S13 D13 H13 C13"
        expect(check{@post}).to eq card: "S12 S13 D13 H13 C13",hands: "フォー・オブ・ア・カインド", best: 6
      end
      it 'フルハウスになる' do
        @post = "S12 H12 S13 D13 H13"
        expect(check{@post}).to eq card: "S12 H12 S13 D13 H13",hands: "フルハウス", best: 5
      end
      it 'スリー・オブ・ア・カインドになる' do
        @post = "S11 S12 S13 D13 H13"
        expect(check{@post}).to eq card: "S11 S12 S13 D13 H13",hands: "スリー・オブ・ア・カインド", best: 4
      end
      it 'ツーペアになる' do
        @post = "S11 S12 D12 S13 D13"
        expect(check{@post}).to eq card: "S11 S12 D12 S13 D13",hands: "ツーペア", best: 3
      end
      it 'ワンペアになる' do
        @post = "S10 S11 S12 S13 D13"
        expect(check{@post}).to eq card: "S10 S11 S12 S13 D13",hands: "ワンペア", best: 2
      end
      it 'ハイカードになる' do
        @post = "D8 S10 S11 S12 S13"
        expect(check{@post}).to eq card: "D8 S10 S11 S12 S13",hands: "ハイカード", best: 1
      end
    end

    # context 'validation 1 にはじかれる' do
    #   it 'エラーになる' do
    #     @post = "S9S10 S11 S12 S13"
    #     expect(check{@post}).to eq card: "S9S10 S11 S12 S13",hands: "ストレートフラッシュ", best: 0
    #   end
    # end
    #
    # context 'validation 2 にはじかれる' do
    #    it 'エラーになる' do
    #     @post = "s9 S10 S11 S12 S13"
    #     expect(check{@post}).to eq card: "s9 S10 S11 S12 S13",hands: "ストレートフラッシュ", best: 0
    #    end
    # end

  end
end
