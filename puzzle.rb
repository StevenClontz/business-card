SOLUTION = <<STRING
--THE--
-R---E-
-S---U-
--LTF--
-----O-
-L---L-
--OWS--
STRING

SOLUTION.split("\n").each_with_index do |line,row|
  line.split("").each_with_index do |letter,col|
    random_nine_mult = (12..111).to_a.shuffle.first*9
    if letter == "-"
      letter = ('A'..'Z').to_a.shuffle.first
      random_number = random_nine_mult + (1..8).to_a.shuffle.first
    else
      random_number = random_nine_mult
    end
    puts "\\cellEntry{(#{col},#{6-row})}{#{letter}}{#{random_number}}"
  end
end
