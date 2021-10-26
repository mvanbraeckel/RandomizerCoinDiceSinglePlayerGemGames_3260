class GamesController < ApplicationController
  def index
  end

  def playgame
    # # Get all the user's items as objects and add it to the player's bag (ignores bad items)
    # @player = Player.new(current_user.username)
    # for item in items
    #   if item.item == "coin" || item.item == :coin
    #     @player.store(Coin.new(item.denomination))
    #   elsif item.item == "die" || item.item == :die
    #     @player.store(Die.new(item.sides, item.colour))
    #   end
    # end

    # # Computer gets a duplicate bag contents mirroring the player's
    # @cpu_bag = @player.bag
    # @cpu_player = Player.new("cpu-#{current_user.username}")
    # @cpu_player.move_all(@cpu_bag)

    # Get all the user's items, roll them all and append to an array the result, while also accumulating total sum (where heads = 1, tails = 0)
    items = current_user.items
    @player_results = []
    @player_sum = 0
    for item in items
      if item.item == "coin" || item.item == :coin
        coin_result = (rand(2) == 0 ? :T : :H)
        @player_results << coin_result
        @player_sum += (coin_result == :H ? 1 : 0)
      elsif item.item == "die" || item.item == :die
        die_result = 1 + rand(item.sides)
        @player_results << die_result
        @player_sum += die_result
      else
        @player_results << 0
      end
    end

    # Do the same thing again, but for the computer
    items = current_user.items
    @cpu_results = []
    @cpu_sum = 0
    for item in items
      if item.item == "coin" || item.item == :coin
        coin_result = (rand(2) == 0 ? :T : :H)
        @cpu_results << coin_result
        @cpu_sum += (coin_result == :H ? 1 : 0)
      elsif item.item == "die" || item.item == :die
        die_result = 1 + rand(item.sides)
        @cpu_results << die_result
        @cpu_sum += die_result
      else
        @cpu_results << 0
      end
    end

    # Determine who won, including messages to display, etc.
    # Properly calculate and display and increase earned points and gems based on the math, then save the user.

    if @player_sum > @cpu_sum
      @win_lose_msg = "You win! Congratulations..."

      @points_won = (@player_sum - @cpu_sum) * 1
      @gems_won = (@points_won / 2).floor

      current_user.points += @points_won
      current_user.gems += @gems_won
      current_user.save

    else
      @win_lose_msg = "You lose! Better luck next time..."

      @points_won = 0
      @gems_won = 0
    end
  end
end
