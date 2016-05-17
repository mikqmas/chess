require_relative 'piece'

class Pawn < Piece
  def moves
    moves = []
    row, col = position
    pos = [row+forward,col]
    if board.on_grid?(pos) && board[pos].is_a?(NullPiece)
      moves << pos
    end
    pos = [row+forward,col-1]
    if board.on_grid?(pos) && !board[pos].is_a?(NullPiece) && board[pos].color != self.color
      moves << pos
    end
    pos = [row+forward,col+1]
    if board.on_grid?(pos) && !board[pos].is_a?(NullPiece) && board[pos].color != self.color
      moves << pos
    end

    moves
  end

  def forward
    self.color == :black ? 1 : -1
  end

  def to_s
    " ♟ "
  end
end
