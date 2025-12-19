# frozen-string-literal: false

# Rook chess piece
class Rook < ChessPiece
  WHITE_SYMBOL = "\u2656".freeze
  BLACK_SYMBOL = "\u265C".freeze

  def initialize(color = :white)
    super(WHITE_SYMBOL, BLACK_SYMBOL, color)
  end
end
