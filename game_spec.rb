require 'rspec'
require_relative 'game.rb'

describe Game do
  
  subject(:game) { Game.new }

  it { should respond_to(:world) }
  it { should respond_to(:generation) }
  it { should respond_to(:total_generations) }

  describe 'initialization' do
    let(:world){ World.new }
    let(:custom_world){ World.new(5,5) }
    let(:seed){ [[1,0],[1,1],[2,2]] }

    context 'when a custom world is sent' do
      it 'assigns it correctly' do
        game = Game.new(custom_world)
        expect(game.world).to eq custom_world
      end
    end

    context 'when sending a seed' do
      it 'seeds the world' do
        game = Game.new(world, seed)
        seed.each do |row|
          expect(game.world.board[row[0]][row[1]].alive).to eq true
        end
      end
    end

    describe 'verifying counting' do
      it 'should still count live cells correctly' do
        game = Game.new(world, seed)
        expect(game.world.live_cells.count).to eq 3
      end
      it 'should still count dead cells correctly' do
        game = Game.new(world, seed)
        expect(game.world.dead_cells.count).to eq 6
      end
    end
  end

  describe 'given a world' do
    let(:world) { World.new }
    describe 'and a seed' do
      let(:seed) { [[0,1],[1,0],[1,1],[2,2]] }
      describe 'and a game with the previous' do
        let(:game) { Game.new(world, seed) }
        describe 'after a generation' do
          it 'should have six live cells' do
            game.continue!
            expect(game.world.live_cells.count).to eq 6
          end
        end
      end
    end
  end

  context 'with a valid scenario' do
    let(:world) { World.new(5,5) }
    let(:seed) { [[0,1],[1,0],[1,1],[2,2]] }
    let(:game) { Game.new(world, seed) }

    describe 'can assign generations'
  end

end