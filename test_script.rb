require_relative 'board'
require_relative 'computer_player'


b = Board.new
cp = ComputerPlayer.new("name", b, :white)
cp.move_scores(0)
