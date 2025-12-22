# frozen-string-literal: false

# Rook chess piece
class King < ChessPiece
  WHITE_SYMBOL = "\u2654".freeze
  BLACK_SYMBOL = "\u265A".freeze

  def initialize(color = :white, position = [0, 0])
    super(WHITE_SYMBOL, BLACK_SYMBOL, color, position)
  end
end
