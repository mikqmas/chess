require_relative 'null_piece'
require_relative 'bishop'
require_relative 'rook'
require_relative 'knight'
require_relative 'pawn'
require_relative 'king'
require_relative 'queen'

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
        Rook.new(:black, pos, self)
      elsif pos[1] == 1 || pos[1] == BOARD_SIZE - 2
        Knight.new(:black, pos, self)
      elsif pos[1] == 2 || pos[1] == BOARD_SIZE - 3
        Bishop.new(:black, pos, self)
      elsif pos[1] == 3
        Queen.new(:black, pos, self)
      else
        King.new(:black, pos, self)
      end
    elsif pos[0] == BOARD_SIZE - 1
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
    elsif pos[0] == 1
      Pawn.new(:black, pos, self)
    elsif pos[0] == BOARD_SIZE - 2
      Pawn.new(:white, pos, self)
    else
      NullPiece.instance
    end
  end

  def move(start_pos, end_pos)
    moving_piece = self[start_pos]
    raise ArgumentError if moving_piece.is_a?(NullPiece)
    raise ArgumentError unless moving_piece.moves.include?(end_pos)

    @last_piece_removed = self[end_pos]

    self[end_pos] = moving_piece
    self[start_pos] = NullPiece.instance

    moving_piece.position = end_pos
  end

  def undo_move(start_pos, end_pos)
    moving_piece = self[end_pos]

    self[start_pos] = moving_piece
    self[end_pos] = @last_piece_removed

    moving_piece.position = start_pos
  end

  def in_check?(color)
    king_pos = king_position(color)
    opponents_moves = possible_moves(color == :black ? :white : :black)
    opponents_moves.include?(king_pos)
  end

  def checkmate?(color)
    possible_moves(color).empty?
  end

  def king_position(color)
    @grid.each do |row|
      row.each do |piece|
        return piece.position if piece.is_a?(King) && piece.color == color
      end
    end
  end

  def possible_moves(color)
    possible_moves = []
    @grid.each do |row|
      row.each do |piece|
        possible_moves += piece.moves if !piece.is_a?(NullPiece) && piece.color == color
      end
    end
    possible_moves
  end

  def on_grid?(pos)
    pos.all? {|term| term.between?(0, BOARD_SIZE - 1)}
  end

  def [](pos)
    row, col = pos
    grid[row][col]
  end

  def []=(pos, val)
    row, col = pos
    grid[row][col] = val
  end

  def size
    grid.length
  end
end
