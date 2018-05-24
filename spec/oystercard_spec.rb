require 'oystercard'


describe Oystercard do

  subject(:oystercard) { described_class.new }

    it 'checks initial balance' do
      expect(oystercard.balance).to eq(0)
    end

    describe '#top_up' do

      it 'can top up the balance' do
        expect { oystercard.top_up(50) }.to change { oystercard.balance }.by(50)
      end

      it 'raises an error when balance is above £90' do
        oystercard.top_up(Oystercard::MAXIMUM_BALANCE)
        error = "Balance cannot be above £ #{Oystercard::MAXIMUM_BALANCE}"
        expect { oystercard.top_up(1) }.to raise_error error
      end
    end

    let(:station) { double :station }

    describe '#touch_in' do
      it 'raises an error if insufficient funds on the card' do
        expect { oystercard.touch_in(station) }.to raise_error "Insufficient funds"
      end

      it 'starts a journey' do
        journey_class_double = double :journey_class
        journey_double = double :journey
        allow(journey_class_double).to receive(:new).and_return(journey_double)

        expect(journey_class_double).to receive(:new)
        other_oyster_card = Oystercard.new(journey_class_double, 20)
        other_oyster_card.touch_in("algate")

      end
    end

    describe '#journey_history' do
      it 'card starts with no history' do
        expect(oystercard.journey_history).to eq ({})
      end
  end
end
