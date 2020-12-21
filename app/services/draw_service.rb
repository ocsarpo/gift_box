class DrawService
  def initialize
    # 
  end

  def random
    numbers = [*1..45]

    wins = [*1..6].inject([]) do |_wins, _|
      num = numbers.shuffle.sample
      numbers.reject! {|_num| _num == num}
      _wins << num
    end
    
    wins.sort
  end

  def draw
    numbers = LottoNumber.all
    total = numbers.sum(&:draw_probability).to_i # 600
    
    wins = Set.new

    while wins.length < 6 do
      draw_num = rand(total)
      numbers.shuffle.each do |_num|
        draw_num -= _num.draw_probability
        if draw_num <= 0
          wins.add(_num.num)
          break
        end
      end
    end

    wins.to_a.sort
  end
end