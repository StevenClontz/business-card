SOLUTION = <<STRING
---TH---
--E--R--
--E--S--
--U--L--
---TFO--
-----L--
--L--O--
---WS---
STRING

SOLUTION.split("\n").each_with_index do |line,row|
  line.split("").each_with_index do |letter,col|
    random_nine_mult = (51..1111).to_a.shuffle.first*9
    if letter == "-"
      letter = ('A'..'Z').to_a.shuffle.first
      random_number = random_nine_mult + (1..8).to_a.shuffle.first
    else
      random_number = random_nine_mult
    end
    puts "\\cellEntry{(#{col},#{7-row})}{#{letter}}{#{random_number}}"
  end
end
