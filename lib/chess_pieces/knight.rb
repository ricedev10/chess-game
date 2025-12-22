require_relative 'chess_piece'

# knight chess piece
class Knight < ChessPiece
  WHITE_SYMBOL = "\u2658".freeze
  BLACK_SYMBOL = "\u265E".freeze

  def initialize(color = :white, position = [0, 0])
    @moves = [
      [-1, 2],
      [1, 2],
      [2, 1],
      [2, -1],
      [1, -2],
      [-1, -2],
      [-2, -1],
      [-2, 1]
    ].freeze

    super(WHITE_SYMBOL, BLACK_SYMBOL, color, position)
  end

  def can_move_to?(_board, new_position)
    current_position = @position
    return [true] if @moves.any? { |offset| add_positions(current_position, offset) == new_position }

    [false, 'Invalid position']
  end
end
