class Item < ApplicationRecord
  belongs_to :user

  validates :item, inclusion: { in: %w(coin die), message: "type '%{value}' is not a valid item - must be 'coin' or 'die'" }

  with_options if: :is_coin? do |coin|
    coin.validates :denomination, presence: true, numericality: { greater_than: 0.0 }, format: { with: /\A(0.05|0.1|0.10|0.25|1|1.0|1.00|2|2.0|2.00)\z/,
      message: "value '%{value}' is not a valid coin denomination." }
    coin.validates :sides, presence: false, allow_blank: true
    coin.validates :colour, presence: false, allow_blank: true
  end

  with_options if: :is_die? do |die|
    die.validates :denomination, presence: false, allow_blank: true
    die.validates :sides, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }, allow_blank: false
    die.validates :colour, presence: true, inclusion: { in: %w(red, green, blue, yellow, black, white), message: "value '%{value}' is not a valid die colour" }, allow_blank: false
  end

  def is_coin?
    item == :coin
  end

  def is_die?
    item == :die
  end
end
