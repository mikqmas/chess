class Piece
  attr_reader :board, :color
  attr_accessor :position,:has_moved

  def initialize(color, position, board)
    @color, @position, @board, @has_moved = color, position, board, false
  end

  def valid_moves(moves)
    moves.select {|pos| board.on_grid?(pos) && board[pos].color != color}
  end

  def inspect
    self.class.inspect + position.inspect + color.inspect
  end
end
