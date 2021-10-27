# Course: CIS*3260: Software Design IV | A1: Ruby
# Name: Mitchell Van Braeckel
# Student Number: 1002297
# Email: mvanbrae@uoguelph.ca
# Due Date: September 27, 2021
# Professor: Mark Wineberg
# Language: Ruby

# The testing file used to create and execute test cases with respect to the created use cases
# Description example: {item: :coin, denomination: 0.25, up: :H}
# Description example: {item: :die, sides: 4, colour: :yellow, up: 4}

require "./A1_Classes.rb"

DIE_SIDES = [4, 6, 8, 10, 12, 20, 30, 100]

# ================= USE CASE 1 =================
def test__dnd_backstabber_attack
    # Init necessary objects
    dirk = Player.new("Dirk Deacon")
    dirk.store(Coin.new(Coin::DENOMINATIONS.sample))
    for i in 0..2
        dirk.store(Die.new(20, Die::COLOURS.sample))
    end
    dirk.store(Die.new(8, Die::COLOURS.sample))

    # Attack roll using 1 coin and 3d20
    dirk.load({ item: :coin })
    dirk.load({ item: :die, sides: 20})
    dirk.throw

    # Damage roll using 1d8
    dirk.load({ sides: 8 })
    dirk.throw

    # Testing
    puts "\n-- 1. D&D Backstabber Attack --\n\n"

    puts "1. Player's number of throws is #{exp_1 = 2}"
    puts "Expected:\t#{exp_1}"
    puts "Actual:\t\t#{dirk.tally};length=#{res_1 = dirk.tally.length}"
    puts res_1 == exp_1 ? "--PASS--" : "--FAIL--"

    puts "2. Player's first throw was the attack roll"
    puts "Expected:\t1 coin and 3d20 results"
    puts "Actual:\t\t#{res_2 = dirk.results({}, 1)}"
    puts res_2.length == 4 ? "--PASS--" : "--FAIL--"

    puts "3. Player's second (most recent) throw was the damage roll"
    puts "Expected:\t1d8 results"
    puts "Actual:\t\t#{res_3 = dirk.results()}"
    puts res_3.length == 1 ? "--PASS--" : "--FAIL--"

    puts "4. Player notes the sum of both rolls, excluding the coin"
    puts "Expected:\tSum of 3d20s of attack roll"
    puts "Actual:\t\t#{res_4 = dirk.sum({item: :die})}"
    puts res_4[1] == res_2[1, res_2.length-1].sum ? "--PASS--" : "--FAIL--"

    puts "5. Player checks if the result of the coin flip is heads"
    puts "Expected:\tCoin flip is heads if second value is 1"
    puts "Actual:\t\t#{res_5 = dirk.sum({item: :coin, up: :H})}"
    puts (res_5[1] == 1 ? :H : :T) == res_2[0] ? "--PASS--" : "--FAIL--"

    puts "6. Player checks for any natural 20s"
    puts "Expected:\tSum of 3d20s of attack roll is at least 20 if there was at least 1 nat20"
    puts "Actual:\t\t#{res_6 = dirk.sum({sides: 20, up: 20})}"
    exp_nat20 = res_2[1, res_2.length-1].include?(20)
    puts (res_6.sum > 0 && exp_nat20) || (res_6.sum == 0 && !exp_nat20) ? "--PASS--" : "--FAIL--"

    puts "7. Now, the player erases turn throw history now that his turn is over"
    puts "Expected:\tempty array of results"
    puts "Actual:\t\t#{res_7 = dirk.clear}"
    puts res_7 == [] ? "--PASS--" : "--FAIL--"
end

# ================= USE CASE 2 =================
def test__bag_of_lost_coins_leads_to_lottery_ticket
    # Init necessary objects
    lost_bag = Bag.new
    for i in 0..4
        lost_bag.store(Coin.new(Coin::DENOMINATIONS.sample))
    end

    name = "Bill Bigsby"
    bill = Player.new(name)

    # Dump lost bag's contents to Bill's bag
    bill.move_all(lost_bag)

    # Later, toss Bill's bag contents to count money
    bill.load()
    bill.throw

    # Testing
    puts "\n-- 2. Bag of 5 Lost Coins Leads to Lottery Ticket --\n\n"

    puts "1. Player's name is #{exp_1 =name}"
    puts "Expected:\t#{exp_1}"
    puts "Actual:\t\t#{res_1 = bill.name}"
    puts res_1 == exp_1 ? "--PASS--" : "--FAIL--"

    puts "2. Lost bag is empty after contents is taken"
    puts "Expected:\tLost bag has no items"
    puts "Actual:\t\t#{res_2 = lost_bag.randomizers}"
    puts res_2 == [] ? "--PASS--" : "--FAIL--"

    puts "3. Bill's bag contains 5 coins"
    puts "Expected:\t#{exp_3 = 5}"
    puts "Actual:\t\tItem Count=#{res_3a = bill.tally}; Num Coins=#{res_3b = bill.tally(item: :coin)}"
    puts res_3a[0] == exp_3 && res_3b[0] == exp_3 ? "--PASS--" : "--FAIL--"

    puts "4. Bill dumps the money out of his bag to count it"
    puts "Expected:\t#{exp_3} coins are thrown out"
    puts "Actual:\t\t#{res_4 = bill.results()}"
    puts res_4.length == exp_3 ? "--PASS--" : "--FAIL--"

    bill_hand = Hand.new
    bill_hand.copy_all(bill.bag)
    bill_money_sum = 0
    bill_hand.randomizers.each do |r|
        bill_money_sum += r.denomination
    end
    puts "5. Bill counts the money with his hand one-by-one to see if he has enough to buy a lottery ticket"
    puts "Expected:\tSum of all coins is at least #{exp_5_min_val = 0.05*5}"
    puts "Actual:\t\t#{res_5 = bill_money_sum}"
    puts res_5 >= exp_5_min_val ? "--PASS--" : "--FAIL--"
end

# ================= USE CASE 3 =================
def test__dice_battle__naruto_vs_sasuke
    # Init necessary objects
    naruto = Player.new("Naruto Uzumaki")
    sasuke = Player.new("Sasuke Uchiha")

    # Both ready their dice and coin
    naruto.store(Die.new(100, Die::COLOURS.sample))
    naruto.store(Die.new(20, Die::COLOURS.sample))
    naruto.store(Die.new(6, Die::COLOURS.sample))
    naruto.store(Coin.new(Coin::DENOMINATIONS.sample))

    sasuke.store(Die.new(100, Die::COLOURS.sample))
    sasuke.store(Die.new(20, Die::COLOURS.sample))
    sasuke.store(Die.new(6, Die::COLOURS.sample))
    sasuke.store(Coin.new(Coin::DENOMINATIONS.sample))

    # Dice battle - load and throw all dice and coins for each person
    naruto.load()
    sasuke.load()
    naruto.throw
    sasuke.throw

    # Testing
    puts "\n-- 3. Dice Battle to See Who Has Better Luck --\n\n"

    puts "1. Naruto checks his #{exp_1 = 4} results"
    puts "Expected:\t1d100, 1d20, 1d6, and 1 coin results"
    puts "Actual:\t\t#{res_1 = naruto.results}"
    puts res_1.length == exp_1 ? "--PASS--" : "--FAIL--"

    puts "2. Sasuke checks his #{exp_2 = 4} results"
    puts "Expected:\t1d100, 1d20, 1d6, and 1 coin results"
    puts "Actual:\t\t#{res_2 = sasuke.results}"
    puts res_2.length == exp_2 ? "--PASS--" : "--FAIL--"

    puts "3. Naruto totals his results"
    puts "Expected:\tTotal sum of his results"
    puts "Actual:\t\t#{res_3 = naruto.sum}"
    exp_3 = res_1[1, res_1.length-1].sum
    exp_3 += res_1[0] == :H ? 1 : 0
    puts res_3[0] == exp_3 ? "--PASS--" : "--FAIL--"

    puts "4. Sasuke totals his results"
    puts "Expected:\tTotal sum of his results"
    puts "Actual:\t\t#{res_4 = sasuke.sum}"
    exp_4 = res_2[1, res_2.length-1].sum
    exp_4 += res_2[0] == :H ? 1 : 0
    puts res_4[0] == exp_4 ? "--PASS--" : "--FAIL--"

    puts "5. Naruto and Sasuke compare total results to see who won"
    puts "Expected:\tThe higher total result of the two wins - Naruto=#{res_3[0]} vs Sasuke=#{res_4[0]}"
    res_5 = nil
    if res_3[0] > res_4[0]
        res_5 = "Naruto wins! His #{res_3[0]} beat Sasuke's #{res_4[0]}"
    elsif res_3[0] < res_4[0]
        res_5 = "Sasuke wins! His #{res_4[0]} beat Naruto's #{res_3[0]}"
    elsif res_3[0] == res_4[0]
        res_5 = "A tie?!... the total results were equal... awkward..."
    end
    puts "Actual:\t\t#{res_5}"
    puts res_5 != nil ? "--PASS--" : "--FAIL--"
end

# ================ EXTRA TESTING ================

def test__bag_cloning
    # Init necessary objects
    p1 = Player.new("p1")
    cpu = Player.new("cpu")

    # Both ready their dice and coin
    p1.store(Die.new(100, Die::COLOURS.sample))
    p1.store(Die.new(20, Die::COLOURS.sample))
    p1.store(Die.new(6, Die::COLOURS.sample))
    p1.store(Coin.new(Coin::DENOMINATIONS.sample))

    p1_bag_clone = p1.bag # Clone of p1 bag with same item contents
    cpu.move_all(p1_bag_clone)

    puts "\n=========== Bag Cloning ===========\n\n"
    puts "p1 bag:\n#{p1.bag.print_items}"
    puts "cpu bag:\n#{cpu.bag.print_items}"
end

def test__rc_randomizers_cloning
    # Init necessary objects
    p1 = Player.new("p1")

    # Both ready their dice and coin
    p1.store(Die.new(100, Die::COLOURS.sample))
    p1.store(Coin.new(Coin::DENOMINATIONS.sample))

    p1_bag_clone = p1.bag # Clone of p1 bag with same item contents
    p1_items = p1.bag.randomizers
    p1_popped_item = p1_items.pop

    puts "\n===== RC Randomizers Cloning =====\n\n"
    puts "p1 bag:\n#{p1.bag.print_items}"
    puts "p1 bag items:\t\t#{p1.bag.randomizers}"
    puts "p1 bag cloned items:\t#{p1_items}"
    puts "p1 bag cloned items pop:\t#{p1_popped_item.print_item}"
end

def test__random_select_and_add_items_from_player1_to_player2
    # Init necessary objects
    p1 = Player.new("p1")
    p2 = Player.new("p2")

    # Both ready their dice and coin
    p1.store(Die.new(100, Die::COLOURS.sample))
    p1.store(Die.new(20, Die::COLOURS.sample))
    p1.store(Die.new(6, Die::COLOURS.sample))
    p1.store(Coin.new(Coin::DENOMINATIONS.sample))

    p2_bag = p1.bag

    p2_bag.randomizers.each do |item|
        if rand(2) == 1
            p2.store(item.clone)
            next
        end
    end

    p1.load({item: :die})
    p1.throw
    p2.load
    p2.throw

    puts "\n===== Random Select+AddItems from P1 bag to P2 bag =====\n\n"
    puts "p1 bag:\n#{p1.bag.print_items}"
    puts "p1 bag items:\t\t#{p1.bag.randomizers}"
    puts "p2 bag:\n#{p2.bag.print_items}"
    puts "p2 bag items:\t\t#{p2.bag.randomizers}"
    puts "p1 (die) results:\n#{p1.results({item: :die})}"
    puts "p2 (die) results:\n#{p2.results({item: :die})}"
    puts "p1:\n#{p1.bag.items_description}"
    puts "p2:\n#{p2.bag.items_description}"
end

# ===============================================
# -------------- MAIN TEST HARNESS --------------
# ===============================================

# Runs the test harness and all tests
def main_test_harness
    test__dnd_backstabber_attack
    test__bag_of_lost_coins_leads_to_lottery_ticket
    test__dice_battle__naruto_vs_sasuke

    puts "\n----- Extra Testing -----\n\n"
    test__bag_cloning
    test__rc_randomizers_cloning
    test__random_select_and_add_items_from_player1_to_player2
end

# ==================== MAIN ====================
main_test_harness
