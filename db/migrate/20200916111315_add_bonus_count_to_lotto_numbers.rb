class AddBonusCountToLottoNumbers < ActiveRecord::Migration[6.0]
  def change
    add_column :lotto_numbers, :bonus_count, :integer, default: 0, unsigned: true
  end
end
