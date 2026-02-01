require_relative 'chess_pieces/pawn'
require_relative 'algebraic_coordinate'

class ChessBoard
  HEIGHT = 8
  WIDTH = 8

  def initialize
    @squares = create_squares
  end

  def square_at(coordinate)
    file = coordinate[0]
    rank = coordinate[1].to_i

    raise ArgumentError, "Coordinate (#{file}#{rank}) is out of bounds." unless AlgebraicCoordinate.in_bounds?(file, rank)
    
    @squares[file.to_s.ord - 97][rank - 1]
  end

  def row_column_to_coordinate(row, column)
    "#{(row + 96).chr}#{column}".to_sym
  end

  def to_s
    out = ""
    out << letters
    out << horizontal_line

    (1..8).reverse_each do |column|
      out << "#{column} |"
      8.times do |row| 
        coordinate = row_column_to_coordinate(row + 1, column)
        out << " #{square_at(coordinate)} |" 
      end
      out << "\n"
      out << horizontal_line
    end

    out << letters
    out
  end

  private

  def letters
    row = "  | "
    (97..104).each do |i|
      row << "#{i.chr.upcase} | "
    end

    row << "\n"
    row
  end

  def horizontal_line
    line = "--|"
    8.times { line << "---|"}
    line << "\n"
    line
  end

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