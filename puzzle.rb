class Puzzle
  attr_reader :puzzle

  SpecialChars = ['2','3','5','6','A','F']

  def initialize(solution_file)
    # 2,3,5,6,A,F in data.txt mark the cells to color in
    # no two different chars should be adjacent
    @data = File.readlines(solution_file).map!{|x| x.chomp.upcase.split(//)}
    @height = @data.size
    @width = @data.collect{|d| d.size}.max
    @data = @data.map!{|x| x + [" "]*(@width-x.size)}
    @puzzle = @data.map { |m|
      m.map { |n|
        if [2,3,5,6,10,15].include? n.hex
          randomMatch(n.hex)
        else
          noMatch
        end
      }
    }
  end

  def randomMatch(num)
    candidates = [*10...100].keep_if {|x| x % num == 0}
    candidates.sample
  end

  def noMatch
    candidates = [*10...100].delete_if {|x| x % 2 == 0 or x % 3 == 0 or x % 5 == 0}
    candidates.sample
  end
end

p = Puzzle.new("solution.txt")
texTable = ""
p.puzzle.each do |m|
  m.each do |n|
    texTable << n.to_str + " & "
  end
  texTable << "\\\\\n"
end
print texTable