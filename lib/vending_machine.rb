require_relative 'product'
require_relative 'coin_manger'

class VendingMachine
  VALID_PRODUCTS = [Product.new('cola', 100),
                    Product.new('chips', 50),
                    Product.new('candy', 60)]

  attr_reader :coin_return, :coins, :hopper

  def initialize
    self.display = 'INSERT COIN'
    self.coin_manger = CoinManger.new
    self.ready_to_reset = false
    self.ready_to_insufficient_payment_reset = false
    self.payment_sufficient = false
  end

  def display
    handle_insufficient_payment_state
    handle_purchase_completed_state
    @display
  end

  def insert(coin)
    self.display = "#{coin_manger.total} cents" if coin_manger.insert coin
    self.coin_return =coin_manger.coin_return
  end

  def button(product_name)
    @product_name = product_name
    select_product
    vend
  end

  private

  attr_writer :display,
              :coin_return,
              :hopper

  attr_accessor :product,
                :ready_to_reset,
                :ready_to_insufficient_payment_reset,
                :payment_sufficient,
                :product_name,
                :coin_manger

  def select_product
    name_matcher = -> (p) { p.name == @product_name }
    self.product = VALID_PRODUCTS.find(&name_matcher)
  end

  def vend
    return unless product
    dispense_product
    coin_manger.make_change product.price
    self.coin_return = coin_manger.coin_return
    update_display
  end

  def update_display
    self.display = payment_sufficient? ? 'Thank You' : "price #{product.price}"
  end

  def dispense_product
    self.hopper = product if payment_sufficient?
  end

  def payment_sufficient?
    @payment_sufficient ||= coin_manger.total >= product.price
  end

  def handle_insufficient_payment_state
    if ready_to_insufficient_payment_reset
      self.display = coin_manger.total > 0 ? "#{coin_manger.total} cents" : 'INSERT COIN'
      self.ready_to_insufficient_payment_reset = false
    end
    self.ready_to_insufficient_payment_reset = true if @display.start_with? 'price'
  end

  def handle_purchase_completed_state
    initialize if ready_to_reset
    self.ready_to_reset = true if @display == 'Thank You'
  end
end
