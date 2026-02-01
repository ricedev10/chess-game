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

  describe '#square_at' do
    subject(:board) { described_class.new }
    context 'when file=a, and rank=1' do
      it 'returns an AlgebraicCoordinate' do
        expect(board.square_at(:a1)).to be_kind_of(AlgebraicCoordinate)
      end

      it 'has coordinates a1' do
        square = board.square_at(:a1)

        expect(square.file).to eql(:a)
        expect(square.rank).to eql(1)
      end
    end

    context 'when file=e and rank=8' do
      it 'returns an AlgebraicCoordinate' do
        square = board.square_at(:e8)
        expect(square).to be_kind_of(AlgebraicCoordinate)
      end

      it 'has coordinates e8' do
        square = board.square_at(:e8)
        
        expect(square.file).to eql(:e)
        expect(square.rank).to eql(8)
      end
    end

    context 'when file/rank is out of bounds' do
      it 'raises an error' do
        expect{ board.square_at(:e9) }.to raise_error(ArgumentError)
      end
    end
  end
end