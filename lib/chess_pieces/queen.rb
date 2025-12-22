# frozen-string-literal: false

# Queen chess piece
class Queen < ChessPiece
  WHITE_SYMBOL = "\u2655".freeze
  BLACK_SYMBOL = "\u265B".freeze

  def initialize(color = :white, position = [0, 0])
    super(WHITE_SYMBOL, BLACK_SYMBOL, color, position)
  end

  def can_move_to?(board, new_position)
    # implement both bishop and rook functionality
    current_position = @position

    position1 = current_position
    position2 = current_position
    offset_perpendicular = [
      current_position[0] == new_position[0] ? 0 : 1,
      current_position[1] == new_position[1] ? 0 : 1
    ]
    offset_diagonal = [
      current_position[0] < new_position[0] ? 1 : -1,
      current_position[1] < new_position[1] ? 1 : -1
    ]

    loop do
      position1 = add_positions(position1, offset_perpendicular)
      position2 = add_positions(position2, offset_diagonal)

      return true if position1 == new_position || position2 == new_position

      object = board[position1[0]][position1[1]]
      unless object.nil?
        raise StandardError,
              "Blocked by #{object} at #{position1} when trying to move from #{current_position} to #{new_position}"
      end
    end

    raise StandardError, "#{new_position} -> #{current_position} is not a valid move"
  end
end
