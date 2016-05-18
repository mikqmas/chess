require 'colorize'
require_relative 'cursorable'
require_relative 'board'

class Display
  attr_reader :board
  attr_accessor :selected_pos, :message

  include Cursorable

  def initialize(board)
    @board = board
    @cursor_pos = nil
    @selected_pos = nil
    @message = ""
  end

  def build_grid
    @board.grid.map.with_index do |row, i|
      build_row(row, i)
    end
  end

  def build_row(row, i)
    row.map.with_index do |piece, j|
      bg_color = colors_for(i, j)
      piece.to_s.colorize({ background: bg_color, color: piece.color })
    end
  end

  def colors_for(i, j)
    if [i, j] == @selected_pos
      bg = :light_red
    elsif [i, j] == @cursor_pos
      bg = :light_green
    elsif (i + j).odd?
      bg = :blue
    else
      bg = :light_blue
    end
    bg
  end

  def render
    system("clear")
    build_grid.each { |row| puts row.join }
    puts message
  end
end
