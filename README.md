Game of Life
============

Requirements
------------
`ruby 2.1.3`
`rspec 3.1.7`

How to play
----------
The file `game.rb` has all the logic for the **Game**, **World** and **Cell**.
Instantiate a `Game` object
`g = Game.new`
This will create a default `World` with a 3x3 grid and randomly populate the world.

You can create a different world with
`w = World.new(5,5)`
Where `5` and `5` are the columns and rows of the grid.

You can also send a seed to the game
`g = Game.new(World.new(5,5), [[1,0],[2,1],[1,1]])`
The seed is an `Array` on which each element is itself another `Array` that specifies the **position Y** and **position X** of a cell that's going to be marked as **alive**.

After your instance of `Game` is created, specify the total number of generations you want to run it through.
`g.total_generations = 5`
Where `5` is the total number of generations it's going to run.

To run, just call
`g.run!`
Not fun, huh?
Send `true` to the method and it will print each generation
`g.run! true`