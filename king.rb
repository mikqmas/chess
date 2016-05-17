require_relative 'sliding_piece'

class King < SlidingPiece
  def initialize(color, position, board)
    super(color, position, board, 1)
  end

  def move_dirs
    [:sideways, :diagonal]
  end

  def to_s
    " ♚ "
  end
end
