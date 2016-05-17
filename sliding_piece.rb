require_relative 'piece'

class SlidingPiece < Piece

  SIDEWAYS_DIRECTIONS = [[0, 1], [1, 0], [0, -1], [-1, 0]]
  DIAGONAL_DIRECTIONS = [[1, 1], [1, -1], [-1, -1], [-1, 1]]

  def initialize(color, position, board, move_distance = -1)
    super(color, position, board)
    @move_distance = move_distance
  end

  def moves
    moves = []
    if move_dirs.include?(:sideways)
      SIDEWAYS_DIRECTIONS.each do |dir|
        moves.concat(moves_in_dir(dir))
      end
    end

    if move_dirs.include?(:diagonal)
      DIAGONAL_DIRECTIONS.each do |dir|
        moves.concat(moves_in_dir(dir))
      end
    end

    moves
  end

  def moves_in_dir(dir)
    distance = 0
    moves = []
    pos = position.dup
    pos[0] += dir[0]
    pos[1] += dir[1]
    while board.on_grid?(pos) && board[pos].is_a?(NullPiece) && distance != move_distance
      moves << pos.dup
      pos[0] += dir[0]
      pos[1] += dir[1]
      distance += 1
    end
    if distance != move_distance && board.on_grid?(pos) && !board[pos].is_a?(NullPiece) && board[pos].color != self.color
      moves << pos.dup
    end
    moves
  end

  private
  attr_reader :move_distance
end
