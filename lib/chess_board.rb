# frozen-string-literal: false

require_relative 'chess_pieces/knight'
require_relative 'chess_pieces/pawn'
require_relative 'chess_pieces/rook'
require_relative 'chess_pieces/bishop'
require_relative 'chess_pieces/queen'
require_relative 'chess_pieces/king'
require 'colorize'

# move chess pieces, check if checkmate
class ChessBoard
  def initialize
    @board = Array.new(8) { Array.new(8) }
    spawn_pieces
  end

  def row(row_index)
    row_values = []
    (0..7).each do |column|
      row_values << @board[column][row_index]
    end

    row_values
  end

  def to_s # rubocop:disable Metrics/MethodLength
    board = "     a   b   c   d   e   f   g   h\n"
    add_line(board)
    (1..8).reverse_each do |row|
      board << " #{row} |"

      (0..7).each do |column|
        square = @board[column][row - 1] || ' '
        board << " #{square} |"
      end

      board << " #{row}\n"
      add_line(board)
    end

    board << "     a   b   c   d   e   f   g   h\n"
    board
  end

  def move(position, new_position)
    raise RangeError if new_position[0].negative? || new_position[1].negative?

    chess_piece = @board[position[0]][position[1]]
    raise StandardError, "Chess piece does not exist at #{new_position}" if chess_piece.nil?

    can_move, error_msg =
      if chess_piece.color == :white
        chess_piece.can_move_to?(
          @board,
          # position,
          new_position
        )
      else
        chess_piece.can_move_to?(
          flipped_board,
          # [position[0], 7 - position[1]],
          [new_position[0], 7 - new_position[1]]
        )
      end

    raise(ArgumentError, error_msg) unless can_move

    @board[new_position[0]][new_position[1]] = chess_piece
    @board[position[0]][position[1]] = nil
  end

  def flipped_board
    board = Array.new(8) { Array.new(8, nil) }
    (0..7).each do |column|
      (0..7).each do |row|
        board[column][7 - row] = @board[column][row]
      end
    end

    board
  end

  private

  def add_line(msg)
    msg << '   |'
    8.times { msg << '---|' }
    msg << "\n"
    msg
  end

  def add_pieces_to_board(piece, columns, rows = [0, 7])
    columns.each do |column|
      @board[column][rows[0]] = piece.new(:white, [column, rows[0]])
      @board[column][rows[1]] = piece.new(:black, [column, 7 - rows[1]])
    end
  end

  def spawn_pieces
    # add pawns
    add_pieces_to_board(Pawn, 0..7, [1, 6])

    # add rooks
    add_pieces_to_board(Rook, [0, 7])

    # add knights
    add_pieces_to_board(Knight, [1, 6])

    # add bishop
    add_pieces_to_board(Bishop, [2, 5])

    # add queen/king
    add_pieces_to_board(Queen, [3])
    add_pieces_to_board(King, [4])
  end
end
