require_relative '../lib/algebraic_coordinate'

describe AlgebraicCoordinate do
  subject(:coordinate) { described_class.new(:a, 1) }

  describe '#initialize' do
    context 'when file is out of bounds' do
      it 'raises an error' do
        expect{ described_class.new(:i, 2) }.to raise_error(ArgumentError)
      end
    end

    context 'when rank is out of bounds' do
      it 'raises an error' do
        expect{ described_class.new(:a, 12) }.to raise_error(ArgumentError)
      end
    end
  end

  describe '#shift_file' do
    context 'shifting a positive amount (a -> b)' do
      it 'shifts +1' do
        expect{ coordinate.shift_file(1) }.to change{ coordinate.instance_variable_get(:@file) }.from(:a).to(:b)
      end
    end
    
    context 'shifting a negative amount (b -> a)' do
      subject(:coordinate) { described_class.new(:b, 1) }

      it 'shifts -1' do
        expect{ coordinate.shift_file(-1) }.to change{ coordinate.instance_variable_get(:@file) }.from(:b).to(:a)
      end
    end

    context 'when shifting negative' do
      it 'clamps' do
        expect{ coordinate.shift_file(-1) }.not_to change{ coordinate.instance_variable_get(:@file) }
      end
    end

    context 'when shifting over bounds' do
      subject(:coordinate) { described_class.new(:h, 1) }
      it 'clamps' do
        expect{ coordinate.shift_file(1) }.not_to change{ coordinate.instance_variable_get(:@file) }
      end
    end
  end

  describe '#shift_rank' do
    context 'when shifting from 1 to 8' do
      subject(:coordinate) { described_class.new(:a, 1) }

      it 'shifts with positive increment' do
        expect{ coordinate.shift_rank(7) }.to change{ coordinate.instance_variable_get(:@rank) }.from(1).to(8)
      end
    end

    context 'when shifting from 8 to 1' do
      subject(:coordinate) { described_class.new(:d, 8) }

      it 'shifts with negative increment' do
        expect{ coordinate.shift_rank(-7) }.to change{ coordinate.instance_variable_get(:@rank) }.from(8).to(1)
      end
    end
  end
end