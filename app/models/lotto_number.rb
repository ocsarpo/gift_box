class LottoNumber < ApplicationRecord
    has_many :picked_nums, dependent: :destroy
  
    validates :num, :name, presence: true
    validates :num, uniqueness: true
    validates :num, numericality: {only_integer: true, greater_than: 0, less_than: 46}
  end