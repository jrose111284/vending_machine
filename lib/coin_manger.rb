class CoinManger
  VALID_COINS = %w(5 10 25)

  def initialize
    self.coins = []
  end

  def total
    coins.map(&:to_i).inject(:+) || 0
  end

  def insert coin
    coins.push(coin)  if VALID_COINS.include? coin
  end

  private
  attr_accessor :coins
end
