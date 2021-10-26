# Course: CIS*3260: Software Design IV | A1: Ruby
# Name: Mitchell Van Braeckel
# Student Number: 1002297
# Email: mvanbrae@uoguelph.ca
# Due Date: September 27, 2021
# Professor: Mark Wineberg
# Language: Ruby

# require "./Bag.rb"
# require "./Cup.rb"
# require "./Randomizer.rb"

# High Level Class: Player
# Description example: {item: :coin, denomination: 0.25, up: :H}
# Description example: {item: :die, sides: 4, colour: :yellow, up: 4}
class Player
    # Accessor method that returns the name of the Player (does NOT set it)
    attr_reader :name

    # Default constructor for a Player object (i.e. Player.new("Gandalf the Grey"))
    def initialize(name)
        raise ArgumentError, "Name '#{name}' is invalid - must be a String." unless name.is_a?(String)
        @name = name
        @bag = Bag.new
        @cup = Cup.new
        @throws = []
    end

    # Stores the item in the Player's Bag
    def store(item)
        raise ArgumentError, "Item '#{item}' is invalid - must be a Randomizer instance." unless item.is_a?(Randomizer)
        @bag.store(item)
    end

    # Gets each item in the given container and stores it in the Player's Bag
    def move_all(rc)
        @bag.move_all(rc)
    end

    # Loads items from the Player's Bag to the Player's Cup based on the description
    def load(description = { })
        raise ArgumentError, "Description '#{description}' is invalid - must be a Hash." unless description.is_a?(Hash)
        @cup.load(@bag.select(description, :all))
    end

    # Throws the (previously loaded) Cup, and replaces the items in the Cup to the Bag
    # NOTE: the Throw is both returned and stored internally
    # NOTE: also returns the throw externally for easy use
    def throw
        thrown_cup = @cup.throw
        @throws.unshift(thrown_cup)
        self.move_all(@cup.empty)
        thrown_cup
    end

    # Clears all stored Throws
    def clear
        @throws = []
    end

    # Sets the description, and calls tally() on each stored Throw and returns each of the tally values within a single array
    def tally(description = { })
        raise ArgumentError, "Description '#{description}' is invalid - must be a Hash." unless description.is_a?(Hash)
        throws_tallies = []
        @throws.each do |t|
            t.description(description)
            throws_tallies << t.tally
        end
        throws_tallies
    end

    # Sets the description, and calls sum() on each stored Throw and returns the combined sum total values within a single array
    def sum(description = { })
        raise ArgumentError, "Description '#{description}' is invalid - must be a Hash." unless description.is_a?(Hash)
        throws_sums = []
        @throws.each do |t|
            t.description(description)
            throws_sums << t.sum
        end
        throws_sums
    end

    # Sets the description and returns the values as an array from given Throw, where the last Throw is "throw=0", the Throw before is "throw=1", etc.
    # NOTE: If a throw is requested that doesn't exist (too far back in time and never occurred), return nil
    def results(description = { }, throw = 0)
        raise ArgumentError, "Description '#{description}' is invalid - must be a Hash." unless description.is_a?(Hash)
        raise ArgumentError, "Throw ID '#{throw}' is invalid - must be an integer of 0 or greater." unless throw.is_a?(Integer) && throw >= 0
        if throw >= @throws.length
            nil
        else
            @throws[throw].description(description)
            @throws[throw].results
        end
    end

    # Returns a Bag clone of the Player's Bag (so it isn't connected by reference, thus not breaking encapsulation)
    def bag
        @bag.clone
    end

    # # Returns a Cup clone of the Player's Cup (so it isn't connected by reference, thus not breaking encapsulation)
    # def cup
    #     @cup.clone
    # end

    # # Returns a copy of the Player's throws (so it isn't connected by reference, thus not breaking encapsulation)
    # def throws
    #     @throws.clone
    # end

    # # Returns if the given Player is equal to self
    # def ==(o)
    #     o.is_a?(Player) && self.name == o.name && self.bag == o.bag && self.cup == o.cup && self.throws.sort == o.throws.sort
    # end

    # # Returns a string representation of the Player
    # def to_s
    #     to_print = "Player Throws:\n"
    #     @throws.each do |t|
    #         to_print += "#{t.to_s.strip}\n"
    #     end
    #     "Name=#{@name}\nBag:\n#{@bag.to_s.strip}\nCup:\n#{@cup.to_s.strip}\nThrows:\n#{to_print.strip}\nResults=#{self.results}\nTally=#{self.tally}\nSum=#{self.sum}"
    # end
end
