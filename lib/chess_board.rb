# frozen-string-literal: false

require_relative 'knight'
require_relative 'pawn'
require 'colorize'

# move chess pieces, check if checkmate
class ChessBoard
  def initialize
    @board = Array.new(8) { Array.new(8) }

    # pawns
    (0..7).each do |column|
      @board[column][1] = Pawn.new
      @board[column][6] = Pawn.new
    end
  end

  def row(row_index)
    row_values = []
    (0..7).each do |column|
      row_values << @board[column][row_index]
    end

    row_values
  end

  def to_s
    board = "   | a | b | c | d | e | f | g | h\n"
    add_line(board)
    (1..8).reverse_each do |row|
      board << " #{row} |"

      (0..7).each do |column|
        square = @board[column][row - 1] || '-'
        board << " #{square} |"
      end

      board << "\n"
      add_line(board)
    end

    board << "   | a | b | c | d | e | f | g | h\n"
    board
  end

  private

  def add_line(msg)
    9.times { msg << '---|' }
    msg << "\n"
    msg
  end
end
