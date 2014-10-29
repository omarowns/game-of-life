class Game
  attr_accessor :world, :generation, :total_generations

  # the seeds is a matrix that indicates which cells
  # are alive in the board  
  def initialize(world=World.new, seeds=[])
    @world = world
    @seeds = seeds
    @total_generations = 1
    @generation = 0

    if @seeds.length == 0
      @world.populate!
    end

    @seeds.each do |row|
      @world.board[row[0]][row[1]].alive = true
    end
  end

  def continue!
    cells_that_live = []
    cells_that_die  = []

    @world.cells.each do |cell|
      live_cells = @world.live_cells_around_cell(cell).count

      if cell.alive?
        # Any live cell with fewer than two live neighbours dies, as if caused by underpopulation.
        cells_that_die << cell if live_cells < 2

        # Any live cell with more than three live neighbours dies, as if by overcrowding.
        cells_that_die << cell if live_cells > 3

        # Any live cell with two or three live neighbours lives on to the next generation.
        cells_that_live << cell if live_cells == 2 or live_cells == 3
      else
        # Any dead cell with exactly three live neighbours becomes a live cell.
        cells_that_live << cell if live_cells == 3
      end
    end

    cells_that_live.each  { |cell| cell.revive! }
    cells_that_die.each   { |cell| cell.kill!   }
  end

  def print!
    p "*** Gen #{@generation} ***"
    @world.board.each do |row|
      row.each do |element|
        print element.alive? ? "1 " : "0 "
      end
      puts "\n"
    end
  end

  def run!(printable=false)
    @total_generations.times do |i|
      self.continue!
      @generation += 1
      self.print! if printable
    end
    @generation
  end
end

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
    (-1..1).each do |ry|
      (-1..1).each do |rx|
        begin
          y = cell.y + ry
          x = cell.x + rx
          if (ry==0 && rx==0) || (y < 0 || x < 0) || (y > @rows || x > @rows)
            next
          end
          live_cells << @board[y][x] if @board[y][x].alive?
        rescue
          next
        end        
      end
    end

    live_cells
  end

  def populate!
    @board.each do |row|
      row.each do |cell|
        cell.alive = [true, false].sample
      end
    end
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