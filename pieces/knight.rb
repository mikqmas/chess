require_relative 'piece'

class Knight < Piece
  def moves
    row, col = position
    moves = [[row - 1, col - 2], [row - 2, col - 1], [row -2, col + 1],
    [row - 1, col + 2], [row + 1, col + 2], [ row + 2, col + 1],
    [row + 2, col -1], [row + 1, col - 2]]

    valid_moves(moves)
  end

  def to_s
    " N "
  end
end
