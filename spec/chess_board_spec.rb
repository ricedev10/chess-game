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
    after(:example) do
      puts chess_board
    end

    context 'when moving a pawn two steps forward' do
      it 'moves forward' do
        white_pawn = board[4][1]
        expect { chess_board.move([4, 1], [4, 3]) }.to change{ board[4][3] }.from(nil).to(white_pawn)
      end

      it 'sets previous position to nil' do
        white_pawn = board[4][1]
        expect { chess_board.move([4, 1], [4, 3]) }.to change{ board[4][1] }.from(white_pawn).to(nil)
      end
    end

    context 'when moving black pawn forward' do
      let(:black_pawn) { board[4][6] }

      it 'is a black pawn' do
        expect(black_pawn).to have_attributes(color: :black)
      end

      it 'moves forward' do
        expect { chess_board.move([4, 6], [4, 5]) }.to change{ board[4][5] }.from(nil).to(black_pawn)
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

    context 'when moving a knight' do
      it 'moves' do
        knight = board[1][0]

        expect(knight).to be_kind_of(Knight)
        expect { chess_board.move([1, 0], [2, 2]) }.to change{ board[2][2] }.from(nil).to(knight)
      end

      it 'errors if out of range' do
        knight = board[1][0]
        expect(knight).to be_kind_of(Knight)
        expect { chess_board.move([1, 0], [-1, 1]) }.to raise_error(RangeError)
      end
    end

    context 'when moving a bishop' do
      it 'moves when bishop when pawn is out of the way' do
        # remove the pawn blocking bishop
        board[3][1] = nil
        bishop = board[2][0]

        expect(bishop).to be_kind_of(Bishop)
        expect { chess_board.move([2, 0], [5, 3]) }.to change { board[5][3] }.from(nil).to(bishop)
      end
    end

    context 'when moving a rook' do
      it 'moves when moving vertically' do
        board[0][1] = nil # remove pawn blocking rook
        rook = board[0][0]

        expect(rook).to be_kind_of(Rook)
        expect { chess_board.move([0, 0], [0, 5]) }.to change { board[0][5] }.from(nil).to(rook)
      end

      it 'captures a pawn when moving forward' do
        board[0][1] = nil # remove pawn blocking rook
        rook = board[0][0]

        expect(rook).to be_kind_of(Rook)
        expect { chess_board.move([0, 0], [0, 6]) }.to change { board[0][6] }.to(rook)
      end

      it 'errors when trying to move between a pawn' do
        board[0][1] = nil # remove pawn blocking rook
        rook = board[0][0]

        expect(rook).to be_kind_of(Rook)
        expect { chess_board.move([0, 0], [0, 7]) }.to raise_error(StandardError)
      end

      it 'moves a rook horizontally' do
        rook = Rook.new
        board[2][3] = rook

        expect { chess_board.move([2, 3], [5, 3]) }.to change { board[5][3] }.from(nil).to(rook)
      end
    end
  end

  describe '#flipped_board' do
    context 'when board has a new game' do
      it 'has flipped the colors of black/white' do
        flipped = chess_board.flipped_board
        front_two_rows = []
        last_two_rows = []
        flipped.each do |column|
          front_two_rows << column[0]
          front_two_rows << column[1]

          last_two_rows << column[7]
          last_two_rows << column[6]
        end

        expect(front_two_rows).to all( have_attributes(color: :black) )
        expect(last_two_rows).to all( have_attributes(color: :white) )
      end
    end
  end
end
