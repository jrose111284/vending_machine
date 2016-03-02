require_relative 'product'

class VendingMachine
  VALID_COINS = %w(5 10 25)
  VALID_PRODUCTS = [Product.new('cola', 100), Product.new('chips', 50), Product.new('candy', 60)]

  attr_reader :coin_return, :coins, :hopper

  def initialize
    self.display = 'INSERT COIN'
    self.coins = []
    self.ready_to_reset = false
    self.ready_to_insufficient_payment_reset = false
  end

  def display
    handle_insufficient_payment_state
    handle_purchase_completed_state
    @display
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
    @product_name = product_name
    select_product
    vend
  end

  protected

  attr_reader :coins,
              :ready_to_reset,
              :product,
              :ready_to_insufficient_payment_reset

  private

  attr_writer :display,
              :coin_return,
              :coins,
              :ready_to_reset,
              :product, :hopper,
              :ready_to_insufficient_payment_reset

  def select_product
    name_matcher = -> (p) { p.name == @product_name }
    self.product = VALID_PRODUCTS.select(&name_matcher).first
  end

  def vend
    if self.product
      update_display
      dispense_product
    end
  end

  def dispense_product
    self.hopper = self.product if total == product.price
  end

  def total
    coins.map(&:to_i).inject(:+)
  end

  def update_display
    self.display = total == self.product.price ? 'Thank You' : "price #{product.price}"
  end

  def handle_insufficient_payment_state
    if self.ready_to_insufficient_payment_reset
      self.display = total ? "#{total} cents" : "INSERT COIN"
      self.ready_to_insufficient_payment_reset = false
    end
    self.ready_to_insufficient_payment_reset = true if @display.start_with? 'price'
  end

  def handle_purchase_completed_state
    initialize if self.ready_to_reset
    self.ready_to_reset = true if @display == 'Thank You'
  end
end
