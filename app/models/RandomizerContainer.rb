# Course: CIS*3260: Software Design IV | A1: Ruby
# Name: Mitchell Van Braeckel
# Student Number: 1002297
# Email: mvanbrae@uoguelph.ca
# Due Date: September 27, 2021
# Professor: Mark Wineberg
# Language: Ruby

# require "./Randomizer.rb"

# An "abstract class" used for polymorphism and to store common methods
# Note: All RandomizerContainer objects are created empty. Therefore they are just called with 'new' (e.g. `Cup.new`)
class RandomizerContainer
    # Default constructor for a RandomizerContainer object
    def initialize
        @randomizers = []
    end

    # Stores a randomizer in the container
    def store(r)
        raise ArgumentError, "Randomizer '#{r}' is invalid - must be a Randomizer instance." unless r.is_a?(Randomizer)
        @randomizers << r
    end

    # Get each randomizer in the given contained & store it in self (without emptying the container's randomizers)
    def copy_all(rc)
        raise ArgumentError, "RandomizerContainer '#{rc}' is invalid - must be a RandomizerContainer instance." unless rc.is_a?(RandomizerContainer)
        rc.randomizers.each do |r|
            @randomizers << r.clone
        end
    end

    # Get each randomizer in the given container & store it in self (removing it from the given container's randomizers)
    def move_all(rc)
        self.copy_all(rc)
        rc.empty
    end

    # Removes all members of the container
    def empty
        @randomizers = []
        nil
    end

    # Returns a copy of the randomizers in the container (so it isn't connected by reference, thus not breaking encapsulation)
    def randomizers
        @randomizers.clone
    end

    # Returns if the given RandomizerContainer is equal to self
    def ==(o)
        o.is_a?(RandomizerContainer) && self.randomizers.sort == o.randomizers.sort
    end

    # # Returns a RandomizerContainer clone with copies of all its randomizers
    # def clone
    #     RandomizerContainer.new.copy_all(self)
    # end

    # # Returns a string representation of the RandomizerContainer
    # def to_s
    #     to_print = "Randomizer Container=#{self.class}\n"
    #     @randomizers.each do |r|
    #         to_print += "#{r.to_s.strip}\n"
    #     end
    #     to_print.strip
    # end

    # Returns a string to print that shows physical attribute info of all items
    def print_items
        to_print = ""
        @randomizers.each do |r|
            to_print += "#{r.print_item}\n"
        end
        to_print.strip
    end

    # Returns a description hash of all items
    def items_description
        to_print = "["
        @randomizers.each do |r|
            to_print += "#{r.item_description},"
        end
        to_print = to_print.chomp(',') + "]"
    end
end