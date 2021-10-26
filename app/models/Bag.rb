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

# Bag <Inherits from RandomizerContainer>
# NOTE: when store() or move_all() are invoked, Bag makes sure that all randomizers added to the Bag are reset
# Note: All RandomizerContainer objects are created empty. Therefore they are just called with 'new' (e.g. `Cup.new`)
# Description example: {item: :coin, denomination: 0.25, up: :H}
# Description example: {item: :die, sides: 4, colour: :yellow, up: 4}
class Bag < RandomizerContainer
    # Overridden method that resets and stores a randomizer in the Bag
    def store(r)
        raise ArgumentError, "Randomizer '#{r}' is invalid - must be a Randomizer instance." unless r.is_a?(Randomizer)
        r.reset
        super
    end

    # Overridden method that resets and gets each randomizer in the given container & stores it in self (removing it from the given container's randomizers)
    def move_all(rc)
        raise ArgumentError, "RandomizerContainer '#{rc}' is invalid - must be a RandomizerContainer instance." unless rc.is_a?(RandomizerContainer)
        rc.randomizers.each do |r|
            r.reset
        end
        super
    end

    # Selects items from the Bag based on the description and returns a Hand object that is holding the items up to the number entered into amount (if you want all items, supply the symbol :all instead of a number)
    def select(description, amt)
        raise ArgumentError, "Description '#{description}' is invalid - must be a Hash." unless description.is_a?(Hash)
        raise ArgumentError, "Amount '#{amt}' is invalid - must be an integer of 1 or greater." unless amt == :all || (amt.is_a?(Integer) && amt > 0)
        # Initialize the Hand to be returned and create a copy of the Bag's items to filter through based on description matches
        h = Hand.new
        items = []
        items += h.copy_all(self)
        description.each do |k, v|
            items.select! { |r| k != nil && r.class.instance_methods.include?(k) && r.send(k) == v }
        end

        # Limit the number of returned items by the amount desired, remove items from the Bag and store in the Hand to be returned
        items = items.take(amt) unless amt == :all
        @randomizers -= items
        h.empty
        items.each do |item|
            h.store(item)
        end
        h
    end

    # Overridden method that empties all items from the Bag into a Hand, which is returned
    def empty
        h = Hand.new
        h.copy_all(self)
        super
        h
    end

    # Returns if the given Bag is equal to self
    def ==(o)
        o.is_a?(Bag) && super
    end

    # Returns a Bag clone with copies of all its randomizers
    def clone
        bag_clone = Bag.new
        bag_clone.copy_all(self)
        bag_clone
    end
end
