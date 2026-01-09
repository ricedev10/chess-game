class AlgebraicCoordinate
  # Create a coordinate for each square on a ChessBoard
  # @param file [String] the file of the square (ex. "a", "b", ...)
  # @param rank [Integer] the rank of the square from 1-8
  def initialize(file, rank)
    raise ArgumentError, "#{file} must be between a-h" unless (97..104).include?(file.ord)
    raise ArgumentError, "#{rank} must be between 1-8" unless (1..8).include?(rank)

    @file = file
    @rank = rank
  end

  # shifts the coordinate's file
  # @example shift the current file from a to b
  #   shift_file(1)
  #   
  # @example shift the current file from b to e
  #   shift_file(3)
  #   
  # @example shift the current file from b to a
  #   shift_file(-1)
  #   
  # @param increment [Integer] the amount to increment
  def shift_file(increment)
    @file = (@file.ord + increment).clamp(97, 104).chr
  end

  # shifts the coordinate's @rank by set increment. Clamped between 1-8.
  # 
  # @example shift the current @rank from 1 to 3
  #   shift_rank(2)
  #   
  # @ param increment [Integer] the amount to increment the @rank
  def shift_rank(increment)
    @rank = (@rank + increment).clamp(1, 8)
  end
end