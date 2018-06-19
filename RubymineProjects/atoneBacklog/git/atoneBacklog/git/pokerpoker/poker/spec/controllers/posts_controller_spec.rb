require_relative '../rails_helper'
require_relative '../../app/controllers/concerns/common'

include Common

RSpec.describe "PostsController", type: :controller do


  describe 'Post #result' do
    before do
      post :result
    end

    context '値が正常に入力される場合' do
      before do
        @post = "S9 S10 S11 S12 S13"
      end
      it 'リクエストが200 OK となること' do
        expect(response.status).to eq 200
      end
      it '@postに期待した値が入ること' do
        expect(assigns(:post)).to eq @post
      end
      it '@yakuに期待した値が入ること' do
        expect(assigns(:yaku)).to eq @yaku
      end
      it '@postに期待した値が入ること' do
        expect(assigns(:error)).to eq nil
      end
      it ' :topを表示すること' do
        expect(response).to render_template :top
      end
    end

    context '値が正常に入力されない場合' do
      before do
        @post = "S9S10 S11 S12 S13"
      end
      it 'リクエストが200 OK となること' do
        expect(response.status).to eq 200
      end
      it '@postに期待した値が入ること' do
        expect(assigns(:post)).to eq nil
      end
      it '@yakuに期待した値が入ること' do
        expect(assigns(:yaku)).to eq @yaku
      end
      it '@postに期待した値が入ること' do
        expect(assigns(:error)).to eq @error
      end
      it ' :topを表示すること' do
        expect(response).to render_template :top
      end
    end









  end
end
