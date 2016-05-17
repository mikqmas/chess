require_relative 'board'
require_relative 'human_player'
require_relative 'computer_player'

class Game
  attr_reader :board, :current_player, :previous_player

  def initialize
    @board = Board.new
    @current_player = HumanPlayer.new("Wil", board, :white)
    @previous_player = ComputerPlayer.new("Sam", board, :black)
  end

  def play
    until over?
      current_player.play_turn
      switch_players!
    end

    current_player.render_display
    previous_player.render_display

    puts "Checkmate!"
    puts "#{previous_player.name} won!"
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
