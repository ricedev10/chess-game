require_relative 'chess_pieces/pawn'
require_relative 'algebraic_coordinate'

class ChessBoard
  HEIGHT = 8
  WIDTH = 8

  def initialize
    @squares = create_squares
  end


  private

  def create_squares
    squares = Array.new(WIDTH) { Array.new(HEIGHT, nil) }
    HEIGHT.times do |h|
      WIDTH.times do |w|
        file = (w + 97).chr
        rank = h + 1

        squares[w][h] = AlgebraicCoordinate.new(file, rank)
      end
    end

    squares
  end

  def get_square_at(file, rank)
    @squares[file.ord - 97][rank - 1]
  end
end