require 'coin_manger'
describe CoinManger do

  it "has zero total by deafult" do
    expect(subject.total).to eq(0)
  end

  context 'accepts coins' do
    it 'accepts a nickel and updates total' do
      subject.insert '5'
      expect(subject.total).to eq 5
    end

    it 'accepts dime and updates total' do
      subject.insert '10'
      expect(subject.total).to eq 10
    end

    it 'accepts quarter and updates total' do
      subject.insert '25'
      expect(subject.total).to eq 25
    end

    it 'accepts coin combo and updates total' do
      subject.insert '5'
      subject.insert '10'
      subject.insert '25'
      expect(subject.total).to eq 40
    end
  end

  context 'invalid coins' do
    it 'rejects a penny and updates display' do
      subject.insert '1'
      expect(subject.total).to eq 0
    end

    it 'rejects a 50 cent coin and updates display' do
      subject.insert '50'
      expect(subject.total).to eq 0
    end

    it 'rejects a non-coin and updates display' do
      subject.insert '1wedwd3'
      expect(subject.total).to eq 0
    end
  end

  describe '#make_change' do

    it 'will return coins given over payment' do
      subject.insert('25')
      subject.insert('25')
      subject.insert('10')
      subject.insert('10')
      subject.insert('5')
      subject.make_change (65)
      expect(subject.coin_return).to eq('10')
    end
  end

end
