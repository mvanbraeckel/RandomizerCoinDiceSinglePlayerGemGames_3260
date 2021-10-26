# Course: CIS*3260: Software Design IV | A1: Ruby
# Name: Mitchell Van Braeckel
# Student Number: 1002297
# Email: mvanbrae@uoguelph.ca
# Due Date: September 27, 2021
# Professor: Mark Wineberg
# Language: Ruby

# require "./RandomizerContainer.rb"

# Hand <Inherits from RandomizerContainer>
# NOTE: the following method is covered by ingeritance from the parent RandomizerContainer
# -> empty() : returns nil (items are "dropped on the ground") i.e. the pointers to the contained objects are lost (and the objects will be garbage collected by the system)
# Note: All RandomizerContainer objects are created empty. Therefore they are just called with 'new' (e.g. `Cup.new`)
class Hand < RandomizerContainer
    # Removes and returns the last objected added (if no objects stored, return nil)
    def next
        @randomizers.pop
    end

    # # Returns if the given Hand is equal to self
    # def ==(o)
    #     o.is_a?(Hand) && super
    # end

    # # Returns a Hand clone with copies of all its randomizers
    # def clone
    #     Hand.new.copy_all(self)
    # end
end
