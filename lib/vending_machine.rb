class VendingMachine
  attr_reader :display

  def initialize
    @display = 'INSERT COIN'
  end

  def insert coin
    self.display = "#{coin} cents"
  end

  private
  attr_writer :display
end
