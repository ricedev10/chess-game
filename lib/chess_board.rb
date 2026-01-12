require_relative 'chess_pieces/pawn'
require_relative 'algebraic_coordinate'

class ChessBoard
  HEIGHT = 8
  WIDTH = 8

  def initialize
    @squares = create_squares
  end

  def square_at(file, rank)
    raise ArgumentError, "Coordinate (#{file}#{rank}) is out of bounds." unless AlgebraicCoordinate.in_bounds?(file, rank)
    
    @squares[file.to_s.ord - 97][rank - 1]
  end


  private

  def create_squares
    squares = Array.new(WIDTH) { Array.new(HEIGHT, nil) }
    HEIGHT.times do |h|
      WIDTH.times do |w|
        file = (w + 97).chr.to_sym
        rank = h + 1

        squares[w][h] = AlgebraicCoordinate.new(file, rank)
      end
    end

    squares
  end
end