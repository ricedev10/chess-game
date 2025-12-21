require_relative 'chess_piece'

# knight chess piece
class Knight < ChessPiece
  WHITE_SYMBOL = "\u2658".freeze
  BLACK_SYMBOL = "\u265E".freeze

  def initialize(color = :white)
    @valid_moves = [
      [-1, 2],
      [1, 2],
      [2, 1],
      [2, -1],
      [1, -2],
      [-1, -2],
      [-2, -1],
      [-2, 1]
    ].freeze

    super(WHITE_SYMBOL, BLACK_SYMBOL, color)
  end

  def can_move_to?(board, current_position, new_position)
    return [true] if @valid_moves.any? { |offset| add_positions(current_position, offset) == new_position }

    [false, 'Invalid position']
  end
end
