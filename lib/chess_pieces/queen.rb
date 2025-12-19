# frozen-string-literal: false

# Rook chess piece
class Queen < ChessPiece
  WHITE_SYMBOL = "\u2655".freeze
  BLACK_SYMBOL = "\u265B".freeze

  def initialize(color = :white)
    super(WHITE_SYMBOL, BLACK_SYMBOL, color)
  end
end
