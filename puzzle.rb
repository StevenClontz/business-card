require 'rqrcode'

class Puzzle
  attr_reader :puzzle, :data, :qrcode

  def initialize
    @qrcode = RQRCode::QRCode.new("clontz.org/foo", size: 2)
    @data = @qrcode.to_s.split("\n").map{|line| line.split("")}
    @size = @data.size
    @puzzle = @data.map { |m|
      m.map { |n|
        if n.upcase=="X"
          9*(2..10).to_a.sample
        else
          9*(1..10).to_a.sample+(1..8).to_a.sample
        end
      }
    }
  end

  def puzzle_tex
    str = '\begin{tikzpicture}'+"\n"
    str += '\draw[step=1em,gray,very thin] (0,0) grid '+"(#{@size.to_s}em,#{@size.to_s}em);\n"
    @puzzle.each_with_index do |line, i|
      line.each_with_index do |entry, j|
        reverse_i = (@size-i) % @size
        str += "\\node at (#{i}.5em,#{@size-j-1}.5em) {\\scriptsize #{entry}};\n"
      end
    end
    str += '\end{tikzpicture}'+"\n"
    return str
  end
end

puzzle = Puzzle.new
File.open('qrcode.txt', 'w') { |file| file.write(puzzle.qrcode.to_s) }
File.open('qrcode.svg', 'w') { |file| file.write(puzzle.qrcode.as_svg(
                    offset: 0, color: '000', 
                    shape_rendering: 'crispEdges',
                    module_size: 11))}
File.open('puzzle.tex', 'w') { |file| file.write(puzzle.puzzle_tex) }
