class VendingMachine
  attr_reader :display

  def initialize
    @display = 'INSERT COIN'
  end

  def insert coin
    @display = '5 cents'
  end
end
