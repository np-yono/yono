require_relative '../../validator/common_validator'
include Common_Validator

module Common

  def check

    # 数字とスートを抽出
    numbers         = @post.scan(/\d+/)
    suits           = @post.scan(/[SDHC]/)

    # numbers_variety:数字の種類数
    numbers_variety = numbers.uniq.length

    # suits_variety:スートの種類数
    suits_variety   = suits.uniq.length

    # numbers_gap:最大値と最小値の差
    numbers_order   = numbers.sort_by{|value| value.to_i}
    numbers_max     = numbers_order.max{|value| value.to_i}
    numbers_min     = numbers_order.min{|value| value.to_i}
    numbers_gap     = numbers_max.to_i - numbers_min.to_i

    # numbers_mode:最頻値の個数
    mode            = numbers.max_by{|value| numbers.count(value)}
    numbers_mode    = numbers.count(mode)

    #　役判定 （@point:役の点数）
    if numbers_variety == 5 && suits_variety == 1 && numbers_gap == 4
      @yaku = "ストレートフラッシュ"
      @point = 9
    elsif numbers_variety == 5 && suits_variety >= 2 && numbers_gap == 4
      @yaku = "ストレート"
      @point = 8
    elsif suits_variety == 1
      @yaku = "フラッシュ"
      @point = 7
    elsif numbers_mode == 4
      @yaku = "フォー・オブ・ア・カインド"
      @point = 6
    elsif numbers_variety == 2 && numbers_mode == 3
      @yaku = "フルハウス"
      @point = 5
    elsif numbers_variety == 3 && numbers_mode == 3
      @yaku = "スリー・オブ・ア・カインド"
      @point = 4
    elsif numbers_variety == 3 && numbers_mode == 2
      @yaku = "ツーペア"
      @point = 3
    elsif numbers_variety == 4 && numbers_mode == 2
      @yaku = "ワンペア"
      @point = 2
    else
      @yaku = "ハイカード"
      @point = 1
    end

    # validation method
    valid

    # hash for API
    @hash = {card: @post,hands: @yaku,best: @point}


  end
end
