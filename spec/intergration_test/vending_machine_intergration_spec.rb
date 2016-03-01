require 'vending_machine'

describe VendingMachine do
  it 'can handle a sequence of invalid and vaild coins' do
    subject.insert('llama')
    expect(subject.display).to eq('INSERT COIN')
    expect(subject.coin_return).to eq('llama')
    subject.insert('1')
    expect(subject.display).to eq('INSERT COIN')
    expect(subject.coin_return).to eq('1')
    subject.insert('5')
    expect(subject.display).to eq('5 cents')
    subject.insert('25')
    expect(subject.display).to eq('30 cents')
  end

  it'dispense a product (cola)'do
    subject.insert('25')
    subject.insert('25')
    subject.insert('25')
    subject.insert('25')
    subject.button('cola')
    expect(subject.hopper.name).to eq('cola')
    expect(subject.display).to eq ('Thank You')
    expect(subject.display).to eq ('INSERT COIN')
    expect(subject.send(:coins)).to eq []
  end

  it'does not dispense a product with insufficient payment' do
    subject.insert('25')
    subject.insert('25')
    subject.button('cola')
    expect(subject.display).to eq ('price 100')
      expect(subject.display).to eq ('50 cents')
  end

  it'does not dispense a product with no payment' do
    subject.button('cola')
    expect(subject.display).to eq ('price 100')
      expect(subject.display).to eq ('INSERT COIN')
  end

  it'dispense a product if price is correct (chips)'do
    subject.insert('25')
    subject.insert('25')
    subject.button('chips')
    expect(subject.hopper.name).to eq('chips')
    expect(subject.display).to eq ('Thank You')
    expect(subject.display).to eq ('INSERT COIN')
    expect(subject.send(:coins)).to eq []
  end

  it 'will not allow the purchase of invalid products' do
    subject.button 'kitkat'
    expect(subject.display).to eq('INSERT COIN')
    expect(subject.hopper).to be(nil)
  end

end
