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