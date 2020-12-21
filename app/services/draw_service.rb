class DrawService
  def initialize
    # 
  end

  def random
    numbers = [*1..45]

    wins = (1..6).to_a.inject([]) do |_wins, _|
      num = numbers.shuffle.sample
      numbers.reject! {|_num| _num == num}
      _wins << num
    end
    
    wins.sort
  end

  def draw
    numbers = LottoNumber.all
    total = numbers.sum(&:draw_probability)
    
    wins = Set.new

    while wins.length < 6 do
      num = numbers.shuffle.sample
      draw_num = rand(total) + 1
      draw_num -= num.draw_probability
      wins.add(num.num) if draw_num <= 0
    end

    wins.to_a.sort
  end
end