# Course: CIS*3260: Software Design IV | A1: Ruby
# Name: Mitchell Van Braeckel
# Student Number: 1002297
# Email: mvanbrae@uoguelph.ca
# Due Date: September 27, 2021
# Professor: Mark Wineberg
# Language: Ruby

# An "abstract class" used for polymorphism and to store common methods
# NOTE: enum used for Randomizer items = :coin, :die
class Randomizer
    # Accessor method that returns the item the randomizer represents (does NOT set it)
    # Accessor method that returns the number of randomizations performed (does NOT set it)
    attr_reader :item, :randomize_count

    # Default constructor for a Randomizer object
    def initialize
        @item = nil
        @result = nil
        @randomize_count = 0
    end

    # Both randomizes and returns the randomizer itself (for method chaining)
    def randomize
        raise NotImplementedError
    end

    # Returns the result of the randomization, or nil if never randomized
    def result
        @randomize_count == 0 ? nil : @result
    end

    # Returns the numerical value of the randomization result
    def result_value
        self.result
    end

    # Sets the result to nil and number of randomizations performed to 0
    def reset
        @result = nil
        @randomize_count = 0
    end

    # Returns the up of the randomization (synonym of result() for matching valid 'description' formats)
    def up
        self.result
    end

    # # Returns if the given Randomizer is equal to self
    # def ==(o)
    #     o.is_a?(Randomizer) && self.item == o.item && self.result == o.result && self.randomize_count == o.randomize_count
    # end

    # # Returns a string representation of the Randomizer
    # def to_s
    #     "Item=#{@item}, Randomize Count=#{@randomize_count}, Result=#{@result}"
    # end

    # Returns a string to print to show physical attribute info of an item
    def print_item
        "Item=#{@item}"
    end

    # Returns a description hash of an item
    def item_description
        "{item:#{@item}}"
    end
end
