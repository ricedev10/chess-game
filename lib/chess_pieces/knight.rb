require_relative 'chess_piece'

# knight chess piece
class Knight < ChessPiece
  WHITE_SYMBOL = "\u2658".freeze
  BLACK_SYMBOL = "\u265E".freeze

  def initialize(color = :white)
    super(WHITE_SYMBOL, BLACK_SYMBOL, color)
  end
end
