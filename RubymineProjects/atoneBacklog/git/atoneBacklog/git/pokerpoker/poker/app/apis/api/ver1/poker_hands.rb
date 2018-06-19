require_relative '../../../controllers/concerns/common'
include Common

module API
  module Ver1
    class Poker_hands < Grape::API
      resource :poker_hands do


        # POST /api/v1/poker_hands

        # URLのvalidation
        # if
        #  error!('指定のURLを入力してください。')
        # end

        # 未入力のvalidation
        # if
        #  error!('入力してください。')
        # end


        post do

          # 形式のvalidation
          # if
          #  error!('JSONで入力してください。')
          # end

          # requestを受け取る
          post = JSON.parse request.body.read

           # keyのvalidation
           if post.keys.count != 1
             error!('keyは１つにしてください。')
           elsif post.keys.join("") != "cards"
             error!('keyはcardsと入力してください。')
           end

           # 配列の取り出し
           poker_posts = post["cards"]

          # 配列のvalidation
          if poker_posts.class != Array
            error!('cardsのvalueは配列で入力してください。')
          elsif poker_posts.empty?
            error!('配列の要素がありません。')
          end

          params do
            requires :cards, type: String
          end


          # 役判定

            poker_array = []

            error_array = []

           points_array = []

           poker_posts.each do |poker_post|
            @post = poker_post

            check

            if @hash.has_value?(0)
              @hash.store(:hands, @error)
              error_array.push(@hash)
            else
              poker_array.push(@hash)
            end

            points_array.push(@point)

           end


          # 役の点数の最大値
          point_max = points_array.max


          # bestの判定
          poker_array.each do |small_hash|
            if small_hash.has_value?(point_max)
              small_hash.store(:best,"true")
            else
              small_hash.store(:best,"false")
            end
          end

          error_array.each do |small_error|
            small_error.store(:best,"error")
          end



          # response
          poker_hash = {}

          if poker_array.empty?
          else
            poker_hash.store("result", poker_array)
          end

          if error_array.empty?
          else
            poker_hash.store("error", error_array)
          end

          poker_hash


        end
      end
    end
  end
end

