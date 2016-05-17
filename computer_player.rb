
require_relative 'illegal_move_error'

class ComputerPlayer
  attr_reader :name, :board, :color

  def initialize(name, board, color)
    @name = name
    @board = board
    @color = color
  end

  def play_turn
    move = random_move
    move_from = move[0]

    move_to = move[1]

    board.move(move_from, move_to)
  rescue IllegalMoveError
    retry
  end

  def random_move
    board.pieces_colored(color).shuffle.each do |piece|
      poss_move = piece.moves
      start_pos = piece.position
      unless poss_move.empty?
        end_pos = poss_move.sample
        return [start_pos, end_pos]
      end
    end
  end

  def render_display
    
  end
end
