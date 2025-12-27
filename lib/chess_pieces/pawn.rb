# frozen-string-literal: false

# Pawn for chess
class Pawn < ChessPiece
  WHITE_SYMBOL = "\u2659".freeze
  BLACK_SYMBOL = "\u265F".freeze

  def initialize(color = :white, position = [0, 0])
    super(WHITE_SYMBOL, BLACK_SYMBOL, color, position)
  end

  def can_move_to?(board, new_position)
    current_position = @position

    return [false, 'Can only move vertically'] unless current_position[0] == new_position[0]

    distance = (new_position[1] - current_position[1])
    return [false, 'Must move 1-2 steps forwards'] unless (1..2).include?(distance)

    return [false, 'Something blocking pawn'] if distance == 2 && !board[new_position[0]][new_position[1] - 1].nil?

    true
  end
end
