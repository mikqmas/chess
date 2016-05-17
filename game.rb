require_relative 'board'
require_relative 'human_player'

class Game
  attr_reader :board, :current_player, :previous_player

  def initialize
    @board = Board.new
    @current_player = HumanPlayer.new("Wil", board, :white)
    @previous_player = HumanPlayer.new("Sam", board, :black)
  end

  def play
    until over?
      current_player.play_turn
      switch_players!
    end
    puts "game over"
  end

  def switch_players!
    @current_player, @previous_player = previous_player, current_player
  end

  def over?
    board.checkmate?(:black) || board.checkmate?(:white)
  end
end

if $PROGRAM_NAME == __FILE__
  Game.new.play
end
