require_relative '../lib/chess_board'
require_relative '../lib/algebraic_coordinate'

describe ChessBoard do
  describe '#initialize' do
    context 'when creating a new board' do
      subject(:board) { described_class.new }
      let(:squares) { board.instance_variable_get(:@squares) }

      matcher :be_length_of do |expected|
        match do |actual|
          actual.length == expected
        end
      end

      it 'has an @squares array' do
        expect(squares).to be_kind_of(Array)
      end

      it 'has @squares with length of 8' do
        expect(squares).to be_kind_of(Array)
      end

      it 'has @squares with each an array of length 8' do
        expect(squares).to all( be_length_of(ChessBoard::WIDTH) )
      end

      it 'has @squares with each value of AlgebraicCoordinate' do
        values = squares.flatten
        expect(values).to all( be_kind_of(AlgebraicCoordinate) )
      end
    end
  end
end