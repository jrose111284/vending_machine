class VendingMachine
  attr_reader :display, :coin_return

  def initialize
    @display = 'INSERT COIN'
  end

  def insert coin
    if coin == '1'
      @coin_return = coin
      return
    end
    self.display = "#{coin} cents"
  end

  private
  attr_writer :display
end
