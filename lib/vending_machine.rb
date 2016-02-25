class VendingMachine
  VALID_COINS = %w(5 10 25)

  def display
    initialize if self.ready_to_reset
    self.ready_to_reset = true if @display == 'Thank You'
    @display
  end

  attr_reader :coin_return, :coins

  def initialize
    self.display = 'INSERT COIN'
    self.coins = []
    self.ready_to_reset = false
  end

  def insert(coin)
    if VALID_COINS.include? coin
      coins.push(coin)
      self.display = "#{total} cents"
    else
      self.coin_return = coin
    end
  end

  def button(product_name)
    self.display = 'Thank You'
  end

  def hopper
    Product.new 'cola', 100
  end

  protected

  attr_reader :coins, :ready_to_reset

  private

  def total
    coins.map(&:to_i).inject(:+)
  end

  attr_writer :display, :coin_return, :coins, :ready_to_reset
end
