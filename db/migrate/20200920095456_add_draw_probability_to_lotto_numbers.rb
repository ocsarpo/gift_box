class AddDrawProbabilityToLottoNumbers < ActiveRecord::Migration[6.0]
  def change
    add_column :lotto_numbers, :draw_probability, :decimal, precision: 5, scale: 2, default: 0.0
  end
end
