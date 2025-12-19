# defines a chess piece; where to move
class ChessPiece
  attr_accessor :color

  def initialize(white, black, color = :white)
    @color = color
    @white = white
    @black = black
  end

  def to_s
    @color == :white ? @white : @black
  end
end
