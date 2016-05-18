require_relative 'piece'

class Pawn < Piece

  def moves
    moves = []
    row, col = position

    # move forawrd
    pos = [row + forward, col]
    moves << pos if board.empty?(pos)

    #en passant move
    unless has_moved
      pos = [row + forward*2, col]
      moves << pos if board.empty?(pos)
    end

    # move diagonal
    [[row + forward, col - 1], [row + forward, col + 1]].each do |move|
      moves << move unless board.empty?(move)
    end

    valid_moves(moves)
  end

  def forward
    self.color == :white ? 1 : -1
  end

  def to_s
    " ♟ "
  end

  def num_points
    1
  end
end
