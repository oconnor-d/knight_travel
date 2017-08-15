class Board
  def initialize
    @size = 8
  end

  def knight_moves(origin, destination)
    origin_square = Square.new(origin[0], origin[1])
    wl = [origin_square]
    bl = [origin]

    count = 0
    while !wl.empty? do
      square = wl.shift
      count += 1

      unless square.has_position?(destination)
        add_if_valid(Square.new(square.row+2, square.col+1, square), wl, bl)
        add_if_valid(Square.new(square.row+2, square.col-1, square), wl, bl)
        add_if_valid(Square.new(square.row-2, square.col+1, square), wl, bl)
        add_if_valid(Square.new(square.row-2, square.col-1, square), wl, bl)
        add_if_valid(Square.new(square.row+1, square.col+2, square), wl, bl)
        add_if_valid(Square.new(square.row-1, square.col+2, square), wl, bl)
        add_if_valid(Square.new(square.row+1, square.col-2, square), wl, bl)
        add_if_valid(Square.new(square.row-1, square.col-2, square), wl, bl)
      else
        wl.clear

        path = square.retrace_to(origin_square).reverse

        print "#{origin}->#{destination} : "
        puts "You made it in #{path.length-1} moves! Here's your path:"
        puts path
      end
    end
  end

  private

  def add_if_valid(square, list_to_add, black_list)
    out_of_bounds = square.row >= @size || square.col >= @size
    already_seen = black_list.include?([square.row,square.col])

    unless out_of_bounds || already_seen
      list_to_add << square
      black_list << [square.row, square.col]
    end
  end
end

class Square
  attr_reader :row, :col, :previous_square

  def initialize(row, col, previous_square=nil)
    @row = row
    @col = col
    @previous_square = previous_square
  end

  def retrace_to(square, path=[])
    if square.row == @row && square.col == @col
      return path << to_s
    else
      #print "#{[@previous_square.row,@previous_square.col]}"
      @previous_square.retrace_to(square, path << to_s)
    end
  end

  def has_position?(position)
    @row == position[0] && @col == position[1]
  end

  def to_s
    "[#{@row},#{col}]"
  end
end

board = Board.new
board.knight_moves([3,3],[0,0])
board.knight_moves([3,3],[4,3])
board.knight_moves([3,3],[3,3])
