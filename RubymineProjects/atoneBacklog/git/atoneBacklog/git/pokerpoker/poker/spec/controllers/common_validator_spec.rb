require_relative '../spec_helper'
require_relative '../../app/validator/common_validator'

include Common_Validator

RSpec.describe Common_Validator do
  describe '#valid' do

    # validation 1 にはじかれるケース　理由は要素が５つないこと
    context 'validation 1 にはじかれる（要素が５つない）' do
      it '要素が５つ未満' do
        @post = "S9 S11 S12 S13"
        expect(valid{@post}).to eq "5つのカード指定文字を半角スペース区切りで入力してください。"
      end
      it '要素が６つ以上' do
        @post = "S8 S9 S10 S11 S12 S13"
        expect(valid{@post}).to eq "5つのカード指定文字を半角スペース区切りで入力してください。"
      end
      it '区切っていない部分がある' do
        @post = "S9S10 S11 S12 S13"
        expect(valid{@post}).to eq "5つのカード指定文字を半角スペース区切りで入力してください。"
      end
    end


    # validation 1 にはじかれるケース　理由は半角スペース以外で区切っていること
    context 'validation 1 にはじかれる（区切り方）' do
      it '全角スペース' do
        @post = "S9　S10 S11 S12 S13"
        expect(valid{@post}).to eq "5つのカード指定文字を半角スペース区切りで入力してください。"
      end
      it '改行' do
        @post = "S9
S10 S11 S12 S13"
        expect(valid{@post}).to eq "5つのカード指定文字を半角スペース区切りで入力してください。"
      end
      it '半角スペース２個以上' do
        @post = "S9  S10 S11 S12 S13"
        expect(valid{@post}).to eq "5つのカード指定文字を半角スペース区切りで入力してください。"
      end
      it '記号' do
        @post = "S9/S10 S11 S12 S13"
        expect(valid{@post}).to eq "5つのカード指定文字を半角スペース区切りで入力してください。"
      end
      it '空白文字(※S9とS10の間)' do
        @post = "S9ㅤS10 S11 S12 S13"
        expect(valid{@post}).to eq "5つのカード指定文字を半角スペース区切りで入力してください。"
      end
      it '外側にスペース' do
        @post = " S9 S10 S11 S12 S13"
        expect(valid{@post}).to eq "5つのカード指定文字を半角スペース区切りで入力してください。"
      end
    end


    # validation 1 にはじかれるケース　理由は要素が重複していること
    context 'validation 1 にはじかれる（重複）' do
      it '要素の重複' do
        @post = "S10 S10 S11 S12 S13"
        expect(valid{@post}).to eq "5つのカード指定文字を半角スペース区切りで入力してください。"
      end
    end

    # validation 1 にはじかれるケース　理由は要素に小数点や演算が含まれること
    context 'validation 1 にはじかれる（小数、演算）' do
      it '小数' do
        @post = "S1.1 S10 S11 S12 S13"
        expect(valid{@post}).to eq "5つのカード指定文字を半角スペース区切りで入力してください。"
      end
      it '演算' do
        @post = "S2*3 S10 S11 S12 S13"
        expect(valid{@post}).to eq "5つのカード指定文字を半角スペース区切りで入力してください。"
      end

    end


    # validation 2 にはじかれるケース　理由はスートが指定文字でないこと
    context 'validation 2 にはじかれる（スート）' do
      it 'スートがない' do
        @post = "9 S10 S11 S12 S13"
        expect(valid{@post}).to eq "1番目のカード指定文字が不正です。(9) ,半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。"
      end
      it '全角' do
        @post = "S9 Ｓ10 S11 S12 S13"
        expect(valid{@post}).to eq "2番目のカード指定文字が不正です。(Ｓ10) ,半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。"
      end
      it '半角小文字' do
        @post = "S9 S10 s11 S12 S13"
        expect(valid{@post}).to eq "3番目のカード指定文字が不正です。(s11) ,半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。"
      end
      it 'SDHC以外の英字半角大文字' do
        @post = "S9 S10 S11 A12 S13"
        expect(valid{@post}).to eq "4番目のカード指定文字が不正です。(A12) ,半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。"
      end
      it 'その他の半角大文字' do
        @post = "S9 S10 S11 S12 ё13"
        expect(valid{@post}).to eq "5番目のカード指定文字が不正です。(ё13) ,半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。"
      end
      it '記号、SDHCの繰り返し' do
        @post = "@9 SS10 S11 S12 S13"
        expect(valid{@post}).to eq "1番目のカード指定文字が不正です。(@9) ,2番目のカード指定文字が不正です。(SS10) ,半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。"
      end
    end


    # validation 2 にはじかれるケース　理由は数字が指定文字でないこと
    context 'validation 2 にはじかれる（数字）' do
      it '数字がない' do
        @post = "S S10 S11 S12 S13"
        expect(valid{@post}).to eq "1番目のカード指定文字が不正です。(S) ,半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。"
      end
      it '全角' do
        @post = "S９ S10 S11 S12 S13"
        expect(valid{@post}).to eq "1番目のカード指定文字が不正です。(S９) ,半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。"
      end
      it '半角記号' do
        @post = "S@ S10 S11 S12 S13"
        expect(valid{@post}).to eq "1番目のカード指定文字が不正です。(S@) ,半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。"
      end
      it '半角英字' do
        @post = "SA S10 S11 S12 S13"
        expect(valid{@post}).to eq "1番目のカード指定文字が不正です。(SA) ,半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。"
      end
      it '半角その他の文字' do
        @post = "Sё S10 S11 S12 S13"
        expect(valid{@post}).to eq "1番目のカード指定文字が不正です。(Sё) ,半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。"
      end
      it '１４以上' do
        @post = "S14 S10 S11 S12 S13"
        expect(valid{@post}).to eq "1番目のカード指定文字が不正です。(S14) ,半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。"
      end
      it '01' do
        @post = "S09 S10 S11 S12 S13"
        expect(valid{@post}).to eq "1番目のカード指定文字が不正です。(S09) ,半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。"
      end
    end

    # validation 2 にはじかれるケース　理由はスートと数字の間に文字が入ること
    context 'validation 2 にはじかれる（その他）' do
      it 'スートと数字の間に文字' do
        @post = "S@9 S10 S11 S12 S13"
        expect(valid{@post}).to eq "1番目のカード指定文字が不正です。(S@9) ,半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。"
      end
    end

  end
end


