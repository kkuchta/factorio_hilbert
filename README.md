# Generating Hilbert Curves in Factorio

![](hilbert4x.gif)

[Hilbert Curves](https://en.wikipedia.org/wiki/Hilbert_curve) are these neat-looking, space-filling lines in math.

[Factorio](https://factorio.com/) is a pretty great video game where you build factories. You can use "blueprints" in the game, which are pre-made sets of buildings and entities. You can import blueprints into the game via a "blueprint string" which is actually just a bunch of json in a trenchoat.

This repo is a few scripts I put together to generate a factorio blueprint string for a hilbert curve made out of conveyor belts because I thought it'd look cool.

Also present is a lua script that I put together so I could record the curve in action. I made a 40 minute video of items travelling the entire length of the seventh iteration curve (the above gif is significantly sped up).

If you want to mess with the curves yourself in factorio, here's a [blueprint book](https://raw.githubusercontent.com/kkuchta/factorio_hilbert/main/7book?token=AAGINZNTBBWEW77CMVLNSN27TY63Q) you can import with the first 7 iterations. There's also one with the [first 9 iterations](https://raw.githubusercontent.com/kkuchta/factorio_hilbert/main/9book?token=AAGINZNCUULBBHVZYG4X5JS7TY66Y), but it's rather unwieldy, so I wouldn't recommend it.

# Usage

1. Install a recent version of ruby
2. Run `bundle install`
3. run `ruby generate.rb`

That should print out a blueprint book string. You can modify the code at the bottom of generator.rb to get higher/bigger iterations.

## Lua usage

The lua script was meant to be copy-pasted after `/c` in the factorio command prompt. There are no comments because those don't work when copy-pasted like that. It's a set of programmed camera motions keyed to trigger when a transport belt in a certain position has more than one item on it.

It's the result of a lot of tweaking, experimentation, and generaly hackery. The specific code probably isn't useful to anyone but me on my specific test map, but the techniques I used for smooth interpolation between coordinates and zooms might be. Let me know if you're curious and I'll write it up.
