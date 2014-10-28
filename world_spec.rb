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
    end    
  end
end