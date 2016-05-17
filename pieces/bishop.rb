require_relative 'sliding_piece'

class Bishop < SlidingPiece
  def move_dirs
    [:diagonal]
  end

  def to_s
    " B "
  end
end
