class Puzzle
  attr_reader :puzzle, :width

  SpecialChars = ['2','3','5','6','A','F']

  def initialize(solutionFile)
    # 2,3,5,6,A,F in data.txt mark the cells to color in
    # no two different chars should be adjacent
    @data = File.readlines(solutionFile).map!{|x| x.chomp.upcase.split(//)}
    @height = @data.size
    @width = @data.collect{|d| d.size}.max
    @data = @data.map!{|x| x + [" "]*(@width-x.size)}
    @puzzle = @data.map { |m|
      m.map { |n|
        if [2,3,5,6,10,15].include? n.hex
          randomMatch(n.hex)
        else
          randomMatch(1)
        end
      }
    }
  end

  def puzzleStr
    @puzzle.
      map {|line| line.join(" & ")}.
      join(" \\\\\\hline\n")
  end

  def randomMatch(num)
    candidates = [*10...100]
    if num % 2 != 0
      candidates.delete_if {|x| x%2 == 0}
    end
    if num % 3 != 0
      candidates.delete_if {|x| x%3 == 0}
    end
    if num % 5 != 0
      candidates.delete_if {|x| x%5 == 0}
    end
    candidates.keep_if {|x| x%num == 0}.sample
  end
end

p = Puzzle.new("solution.txt")
puts "\\begin{tabular}{|" + "c|"*p.width + "}\\hline"
puts p.puzzleStr
puts "\\hline\n\\end{tabular}"