class Piece
  attr_reader :board, :color
  attr_accessor :position

  def initialize(color, position, board)
    @color, @position, @board = color, position, board
  end

  def valid_moves(moves)
    moves.select {|pos| board.on_grid?(pos) && board[pos].color != color}
  end
end
