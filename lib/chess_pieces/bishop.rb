# frozen-string-literal: false

# Bishop chess piece
class Bishop < ChessPiece
  WHITE_SYMBOL = "\u2657".freeze
  BLACK_SYMBOL = "\u265D".freeze

  def initialize(color = :white, position = [0, 0])
    super(WHITE_SYMBOL, BLACK_SYMBOL, color, position)
  end

  def can_move_to?(board, new_position)
    current_position = @position
    position = current_position
    offset = [
      current_position[0] < new_position[0] ? 1 : -1,
      current_position[1] < new_position[1] ? 1 : -1
    ]

    loop do
      position = add_positions(position, offset)
      raise RangeError, 'Position must be diagonal' unless in_range?(position)

      object = board[position[0]][position[1]]
      return true if position == new_position
      raise StandardError, "Blocked by #{object}" unless object.nil?
    end
  end
end
