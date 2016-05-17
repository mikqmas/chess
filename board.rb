require_relative 'pieces_manifest'
require_relative 'illegal_move_error'

class Board
  attr_reader :grid, :last_piece_removed

  BOARD_SIZE = 8

  def initialize
    @grid = make_board
    @last_piece_removed = NullPiece.instance
  end

  def make_board
    Array.new(BOARD_SIZE) do |row_idx|
      Array.new(BOARD_SIZE) do |col_idx|
        piece_at([row_idx, col_idx])
      end
    end
  end

  def piece_at(pos)
    if pos[0] == 0
      if pos[1] == 0 || pos[1] == BOARD_SIZE - 1
        Rook.new(:white, pos, self)
      elsif pos[1] == 1 || pos[1] == BOARD_SIZE - 2
        Knight.new(:white, pos, self)
      elsif pos[1] == 2 || pos[1] == BOARD_SIZE - 3
        Bishop.new(:white, pos, self)
      elsif pos[1] == 4
        Queen.new(:white, pos, self)
      else
        King.new(:white, pos, self)
      end
    elsif pos[0] == BOARD_SIZE - 1
      if pos[1] == 0 || pos[1] == BOARD_SIZE - 1
        Rook.new(:black, pos, self)
      elsif pos[1] == 1 || pos[1] == BOARD_SIZE - 2
        Knight.new(:black, pos, self)
      elsif pos[1] == 2 || pos[1] == BOARD_SIZE - 3
        Bishop.new(:black, pos, self)
      elsif pos[1] == 4
        Queen.new(:black, pos, self)
      else
        King.new(:black, pos, self)
      end
    elsif pos[0] == 1
      Pawn.new(:white, pos, self)
    elsif pos[0] == BOARD_SIZE - 2
      Pawn.new(:black, pos, self)
    else
      NullPiece.instance
    end
  end

  def move(start_pos, end_pos)
    moving_piece = self[start_pos]
    raise IllegalMoveError unless moving_piece.moves.include?(end_pos)
    raise MoveIntoCheckError if move_into_check?(start_pos, end_pos)

    move!(start_pos, end_pos)
  end

  def checkmate?(color)
    #all color possible moves move into check
    pieces_colored(color).all? do |piece|
      piece.moves.all?{|move| move_into_check?(piece.position, move)}
    end
  end

  def on_grid?(pos)
    pos.all? {|term| term.between?(0, BOARD_SIZE - 1)}
  end

  def empty?(pos)
    on_grid?(pos) && self[pos].is_a?(NullPiece)
  end

  def size
    grid.length
  end

  def [](pos)
    row, col = pos
    grid[row][col]
  end

  def pieces_colored(color)
    pieces = []
    grid.each do |row|
      row.each do |piece|
        pieces << piece if piece.color == color
      end
    end
    pieces
  end

  private
  def move_into_check?(start_pos, end_pos)
    piece = self[start_pos]

    move!(start_pos, end_pos)
    check = in_check?(piece.color)
    undo_move(start_pos, end_pos)
    check
  end

  def in_check?(color)
    king_pos = king_position(color)
    opponents_moves = possible_moves(color == :black ? :white : :black)
    opponents_moves.include?(king_pos)
  end

  #for checking for future checks
  def move!(start_pos, end_pos)
    #save removed piece and then remove it
    @last_piece_removed = self[end_pos]
    self[end_pos] = NullPiece.instance

    self[start_pos], self[end_pos] = self[end_pos], self[start_pos]

    self[end_pos].position = end_pos
  end

  def undo_move(start_pos, end_pos)
    self[start_pos], self[end_pos] = self[end_pos], self[start_pos]

    #restore removed piece
    self[end_pos] = @last_piece_removed

    self[start_pos].position = start_pos
  end

  def king_position(color)
    pieces_colored(color).find {|piece| piece.is_a?(King)}.position
  end

  def possible_moves(color)
    pieces_colored(color).inject([]) do |possible_moves, piece|
      possible_moves + piece.moves
    end
  end


  def []=(pos, val)
    row, col = pos
    grid[row][col] = val
  end
end
