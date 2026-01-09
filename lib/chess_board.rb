require_relative 'square'
require_relative 'chess_pieces/pawn'

class ChessBoard
  HEIGHT = 8
  WIDTH = 8

  include Pawn

  def initialize
    @squares = create_squares
  end


  private

  def create_squares
    squares = []
    HEIGHT.times do |i|

    end
  end
end