require_relative 'piece'

class Knight < Piece
  def moves
    row, col = position
    moves = [[row - 1, col - 2], [row - 2, col - 1], [row -2, col + 1],
    [row - 1, col + 2], [row + 1, col + 2], [ row + 2, col + 1],
    [row + 2, col -1], [row + 1, col - 2]]

    moves.select {|pos| valid_move?(pos)}
  end

  def valid_move?(pos)
    board.on_grid?(pos) &&
      (board[pos].is_a?(NullPiece) || board[pos].color !=  self.color)
  end

  def to_s
    " ♞ "
  end
end
