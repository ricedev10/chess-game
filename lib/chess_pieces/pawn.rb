# frozen-string-literal: false

# Pawn for chess
class Pawn < ChessPiece
  WHITE_SYMBOL = "\u2659".freeze
  BLACK_SYMBOL = "\u265F".freeze

  def initialize(color = :white)
    super(WHITE_SYMBOL, BLACK_SYMBOL, color)
  end
end
