# frozen-string-literal: false

# Bishop chess piece
class Bishop < ChessPiece
  WHITE_SYMBOL = "\u2657".freeze
  BLACK_SYMBOL = "\u265D".freeze

  def initialize(color = :white)
    super(WHITE_SYMBOL, BLACK_SYMBOL, color)
  end
end
