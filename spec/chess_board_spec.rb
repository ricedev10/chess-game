require_relative '../lib/chess_board'
require_relative '../lib/chess_pieces/pawn'

describe ChessBoard do
  subject(:chess_board) { described_class.new }

  describe '#initialize' do
    matcher :be_count_of do |length|
      match { |array| array.count == length }
    end

    it 'initializes a chess board grid' do
      board = chess_board.instance_variable_get(:@board)
      expect(board).to be_count_of(8)
      expect(board).to be_all{ |column| column.count == 8 }
    end

    it 'has pawns in correct positions' do
      board = chess_board.instance_variable_get(:@board)
      pawns = board.map { |column| [column[1], column[6]] }.flatten
      expect(pawns).to all( be_kind_of(Pawn) )
    end
  end

  describe '#row' do
    context 'when first row contains pawns' do
      let(:board) { Array.new(8) { Array.new(8) } }
      before do
        chess_board.instance_variable_set(:@board, board)
        (0..7).each do |column|
          board[column][0] = Pawn.new
        end
      end

      it 'has pawns in first row' do
        first_row = chess_board.row(0)
        expect(first_row).to all be_kind_of(Pawn)
      end
    end

    context 'when third row contains pawns' do
      let(:board) { Array.new(8) { Array.new(8) } }
      before do
        chess_board.instance_variable_set(:@board, board)
        (0..7).each do |column|
          board[column][2] = Pawn.new
        end
      end

      it 'has pawns in third row' do
        first_row = chess_board.row(2)
        expect(first_row).to all be_kind_of(Pawn)
      end
    end
  end

  describe '#to_s' do
    it 'puts the board' do
      puts "\n#{chess_board}"
    end
  end
end
