Game of Life
============

Requirements
------------
`ruby 2.1.3` <br>
`rspec 3.1.7`

How to play
----------
The file `game.rb` has all the logic for the **Game**, **World** and **Cell**.
Instantiate a `Game` object <br>
`g = Game.new` <br>
This will create a default `World` with a 3x3 grid and randomly populate the world.

You can create a different world with <br>
`w = World.new(5,5)` <br>
Where `5` and `5` are the columns and rows of the grid.

You can also send a seed to the game <br>
`g = Game.new(World.new(5,5), [[1,0],[2,1],[1,1]])` <br>
The seed is an `Array` on which each element is itself another `Array` that specifies the **position Y** and **position X** of a cell that's going to be marked as **alive**.

After your instance of `Game` is created, specify the total number of generations you want to run it through. <br>
`g.total_generations = 5` <br>
Where `5` is the total number of generations it's going to run.

To run, just call <br>
`g.run!` <br>
Not fun, huh? <br>
Send `true` to the method and it will print each generation <br>
`g.run! true`

How to run the specs
--------------------
First make sure you got `rpsec` or get it via <br>
`gem install rspec` <br>
Each `Cell`, `World` and `Game` has its own `spec` file. <br>
To run the tests for `Cell` <br>
`rspec cell_spec.rb` <br>
To run the tests for `World` <br>
`rspec world_spec.rb` <br>
To run the tests for `Game` <br>
`rspec game_spec.rb` <br>
To run all tests at once <br>
`rspec *spec*`