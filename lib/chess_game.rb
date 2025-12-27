# frozen-string-literal: false

require_relative 'chess_board'

# Plays a chess game in the console
class ChessGame
  def initialize
    @board = ChessBoard.new
    @letters = {
      a: 0,
      b: 1,
      c: 2,
      d: 3,
      e: 4,
      f: 5,
      g: 6,
      h: 7
    }
  end

  def start
    3.times do
      play_round
    end
  end

  def play_round
    puts 'Starting a new chess game'
    puts @board
    loop do
      position1, position2 = valid_input
      begin
        p "what - #{position1}"
        p position2
        raise StandardError, 'what the heck' if position1.nil?

        @board.move(position1, position2)
        break
      rescue StandardError => e
        puts "Invalid move: #{e.message}"
      end
    end
  end

  private

  def valid_input
    puts "Enter a move (#{@board.next_player}'s turn): "

    input = gets.chomp.downcase
    until /^[a-h][1-8] [a-h][1-8]$/.match?(input) && input[0..1] != input[3..4]
      puts 'Invalid input. Input starting position and end position. (ex. "a2 a4")'
      input = gets.chomp.downcase
    end

    to_positions(input)
  end

  def to_positions(input)
    [
      [@letters[input[0].to_sym], input[1].to_i - 1],
      [@letters[input[3].to_sym], input[4].to_i - 1]
    ]
  end
end
