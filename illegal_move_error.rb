class IllegalMoveError < RuntimeError
  def initialize(message = "that piece cant move there")
    super
  end
end

class MoveIntoCheckError < IllegalMoveError
  def initialize(message = "you moved into check")
    super
  end
end

class PieceSelectionError < IllegalMoveError
  def initialize(message = "thats not your piece")
    super
  end
end
