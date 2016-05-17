class Piece
  attr_reader :board, :color
  attr_accessor :position

  def initialize(color, position, board)
    @color, @position, @board = color, position, board
  end

  def move_into_check?(pos)
    start_pos = position.dup

    board.move(start_pos, pos)
    check = board.in_check?(color)
    board.undo_move(start_pos, pos)

    check
  end
end
