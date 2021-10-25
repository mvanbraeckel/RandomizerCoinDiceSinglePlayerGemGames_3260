class Item < ApplicationRecord
  belongs_to :user

  validates :item, inclusion: { in: %w(coin die),
    message: "%{value} is not a valid item" }

  # with_options if: :item == :coin do |coin|
  #   coin.validates :denomination, presence: true, numericality: { greater_than: 0.0 }, inclusion: { in: %w(.05 0.05 .1 0.1 .10 0.10 .25 0.25 1 1.0 1.00 2 2.0 2.00),
  #     message: "%{value} is not a valid coin denomination" }
  #   coin.validates :sides, presence: false, allow_blank: true
  #   coin.validates :colour, presence: false, allow_blank: true
  # end

  # with_options if: :item == :die do |die|
  #   die.validates :denomination, presence: false, allow_blank: true
  #   die.validates :sides, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  #   die.validates :colour, presence: true, inclusion: { in: %w(red, green, blue, yellow, black, white),
  #     message: "%{value} is not a valid die colour" }
  # end
end
