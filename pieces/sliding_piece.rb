require_relative 'piece'

class SlidingPiece < Piece

  SIDEWAYS_DIRECTIONS = [[0, 1], [1, 0], [0, -1], [-1, 0]]
  DIAGONAL_DIRECTIONS = [[1, 1], [1, -1], [-1, -1], [-1, 1]]

  def initialize(color, position, board, move_distance = Float::INFINITY)
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

    valid_moves(moves)
  end

  def moves_in_dir(dir)
    moves = []
    pos = [position[0] + dir[0], position[1] + dir[1]]
    distance = 1

    while board.on_grid?(pos) && board.empty?(pos) && distance <= move_distance
      moves << pos
      pos = [pos[0] + dir[0], pos[1] + dir[1]]
      distance += 1
    end

    moves << pos unless distance > move_distance

    moves
  end

  private
  attr_reader :move_distance
end
