require_relative '../lib/chess_board'
require_relative '../lib/chess_pieces/pawn'

describe ChessBoard do
  subject(:chess_board) { described_class.new }
  let(:board) { chess_board.instance_variable_get(:@board) }

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

  describe '#move' do
    after(:each) do
      puts chess_board
    end

    context 'when moving a pawn two steps forward' do
      it 'moves forward' do
        board = chess_board.instance_variable_get(:@board)
        white_pawn = board[4][1]
        expect { chess_board.move([4, 1], [4, 3]) }.to change{ board[4][3] }.from(nil).to(white_pawn)
      end
    end

    context 'when moving pawn illegally' do
      it 'errors when moving backwards' do
        expect { chess_board.move([4, 1], [4, 0]) }.to raise_error(ArgumentError)
      end
    end

    context 'when pawn is blocked' do
      before do
        board[4][2] = Pawn.new
      end

      it 'errors' do
        expect { chess_board.move([4, 1], [4, 3]) }.to raise_error(ArgumentError)
      end
    end
  end
end
