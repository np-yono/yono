module Common_Validator

  def valid

    # Validation 1（半角スペース区切り、要素５つ）

    error_array1 = []

    if @post.scan(/\s/).length == 4 && @post.scan(/\s/).uniq.length == 1 && @post.scan(/\f|\t|\r|\n/).empty?
    elsif @post.split(" ").uniq.count != 5
      error_array1.push("5つのカード指定文字を半角スペース区切りで入力してください。")
    else
      error_array1.push("5つのカード指定文字を半角スペース区切りで入力してください。")
    end

    # 重複 , 演算 , 小数
    if @post.split(/\s/).uniq.count != 5
      error_array1.push("5つのカード指定文字を半角スペース区切りで入力してください。")
    elsif @post.include?("*")
      error_array1.push("5つのカード指定文字を半角スペース区切りで入力してください。")
    elsif @post.include?("/")
      error_array1.push("5つのカード指定文字を半角スペース区切りで入力してください。")
    elsif @post.include?("%")
      error_array1.push("5つのカード指定文字を半角スペース区切りで入力してください。")
    elsif @post.include?("-")
      error_array1.push("5つのカード指定文字を半角スペース区切りで入力してください。")
    elsif @post.include?("+")
      error_array1.push("5つのカード指定文字を半角スペース区切りで入力してください。")
    elsif @post.include?(".")
      error_array1.push("5つのカード指定文字を半角スペース区切りで入力してください。")
    end


    # Validation 2 （各要素が指定文字かどうか）

    error_array2 = []
    post_array = @post.split(" ")

    n = 0
    post_array.each do |item|
      m = n + 1
      suits_element = item.split("")[0]

      if item.delete(suits_element)[0] == "0"
      error_array2.push("#{m}番目のカード指定文字が不正です。(#{item}) ")
      end

      numbers_element = item.delete(suits_element).to_i

     if /[SDHC]/ === suits_element && item.scan(/[SDHC]/).count == 1 && numbers_element > 0 && numbers_element < 14
      error_array2.push("no problem")
     else
       error_array2.push("#{m}番目のカード指定文字が不正です。(#{item}) ")
     end

     n +=1
    end

    error_array2.delete("no problem")

    if error_array2.empty?
    else
     error_array2.push("半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。")
    end


    if error_array1.count != 0
      @error = error_array1[0]
      @point = 0
    elsif error_array1.count == 0 && error_array2.count != 0
      @error = error_array2.join(",")
      @point = 0
    end

    @error

  end

end
