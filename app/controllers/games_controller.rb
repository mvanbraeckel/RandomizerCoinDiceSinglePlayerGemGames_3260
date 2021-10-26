class GamesController < ApplicationController
  def index
  end

  def playgame
    # Get all the user's items, make objects for each adding them to the player's bag (ignores bad items)
    @player = Player.new(current_user.username)
    items = current_user.items
    for item in items
      if item.item == "coin" || item.item == :coin
        @player.store(Coin.new(item.denomination))
      elsif item.item == "die" || item.item == :die
        @player.store(Die.new(item.sides, item.colour.parameterize.underscore.to_sym))
      end
    end

    # Computer gets a duplicate bag contents mirroring the player's
    cpu_bag = @player.bag # Clone of player bag with same item contents
    @cpu = Player.new("cpu-#{current_user.username}")
    @cpu.move_all(cpu_bag)

    # NOTE: for simple game, goal description is default empty {} for all items in bag
    # NOTE: for simple game, always sum goal

    # Searches player bag based on goal description, loading their cup with matching items, then throws it
    # Then, get the player throw results and calculate sum/tally
    @player.load
    @player.throw
    @player_results = @player.results
    @player_sum = @player.sum[0]

    # Computer also searches its bag based on goal description, loading its cup with matching items, then throws it
    # Then, get the computer throw results and calculate sum/tally
    @cpu.load
    @cpu.throw
    @cpu_results = @cpu.results
    @cpu_sum = @cpu.sum[0]

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
