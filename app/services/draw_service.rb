class DrawService
  def initialize
    # 
  end

  def random
    numbers = [*1..45]
    wins = []
    
    1.upto(6) do
      win = numbers.sample
      wins << win
      numbers.reject!{|n| n == win}
    end
    wins.sort!
  end

  def draw
    numbers = LottoNumber.all
    total = numbers.sum(&:draw_probability)
    wins = []
    
    while wins.length < 6 do
      draw_num = rand(total) + 1
      numbers.each do |num|
        draw_num -= num.draw_probability
        if draw_num <= 0
          wins << num.num unless wins.include? num.num
          break
        end
      end
    end
    wins.sort!
  end
end