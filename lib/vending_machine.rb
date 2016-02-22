class VendingMachine

  VALID_COINS = ['5', '10', '25']

  attr_reader :display, :coin_return

  def initialize
    self.display = 'INSERT COIN'
    @coins = []
  end

  def insert coin
    @coins << coin
    if VALID_COINS.include? coin
      self.display = "#{total} cents"
    else
      self.coin_return = coin
    end
  end

  private

  def total
    @coins.map(&:to_i).inject(:+)
  end

  attr_writer :display, :coin_return, :coins
end
