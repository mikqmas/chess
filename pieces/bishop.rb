require_relative 'sliding_piece'
class Bishop < SlidingPiece
  def move_dirs
    [:diagonal]
  end

  def to_s
    " ♝ "
  end

  def num_points
    3
  end
end
