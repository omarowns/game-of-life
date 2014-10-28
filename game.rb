class World
  attr_accessor :cols, :rows, :cells, :board

  def initialize(cols=3, rows=3)
    @cols = cols
    @rows = rows
    @cells = []

    @board = Array.new(rows){ |row| Array.new(cols) { |col| Cell.new(col, row) } }
    @board.each do |row|
      row.each do |col|
        @cells << col if col.is_a? Cell
      end
    end
  end

  def live_cells
    live_cells = []
    @cells.each { |cell| live_cells << cell if cell.alive? }
    live_cells
  end

  def dead_cells
    dead_cells = []
    @cells.each { |cell| dead_cells << cell if cell.dead? }
    dead_cells
  end

  def live_cells_around_cell(cell)
    live_cells = []
    # Up Left
    live_cells << @board[cell.y - 1][cell.x - 1] if @board[cell.y - 1][cell.x - 1].alive? and cell.y > 0 and cell.x > 0
    # Up
    live_cells << @board[cell.y - 1][cell.x] if @board[cell.y - 1][cell.x].alive? and cell.y > 0
    # Up Right
    live_cells << @board[cell.y - 1][cell.x + 1] if @board[cell.y - 1][cell.x + 1].alive? and cell.y > 0 and cell.x < (cols - 1)
    # Left
    live_cells << @board[cell.y][cell.x - 1] if @board[cell.y][cell.x - 1].alive? and cell.x > 0
    # Right
    live_cells << @board[cell.y][cell.x + 1] if @board[cell.y][cell.x + 1].alive? and cell.x < (cols - 1)
    # Down Left
    live_cells << @board[cell.y + 1][cell.x - 1] if @board[cell.y + 1][cell.x - 1].alive? and cell.y < (rows - 1) and cell.x > 0
    # Down
    live_cells << @board[cell.y + 1][cell.x] if @board[cell.y + 1][cell.x].alive? and cell.y < (rows - 1)
    # Down Right
    live_cells << @board[cell.y + 1][cell.x + 1] if @board[cell.y + 1][cell.x + 1].alive? and cell.y < (rows - 1) and cell.x < (rows - 1)


    live_cells
  end

  def populate!
  end
end

class Cell
  attr_accessor :x, :y, :alive

  def initialize(x=0, y=0, alive=false)
    @x = x
    @y = y
    @alive = alive
  end

  def alive?
    alive
  end

  def dead?
    !alive
  end

  def kill!
    @alive = false
  end

  def revive!
    @alive = true
  end
end