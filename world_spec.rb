require 'rspec'
require_relative 'game.rb'

describe World do

  subject(:world) { World.new }

  it { should respond_to(:cols) }
  it { should respond_to(:rows) }
  it { should respond_to(:cells) }
  it { should respond_to(:board) }

  context 'when initializing' do
    context 'when no parameters sent' do
      it 'defaults the cols to 3' do
        expect(world.cols).to eq 3
      end
      it 'defaults the rows to 3' do
        expect(world.rows).to eq 3
      end
      
      describe 'board' do
        it 'rows is an array' do
          expect(world.board.class).to eq Array
        end
        it 'cols is an array' do
          world.board.each do |row|
            expect(row.class).to eq Array
          end
        end
        it 'has cells' do
          world.board.each do |row|
            row.each do |col|
              expect(col.class).to eq Cell
            end
          end
        end
      end

      describe 'cells' do
        it 'is an array' do
          expect(world.cells.class).to eq Array
        end
        it 'is has contents' do
          expect(world.cells.length).to be > 0
        end
        describe 'each element of cells' do
          it 'is a Cell' do
            world.cells.each do |cell|
              expect(cell.class).to eq Cell
            end
          end
          it 'is dead' do
            world.cells.each do |cell|
              expect(cell.alive).to eq false
            end
          end
        end
      end
    end
  end

  describe 'counting' do
    describe 'live cells' do
      context 'when default' do
        it 'returns zero' do
          expect(world.live_cells.count).to eq 0
        end
      end
      context 'when a cell is alive' do
        before { world.board[1][1].alive = true }
        it 'returns one' do
          expect(world.live_cells.count).to eq 1
        end
      end
    end
    describe 'dead cells' do
      context 'when default' do
        it 'returns nine' do
          expect(world.dead_cells.count).to eq 9
        end
      end
      context 'when a cell is alive' do
        before { world.board[1][1].alive = true }
        it 'returns one' do
          expect(world.dead_cells.count).to eq 8
        end
      end
    end
  end

  describe 'looking for other cells' do
    context 'when in the up left part of the default board' do
      let(:cell_one) { world.board[0][0] }

      it 'detects a live cell right' do
        world.board[cell_one.y][cell_one.x + 1].alive = true
        expect(world.live_cells_around_cell(cell_one).count).to eq 1
      end
      it 'detects a live cell down' do
        world.board[cell_one.y + 1][cell_one.x].alive = true
        expect(world.live_cells_around_cell(cell_one).count).to eq 1
      end
      it 'detects a live cell down right' do
        world.board[cell_one.y + 1][cell_one.x + 1].alive = true
        expect(world.live_cells_around_cell(cell_one).count).to eq 1
      end

      it 'may not even detect a live cell' do
        expect(world.live_cells_around_cell(cell_one).count).to eq 0
      end
    end

    context 'when in the middle cell of the default board' do
      let(:cell) { world.board[1][1] }

      it 'detects a live cell up left' do
        world.board[cell.y - 1][cell.x - 1].alive = true
        expect(world.live_cells_around_cell(cell).count).to eq 1
      end
      it 'detects a live cell up' do
        world.board[cell.y - 1][cell.x].alive = true
        expect(world.live_cells_around_cell(cell).count).to eq 1
      end
      it 'detects a live cell up right' do
        world.board[cell.y - 1][cell.x + 1].alive = true
        expect(world.live_cells_around_cell(cell).count).to eq 1
      end
      it 'detects a live cell left' do
        world.board[cell.y][cell.x - 1].alive = true
        expect(world.live_cells_around_cell(cell).count).to eq 1
      end
      it 'detects a live cell right' do
        world.board[cell.y][cell.x + 1].alive = true
        expect(world.live_cells_around_cell(cell).count).to eq 1
      end
      it 'detects a live cell down left' do
        world.board[cell.y + 1][cell.x - 1].alive = true
        expect(world.live_cells_around_cell(cell).count).to eq 1
      end
      it 'detects a live cell down' do
        world.board[cell.y + 1][cell.x].alive = true
        expect(world.live_cells_around_cell(cell).count).to eq 1
      end
      it 'detects a live cell down right' do
        world.board[cell.y + 1][cell.x + 1].alive = true
        expect(world.live_cells_around_cell(cell).count).to eq 1
      end

      it 'may not even detect a live cell' do
        expect(world.live_cells_around_cell(cell).count).to eq 0
      end
    end    
  end

  describe 'populating the world' do
    before { world.populate! }
    describe 'randomly' do
      it 'does not returns an empty array with live cells' do
        expect(world.live_cells).to_not eq []
      end

      describe 'counting live and dead' do
        it 'should equal to the total cells' do
          expect(world.live_cells.count + world.dead_cells.count).to eq world.cells.count
        end
      end
    end
  end
end