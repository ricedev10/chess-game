# frozen-string-literal: false

# Rook chess piece
class Rook < ChessPiece
  WHITE_SYMBOL = "\u2656".freeze
  BLACK_SYMBOL = "\u265C".freeze

  def initialize(color = :white, position = [0, 0])
    super(WHITE_SYMBOL, BLACK_SYMBOL, color, position)
  end

  def can_move_to?(board, new_position)
    current_position = @position
    if current_position[0] != new_position[0] && current_position[1] != new_position[1]
      raise RangeError,
            'Must be perpendicular'
    end

    position = current_position
    offset = [
      current_position[0] == new_position[0] ? 0 : 1,
      current_position[1] == new_position[1] ? 0 : 1
    ]

    loop do
      position = add_positions(position, offset)

      return true if position == new_position

      object = board[position[0]][position[1]]
      raise StandardError, "Blocked by #{object} at #{position}" unless object.nil?
    end
  end
end
