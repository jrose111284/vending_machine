require 'vending_machine'

describe VendingMachine do
  context 'accepts coins' do
    it 'accepts a nickel and updates display' do
      subject.insert '5'
      expect(subject.display).to eq '5 cents'
    end

    it 'accepts dime and updates display' do
      subject.insert '10'
      expect(subject.display).to eq '10 cents'
    end

    it 'accepts quarter and updates display' do
      subject.insert '25'
      expect(subject.display).to eq '25 cents'
    end

    it 'accepts coin combo and updates display' do
      subject.insert '5'
      subject.insert '10'
      subject.insert '25'
      expect(subject.display).to eq '40 cents'
    end
  end

  context 'invalid coins' do
    it 'rejects a penny and updates display' do
      subject.insert '1'
      expect(subject.display).to eq 'INSERT COIN'
      expect(subject.coin_return).to eq '1'
    end

    it 'rejects a non-coin and updates display' do
      subject.insert '1wedwd3'
      expect(subject.display).to eq 'INSERT COIN'
      expect(subject.coin_return).to eq '1wedwd3'
    end
  end

  it 'displays INSERT COIN when no coins inserted' do
    expect(subject.display).to eq('INSERT COIN')
  end

  it { is_expected.to respond_to(:hopper) }
  it 'has a button to vend products' do
    subject.insert('25')
    subject.insert('25')
    subject.insert('25')
    subject.insert('25')
    subject.button('cola')
    expect(subject.display).to eq ('Thank You')
    expect(subject.display).to eq ('INSERT COIN')
    expect(subject.send(:coins)).to eq []
  end

  it 'displays price when correct money not reached' do
    subject.button('cola')
    expect(subject.display).to eq ('price 100')
  end

  xit 'displays price when correct money not reached' do
    subject.button('chips')
    expect(subject.display).to eq ('price 50')
  end

  it 'dispense chips if correct amount is inserted' do
    subject.insert '25'
    subject.insert '25'
    subject.button('chips')
    expect(subject.hopper.name).to eq('chips')
  end

  it 'successful purchase leads to a thank you' do
    subject.insert '25'
    subject.insert '25'
    subject.button('chips')
    expect(subject.display).to eq ('Thank You')
  end

  it 'will not allow the purchase of invalid products' do
    subject.button 'kitkat'
    expect(subject.display).to eq('INSERT COIN')
  end
end
