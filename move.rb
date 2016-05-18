class Move
  attr_reader :start_pos, :end_pos
  def initialize(start_pos, end_pos)
    @start_pos, @end_pos = start_pos, end_pos
  end

  def display
    p start_pos
    p end_pos
  end
end
