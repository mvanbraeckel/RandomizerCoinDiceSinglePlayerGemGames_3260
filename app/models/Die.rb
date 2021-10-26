# Course: CIS*3260: Software Design IV | A1: Ruby
# Name: Mitchell Van Braeckel
# Student Number: 1002297
# Email: mvanbrae@uoguelph.ca
# Due Date: September 27, 2021
# Professor: Mark Wineberg
# Language: Ruby

# require "./Randomizer.rb"

# Die <inherits from Randomizer>
# NOTE: enum used for die colours = :red, :green, :blue, :yellow, :black, :white
# Description example: {item: :die, sides: 4, colour: :yellow, up: 4}
# Note 1: Int and Enum are only indications of the arg types expected by the method.
# -> They will not be present in your code as Ruby is Duck typed.
# -> UML type notation has been used, with the type following the arg name, separated by a colon
# Note 2: Enum is not actually a class; it is a duck-type-style interface, i.e. a protocol.
# -> E.g. colour is consistently represented by symbols such as `:red` and `:blue`;
# -> There is no class holding or enforcing these values (although they can be error checked against by the methods that accept them, if you wish).
# -> All enumeration protocols are listed in the "Enumerations" section later in the assignment
class Die < Randomizer
    # Constant array of valid Die colours
    COLOURS = [:red, :green, :blue, :yellow, :black, :white]

    # Accessor method that returns the number of sides of the Die (does NOT set it)
    # Accessor method that returns the colour of the Die (does NOT set it)
    attr_reader :sides, :colour

    # Default constructor for a Die object (i.e. `Die.new(sides, colour)`)
    def initialize(sides, colour)
        @item = :die
        @result = nil
        @randomize_count = 0
        raise ArgumentError, "Sides '#{sides}' is invalid - must be an integer of 1 or greater." unless sides.is_a?(Integer) && sides > 0
        @sides = sides
        raise ArgumentError, "Colour '#{colour}' is invalid - must be one of: #{COLOURS}." unless COLOURS.include?(colour)
        @colour = colour
    end

    # Overridden method that both randomizes and returns the Die itself (for method chaining)
    def randomize
        self.roll
    end

    # Rolls the Die and returns the "rolled" die (for method chaining) (synonym of Die randomize())
    def roll
        @randomize_count += 1
        @result = 1 + rand(@sides)
        self
    end

    # Returns 1..sides (inclusive) (the result of the last roll) or nil (if no rolls yet done) (synonym of result())
    def sideup
        self.result
    end

    # Returns the up of the Coin randomization (synonym of sideup() for matching valid 'description' formats)
    def up
        self.sideup
    end

    # # Returns if the given Die is equal to self
    # def ==(o)
    #     o.is_a?(Die) && super && self.sides == o.sides && self.colour == o.colour
    # end

    # # Overriden method that returns a string representation of the Die
    # def to_s
    #     "#{super}, Sides=#{@sides}, Colour=#{@colour}"
    # end

    # Returns a string to print to show physical attribute info of the Die
    def print_item
        "#{super}, Sides=#{@sides}, Colour=#{@colour}"
    end

    # Returns a description hash of the Die
    def item_description
        "{item:#{@item}, sides:#{@sides}, colour:#{@colour}}"
    end
end
