require_relative 'sliding_piece'

class Queen < SlidingPiece
  def move_dirs
    [:sideways, :diagonal]
  end

  def to_s
    " ♛ "
  end
end
