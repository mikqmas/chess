class Piece
  attr_reader :board, :color, :has_moved, :position

  def initialize(color, position, board)
    @color, @position, @board, @has_moved = color, position, board, false
  end

  def position=(position)
    @position = position
    @has_moved = true
  end

  def valid_moves(moves)
    moves.select {|pos| board.on_grid?(pos) && board[pos].color != color}
  end
end
