require 'rspec'
require_relative 'game.rb'

describe Cell do
  subject(:cell) { Cell.new }

  it { should respond_to(:x) }
  it { should respond_to(:y) }
  it { should respond_to(:alive) }

  describe '#initialize' do

    context 'when arguments are sent' do
      let!(:test_cell){ Cell.new(1, 1, true) }

      it 'sets the position x' do
        expect(test_cell.x).to eq 1
      end
      it 'sets the position y' do
        expect(test_cell.y).to eq 1
      end
      it 'sets the state of the cell' do
        expect(test_cell.alive).to eq true
      end
    end
    context 'when no arguments are sent' do
      let!(:test_cell){ Cell.new }

      it 'sets the position x to 0' do
        expect(test_cell.x).to eq 0
      end
      it 'sets the position y to 0' do
        expect(test_cell.y).to eq 0
      end
      it 'sets the state of the cell to false' do
        expect(test_cell.alive).to eq false
      end
    end
  end

  describe 'what to do with a cell' do
    let(:cell) { Cell.new(1,1,true) }

    describe 'ask for state' do
      context 'when cell is alive' do
        describe '#alive?' do
          it 'returns true' do
            expect(cell.alive?).to eq true
          end
        end
        describe '#dead?' do
          it 'returns false' do
            expect(cell.dead?).to eq false
          end
        end
      end
      context 'when cell is dead' do
        before { cell.alive = false }
        describe '#alive?' do
          it 'returns false' do
            expect(cell.alive?).to eq false
          end
        end
        describe '#dead?' do
          it 'returns true' do
            expect(cell.dead?).to eq true
          end
        end
      end
    end

    describe 'can I kill it?' do
      it 'is possible' do
        expect(cell.kill!).to eq false
      end
    end

    describe 'can I revive it?' do
      it 'is possible' do
        expect(cell.revive!).to eq true
      end
    end
  end
end