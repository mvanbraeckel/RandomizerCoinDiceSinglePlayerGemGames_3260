# Course: CIS*3260: Software Design IV | A1: Ruby
# Name: Mitchell Van Braeckel
# Student Number: 1002297
# Email: mvanbrae@uoguelph.ca
# Due Date: September 27, 2021
# Professor: Mark Wineberg
# Language: Ruby

# require "./Hand.rb"
# require "./Randomizer.rb"
# require "./RandomizerContainer.rb"

# Cup <Inherits from RandomizerContainer>
# Note: All RandomizerContainer objects are created empty. Therefore they are just called with 'new' (e.g. `Cup.new`)
class Cup < RandomizerContainer
    # Each randomizer in the Cup is rolled or flipped; virtual copies of all randomizers are stored in a newly created Throw object, which is returned
    def throw
        @randomizers.each do |r|
            r.randomize unless r.instance_of?(Randomizer)
        end
        c = Cup.new
        c.copy_all(self)
        Throw.new(c)
    end

    # Enters each randomizer from a Hand (synonym of move_all())
    def load(hand)
        raise ArgumentError, "Hand '#{hand}' is invalid - must be a Hand instance." unless hand.is_a?(Hand)
        # Below is equivalent to `self.move_all(hand)` but uses the hand.next function instead
        next_r = hand.next
        until next_r == nil do
            self.store(next_r)
            next_r = hand.next
        end
        hand.empty
    end

    # Overridden method that returns a Hand object to be returned to the bag, and leaves the cup empty
    def empty
        h = Hand.new
        h.copy_all(self)
        super
        h
    end

    # # Returns if the given Cup is equal to self
    # def ==(o)
    #     o.is_a?(Cup) && super
    # end

    # # Returns a Cup clone with copies of all its randomizers
    # def clone
    #     Cup.new.copy_all(self)
    # end
end
