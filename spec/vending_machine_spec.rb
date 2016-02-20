require 'vending_machine'

describe VendingMachine do
  it 'accepts coind and updates display' do
    subject.insert '5'
    expect(subject.display).to eq '5 cents'
  end

  it "displays INSERT COIN when no coins inserted" do
    expect(subject.display).to eq('INSERT COIN')

  end
end
