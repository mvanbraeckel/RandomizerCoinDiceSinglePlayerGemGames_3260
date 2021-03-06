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

    # Randomly determine goal as sum or tally result
    @goal_type = :summed
    if rand(4) < 1
      @goal_type = :tallied
    end

    # Randomly determine coin and/or die goal description
    # NOTE: 0: coin only, 1: bag only, 2: both
    random_goal = rand(3)
    coins_list = @player.bag.select({item: :coin}, :all).randomizers
    dice_list = @player.bag.select({item: :die}, :all).randomizers
    goal_coin_flag = (random_goal == 0 || random_goal == 2) && coins_list.length > 0
    goal_die_flag = (random_goal == 1 || random_goal == 2) && dice_list.length > 0

    # Pick random item(s) for the description to base goal on, then randomly determine extra description criteria
    # and add a random sideup field for tally goal type (via :up)
    # NOTE: Description example: {item: :coin, denomination: 0.25, up: :H}
    # NOTE: Description example: {item: :die, sides: 4, colour: :yellow, up: 4}
    @goal_coin_descr_hash = nil
    @goal_die_descr_hash = nil

    if goal_coin_flag
      goal_coin = coins_list[rand(coins_list.length)]
      @goal_coin_descr_hash = {item: :coin}
      if rand(2) == 1
        @goal_coin_descr_hash[:denomination] = goal_coin.denomination
      end
      if @goal_type == :tallied
        @goal_coin_descr_hash[:up] = (rand(2) == 0 ? :T : :H)
      end
    end

    if goal_die_flag
      goal_die = dice_list[rand(dice_list.length)]
      @goal_die_descr_hash = {item: :die}
      if rand(2) == 1
        @goal_die_descr_hash[:sides] = goal_die.sides
      end
      if rand(2) == 1
        @goal_die_descr_hash[:colour] = goal_die.colour
      end
      if @goal_type == :tallied
        @goal_die_descr_hash[:up] = 1 + rand(goal_die.sides)
      end
    end

    # Save things goal info in session
    session[:goal_type] = @goal_type
    session[:goal_coin_descr_hash] = @goal_coin_descr_hash
    session[:goal_die_descr_hash] = @goal_die_descr_hash

    # Searches player bag based on goal description(s), loading their cup with matching items, then throws it
    # Then, get the player throw results and calculate sum/tally
    if current_goal_coin_descr_hash
      goal_coin_descr_hash_no_up = current_goal_coin_descr_hash.clone
      goal_coin_descr_hash_no_up.delete(:up)
      @player.load(goal_coin_descr_hash_no_up)
    end
    if current_goal_die_descr_hash
      goal_die_descr_hash_no_up = current_goal_die_descr_hash.clone
      goal_die_descr_hash_no_up.delete(:up)
      @player.load(goal_die_descr_hash_no_up)
    end
    if !current_goal_coin_descr_hash && !current_goal_die_descr_hash
      @player.load
    end
    @player.throw
    @player_results = (current_goal_coin_descr_hash ? @player.results(goal_coin_descr_hash_no_up) : []) + (current_goal_die_descr_hash ? @player.results(goal_die_descr_hash_no_up) : [])
    # @player_bag_list = @player.bag.items_description

    # Computer gets a duplicate bag (clone) with contents mirroring the player's
    # but computer randomly selects a items to load for its throw (regardless of goal, like in assignment description. ie. cpu is not smart)
    @cpu = Player.new("cpu-#{current_user.username}")
    cpu_bag = @player.bag
    for item in cpu_bag.randomizers
      if rand(10) < 9
        @cpu.store(item.clone)
      end
    end

    # Then, get the computer throw results and calculate sum/tally
    @cpu.load
    @cpu.throw
    @cpu_results = (current_goal_coin_descr_hash ? @cpu.results(goal_coin_descr_hash_no_up) : []) + (current_goal_die_descr_hash ? @cpu.results(goal_die_descr_hash_no_up) : [])
    # @cpu_bag_list = @cpu.bag.items_description

    # Determine who won, including messages to display, etc.
    # Properly calculate and display and increase earned points and gems based on the math, then save the user.
    @player_score = 0
    @cpu_score = 0
    if @goal_type == :tallied
      @results_descr = "Tallies"
      if current_goal_coin_descr_hash
        @player_score += (current_goal_coin_descr_hash ? @player.tally(current_goal_coin_descr_hash)[0] : 0)
        @cpu_score += (current_goal_coin_descr_hash ? @cpu.tally(current_goal_coin_descr_hash)[0] : 0)
      end
      if current_goal_die_descr_hash
        @player_score += (current_goal_die_descr_hash ? @player.tally(current_goal_die_descr_hash)[0] : 0)
        @cpu_score += (current_goal_die_descr_hash ? @cpu.tally(current_goal_die_descr_hash)[0] : 0)
      end
    else # @goal_type == :summed
      @results_descr = "Sums"
      if current_goal_coin_descr_hash
        @player_score += (current_goal_coin_descr_hash ? @player.sum(goal_coin_descr_hash_no_up)[0] : 0)
        @cpu_score += (current_goal_coin_descr_hash ? @cpu.sum(goal_coin_descr_hash_no_up)[0] : 0)
      end
      if current_goal_die_descr_hash
        @player_score += (current_goal_die_descr_hash ? @player.sum(goal_die_descr_hash_no_up)[0] : 0)
        @cpu_score += (current_goal_die_descr_hash ? @cpu.sum(goal_die_descr_hash_no_up)[0] : 0)
      end
    end

    if @player_score > @cpu_score
      @win_lose_msg = "You win! Congratulations..."

      @points_won = (@player_score - @cpu_score) * 1
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
