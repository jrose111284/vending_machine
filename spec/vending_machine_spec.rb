require 'vending_machine'

describe VendingMachine do

context "accepts coins" do
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
end

  it "displays INSERT COIN when no coins inserted" do
    expect(subject.display).to eq('INSERT COIN')
  end
end
