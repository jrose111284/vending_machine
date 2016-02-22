class VendingMachine
  VALID_COINS = ['5', '10', '25']
  attr_reader :display, :coin_return

  def initialize
    @display = 'INSERT COIN'
  end

  def insert coin
    if VALID_COINS.include? coin
      self.display = "#{coin} cents"
    else
      @coin_return = coin
    end
  end

  private
  attr_writer :display
end
