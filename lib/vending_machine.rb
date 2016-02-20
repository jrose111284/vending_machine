class VendingMachine
  def initialize
    @display = 'INSERT COIN'
  end

  def insert coin
    @display = '5 cents'
  end

  def display
    @display
  end
end
