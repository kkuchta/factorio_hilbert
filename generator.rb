require "./hilbert"
require "./blueprint"

# Generates a full hilbert curve of the given iteration
class Generator
  include Blueprint

  def initialize(iteration = 1)
    @iteration = iteration
    @size = 2**@iteration
    @distance = @size**2 - 1
  end

  # Generates the given iteration and stores it in @field
  def generate
    last_x = 0
    last_y = 0
    @field = []
    set = ->(x, y, value) { (@field[y] ||= [])[x] = value }
    0.upto(@distance) do |i|
      (x, y) = Hilbert.d2xy(@size, i)
      if last_x < x
        set[last_x, last_y, ">"]
      elsif last_x > x
        set[last_x, last_y, "<"]
      elsif last_y < y
        set[last_x, last_y, "v"]
      else
        set[last_x, last_y, "^"]
      end
      last_x = x
      last_y = y
    end

    # There's probably an elegant way to set the last direction, but I think
    set[last_x, last_y, @iteration.odd? ? "^" : ">"]
  end

  # Map our internal direction representation (ascii arrows) to factorio belt
  # directions
  def direction(arrow)
    case arrow
    when "^"
      0
    when ">"
      2
    when "v"
      4
    when "<"
      6
    end
  end

  # Print out the generated iteration to the command line in an ascii format.
  # Handy for debugging low iterations.
  def to_s
    result = ""
    0.upto(@field.length - 1) do |y|
      0.upto(@field[y].length - 1).map do |x|
        result << @field[y][x] + " "
      end
      result << "\n"
    end
    result
  end

  # Create a blueprint hash (not a blueprint string). Actually just produces a
  # list of entity hashes for this blueprint.
  def to_blueprint
    entities = []
    i = 0
    0.upto(@field.length - 1) do |y|
      0.upto(@field[y].length - 1).map do |x|
        i += 1
        entities << {
          "entity_number" => i,
          "name" => "express-transport-belt",
          "direction" => direction(@field[y][x]),
          "position" => {"x" => x, "y" => y}
        }
      end
    end

    full_blueprint(entities, "Hilbert Iteration #{@iteration}", @iteration)
  end

  # Convert a blueprint hash to a blueprint string
  def to_blueprint_string
    hash_to_blueprint(to_blueprint)
  end

  # The "rest" of a blueprint beyond just the entities.
  def full_blueprint(entities, name, i)
    {"blueprint" =>
      {"icons" =>
        [
          {"signal" => {"type" => "item", "name" => "express-transport-belt"}, "index" => 1},
          {"signal" => {"type" => "virtual", "name" => "signal-#{i}"}, "index" => 2}
        ],
       "entities" => entities,
       "item" => "blueprint",
       "label" => name,
       "version" => 64424902656}}
  end

  # Create a blueprint book of all iterations up to the given one.
  def self.book(max_iter)
    blueprints = (0...max_iter).map { |i|
      g = Generator.new(i + 1)
      g.generate
      g.to_blueprint.merge("index" => i)
    }
    Blueprint.hash_to_blueprint({
      "blueprint_book" => {
        "item" => "blueprint-book",
        "active_index" => 0,
        "label" => "Hilbert Curves by Fishtoaster",
        "version" => 281474976710656,
        "blueprints" => blueprints
      }
    })
  end
end

# Generate a single iteration as a blueprint string
# generator = Generator.new(1)
# generator.generate
# puts generator.to_blueprint_string

# Generate a blueprint book containing the first N iterations of the hilbert
# curve. Warning here: iterations 8 and 9 slow down my nice laptop a lot when
# trying to load them in-game, and even pasting the blueprint string takes a
# few seconds.
puts Generator.book(7)
