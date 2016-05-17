require_relative 'display'

class HumanPlayer
  attr_reader :name, :display, :board, :color

  def initialize(name, board, color)
    @name = name
    @board = board
    @color = color
    @display = Display.new(board)
  end

  def play_turn
    move_from = move
    raise ArgumentError if board[move_from].color != self.color
    display.selected_pos = move_from

    move_to = move
    display.selected_pos = nil

    board.move(move_from, move_to)
  rescue ArgumentError
    retry
  end

  def move
    result = nil
    until result
      @display.render
      result = @display.get_input
    end
    result
  end
end
