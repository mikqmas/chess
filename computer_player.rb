
require_relative 'illegal_move_error'
require_relative 'move'

class ComputerPlayer
  attr_reader :name, :board, :color, :give_up

  def initialize(name, board, color)
    @name = name
    @board = board
    @color = color
    @display = Display.new(board)
    @give_up = false
  end

  def play_turn
    @display.render
    moves_hash = move_scores(0)
    max_val = moves_hash.max_by{|k,v| v}[1]
    best_move = moves_hash.select {|k, v| v == max_val}.keys.sample
    board.move(best_move.start_pos, best_move.end_pos)
  rescue
    @give_up = true
  end

  def render_display

  end

  def opponent_color
    color == :black ? :white : :black
  end

  def move_scores(depth)
    curr_color = depth.odd? ? opponent_color : color
    return build_move_hash(curr_color) if depth >= 2
    move_hash = Hash.new
    board.pieces_colored(curr_color).each do |piece|
      piece.moves.each do |move|
        move_obj = Move.new(piece.position, move)
        board.move!(move_obj.start_pos, move_obj.end_pos)

        best_move_score = nil
        if depth.even?
          best_move_score = move_scores(depth + 1).min_by{|k,v| v}
        else
          best_move_score = move_scores(depth + 1).max_by{|k,v| v}
        end

        best_move = best_move_score[0]
        board.move!(best_move.start_pos, best_move.end_pos)
        move_hash[move_obj] = scoreboard
        board.undo_move(best_move.start_pos, best_move.end_pos)

        board.undo_move(move_obj.start_pos, move_obj.end_pos)
      end
    end
    move_hash
  end

  def build_move_hash(curr_color)
    move_hash = Hash.new
    board.pieces_colored(curr_color).each do |piece|
      piece.moves.each do |move|
        move_obj = Move.new(piece.position, move)
        board.move!(move_obj.start_pos, move_obj.end_pos)
        move_hash[move_obj] = scoreboard
        board.undo_move(move_obj.start_pos, move_obj.end_pos)
      end
    end
    move_hash
  end

  def scoreboard
    our_score = board.pieces_colored(color).inject(0) do |score, piece|
      piece.num_points + score
    end

    opponent_score = board.pieces_colored(opponent_color).inject(0) do |score, piece|
      piece.num_points + score
    end

    our_score.fdiv(opponent_score)
  end
end
