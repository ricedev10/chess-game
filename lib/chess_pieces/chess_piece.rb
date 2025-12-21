# defines a chess piece; where to move
class ChessPiece
  attr_accessor :color

  def initialize(white, black, color = :white)
    @color = color
    @white = white
    @black = black
  end

  def add_positions(position1, position2)
    [position1[0] + position2[0], position1[1] + position2[1]]
  end

  def to_s
    @color == :white ? @white : @black
  end
end
