# Course: CIS*3260: Software Design IV | A1: Ruby
# Name: Mitchell Van Braeckel
# Student Number: 1002297
# Email: mvanbrae@uoguelph.ca
# Due Date: September 27, 2021
# Professor: Mark Wineberg
# Language: Ruby

# require "./Cup.rb"

# High Level Class : Throw
# Description example: {item: :coin, denomination: 0.25, up: :H}
# Description example: {item: :die, sides: 4, colour: :yellow, up: 4}
class Throw
    # Default constructor for a Throw object (i.e. Throw.new(cup)); virtual copies of Cup randomizers are stored in a newly created Throw object
    def initialize(cup)
        @randomizers = []
        @description = {}
        raise ArgumentError, "Cup '#{cup}' is invalid - must be a Cup instance." unless cup.is_a?(Cup)
        @randomizers += cup.randomizers
    end

    # Stores a description in the Throw from which the "Randomizer" objects in the Throw can be selected when computing the results, tally or sum
    def description(description)
        raise ArgumentError, "Description '#{description}' is invalid - must be a Hash." unless description.is_a?(Hash)
        @description = description
    end

    # Returns an array containing the "side-up" results of the randomizers recorded in the Throw
    # NOTE: Only include the values from randomizers that match the description stored in the Throw
    # NOTE: If description() has not yet been called, return the results from all randomizers
    def results
        results_list = []
        self.description_filter.each do |r|
            results_list << r.result unless r.result == nil
        end
        results_list
    end

    # Counts the items in the Throw that match the description and returns the value
    # NOTE: If description() has not yet been called, count all randomizers
    def tally
        self.description_filter.length
    end

    # Sums up (i.e. totals) the result values of the randomizer items in the Throw that match the description, where the result value equals the number that is "up" (for coins, :H = 1 and :T = 0), and returns the value
    # NOTE: If description() has not yet been called, total the values across all randomizers
    def sum
        sum = 0
        self.description_filter.each do |r|
            sum += r.result_value unless r.result_value == nil
        end
        sum
    end

    # Returns a copy of the randomizers in the Throw object (so it isn't connected by reference, thus not breaking encapsulation)
    def randomizers
        @randomizers.clone
    end

    # Returns a copy of the matching items of the Throw object that have been filtered based on description matches
    def description_filter
        items = []
        items += self.randomizers
        @description.each do |k, v|
            items.select! { |r| k != nil && r.class.instance_methods.include?(k) && r.send(k) == v }
        end
        items
    end

    # # Returns if the given Throw is equal to self
    # def ==(o)
    #     o.is_a?(Throw) && self.randomizers.sort == o.randomizers.sort && self.description_filter == o.description_filter && self.results == o.results && self.tally == o.tally && self.sum == o.sum
    # end

    # # Returns a string representation of the Throw
    # def to_s
    #     to_print = "Throw Randomizers:\n"
    #     @randomizers.each do |r|
    #         to_print += "#{r.to_s.strip}\n"
    #     end
    #     "Randomizers=#{to_print.strip}\nDescription=#{@description}\nResults=#{self.results}\nTally=#{self.tally}\nSum=#{self.sum}".strip
    # end
end
