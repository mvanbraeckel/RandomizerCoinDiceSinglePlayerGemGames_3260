# Course: CIS*3260: Software Design IV | A1: Ruby
# Name: Mitchell Van Braeckel
# Student Number: 1002297
# Email: mvanbrae@uoguelph.ca
# Due Date: September 27, 2021
# Professor: Mark Wineberg
# Language: Ruby

# My personal testing file script used for simple print tests

# require "./A1_Classes.rb"

# ====================== RANDOMIZER ======================
puts "====================== Randomizer.rb ======================"
r = Randomizer.new
# r.reset
puts "after init:\titem=#{r.item}, rand_count=#{r.randomize_count}, result=#{r.result}"
r.reset
puts "after reset:\titem=#{r.item}, rand_count=#{r.randomize_count}, result=#{r.result}"

# ------------------------- COIN -------------------------
puts "------------------------- Coin.rb -------------------------"
c = Coin.new(Coin::DENOMINATIONS.sample)
puts "after init:\t\titem=#{c.item}, rand_count=#{c.randomize_count}, result=#{c.result}, denom=#{c.denomination}, sideup=#{c.sideup}"
c.reset
puts "after reset:\t\titem=#{c.item}, rand_count=#{c.randomize_count}, result=#{c.result}, denom=#{c.denomination}, sideup=#{c.sideup}"
c2 = c.randomize
puts "after randomize (c1):\titem=#{c.item}, rand_count=#{c.randomize_count}, result=#{c.result}, denom=#{c.denomination}, sideup=#{c.sideup}"
puts "after randomize (c2):\titem=#{c2.item}, rand_count=#{c2.randomize_count}, result=#{c2.result}, denom=#{c2.denomination}, sideup=#{c2.sideup}"
c2.reset
puts "after c2 reset (c1):\titem=#{c.item}, rand_count=#{c.randomize_count}, result=#{c.result}, denom=#{c.denomination}, sideup=#{c.sideup}"
puts "after c2 reset (c2):\titem=#{c2.item}, rand_count=#{c2.randomize_count}, result=#{c2.result}, denom=#{c2.denomination}, sideup=#{c2.sideup}"
c2.flip
puts "after c2 flip (c1):\titem=#{c.item}, rand_count=#{c.randomize_count}, result=#{c.result}, denom=#{c.denomination}, sideup=#{c.sideup}"
puts "after c2 flip (c2):\titem=#{c2.item}, rand_count=#{c2.randomize_count}, result=#{c2.result}, denom=#{c2.denomination}, sideup=#{c2.sideup}"
c2 = Coin.new(Coin::DENOMINATIONS.sample)
puts "after new c2 (c1):\titem=#{c.item}, rand_count=#{c.randomize_count}, result=#{c.result}, denom=#{c.denomination}, sideup=#{c.sideup}"
puts "after new c2 (c2):\titem=#{c2.item}, rand_count=#{c2.randomize_count}, result=#{c2.result}, denom=#{c2.denomination}, sideup=#{c2.sideup}"
c2.flip
c2.randomize
puts "c2 r'd and flipped:\titem=#{c2.item}, rand_count=#{c2.randomize_count}, result=#{c2.result}, denom=#{c2.denomination}, sideup=#{c2.sideup}"

# ------------------------- DIE -------------------------
puts "------------------------- Die.rb -------------------------"
SIDES = [2, 4, 6, 8, 10, 12, 20, 30, 100]
d = Die.new(SIDES.sample, Die::COLOURS.sample)
puts "after init:\t\titem=#{d.item}, rand_count=#{d.randomize_count}, result=#{d.result}, colour=#{d.colour}, sides=#{d.sides}, sideup=#{d.sideup}"
d.reset
puts "after reset:\t\titem=#{d.item}, rand_count=#{d.randomize_count}, result=#{d.result}, colour=#{d.colour}, sides=#{d.sides}, sideup=#{d.sideup}"
d2 = d.randomize
puts "after randomize (d1):\titem=#{d.item}, rand_count=#{d.randomize_count}, result=#{d.result}, colour=#{d.colour}, sides=#{d.sides}, sideup=#{d.sideup}"
puts "after randomize (d2):\titem=#{d2.item}, rand_count=#{d2.randomize_count}, result=#{d2.result}, colour=#{d2.colour}, sides=#{d2.sides}, sideup=#{d2.sideup}"
d2.reset
puts "after d2 reset (d1):\titem=#{d.item}, rand_count=#{d.randomize_count}, result=#{d.result}, colour=#{d.colour}, sides=#{d.sides}, sideup=#{d.sideup}"
puts "after d2 reset (d2):\titem=#{d2.item}, rand_count=#{d2.randomize_count}, result=#{d2.result}, colour=#{d2.colour}, sides=#{d2.sides}, sideup=#{d2.sideup}"
d2.roll
puts "after d2 roll (d1):\titem=#{d.item}, rand_count=#{d.randomize_count}, result=#{d.result}, colour=#{d.colour}, sides=#{d.sides}, sideup=#{d.sideup}"
puts "after d2 roll (d2):\titem=#{d2.item}, rand_count=#{d2.randomize_count}, result=#{d2.result}, colour=#{d2.colour}, sides=#{d2.sides}, sideup=#{d2.sideup}"
d2 = Die.new(SIDES.sample, Die::COLOURS.sample)
puts "after new d2 (d1):\titem=#{d.item}, rand_count=#{d.randomize_count}, result=#{d.result}, colour=#{d.colour}, sides=#{d.sides}, sideup=#{d.sideup}"
puts "after new d2 (d2):\titem=#{d2.item}, rand_count=#{d2.randomize_count}, result=#{d2.result}, colour=#{d2.colour}, sides=#{d2.sides}, sideup=#{d2.sideup}"
d2.roll
d2.randomize
puts "d2 r'd and rolled:\titem=#{d2.item}, rand_count=#{d2.randomize_count}, result=#{d2.result}, colour=#{d2.colour}, sides=#{d2.sides}, sideup=#{d2.sideup}"

puts "\n===========================================================\n\n"

# ================= RANDOMIZER CONTAINER =================
puts "================= RandomizerContainer.rb ================="
rc = RandomizerContainer.new
puts "after init (rc1):\trandomizers=#{rc.randomizers}"
rc.store(r)
puts "after store r (rc1):\trandomizers=#{rc.randomizers}"
rc2 = RandomizerContainer.new
puts "after init (rc2):\trandomizers=#{rc2.randomizers}"
rc2.store(c)
puts "after store c (rc2):\trandomizers=#{rc2.randomizers}"
rc.move_all(rc2)
puts "after move all (rc1):\trandomizers=#{rc.randomizers}"
puts "after move all (rc2):\trandomizers=#{rc2.randomizers}"
rc.empty
rc2.empty
puts "after empty (rc1):\trandomizers=#{rc.randomizers}"
puts "after empty (rc2):\trandomizers=#{rc2.randomizers}"

# ------------------------- HAND -------------------------
puts "------------------------- Hand.rb -------------------------"
h = Hand.new
puts "after init (h1):\trandomizers=#{h.randomizers}"
h.store(r)
puts "after store r (h1):\trandomizers=#{h.randomizers}"
h2 = Hand.new
puts "after init (h2):\trandomizers=#{h2.randomizers}"
h2.store(c)
puts "after store c (h2):\trandomizers=#{h2.randomizers}"
h.move_all(h2)
puts "after move all (h1):\trandomizers=#{h.randomizers}"
puts "after move all (h2):\trandomizers=#{h2.randomizers}"
c_pop = h.next
c_pop2 = h2.next
puts "->c_pop:\t#{c_pop}"
puts "->c_pop2:\t#{c_pop2}"
puts "after pop (h1):\trandomizers=#{h.randomizers}"
puts "after pop (h2):\trandomizers=#{h2.randomizers}"
h.empty
h2.empty
puts "after empty (h1):\trandomizers=#{h.randomizers}"
puts "after empty (h2):\trandomizers=#{h2.randomizers}"

# ------------------------- BAG -------------------------
puts "------------------------- Bag.rb -------------------------"
b = Bag.new
puts "after init (b1):\trandomizers=#{b.randomizers}"
b.store(Randomizer.new)
puts "after store new r (b1):\trandomizers=#{b.randomizers}"
b2 = Bag.new
puts "after init (b2):\trandomizers=#{b2.randomizers}"
b2.store(c2)
puts "after store c2 (b2):\trandomizers=#{b2.randomizers}"
b2.randomizers[0].flip
puts "after b2's coin flip:\trandomizers=#{b2.randomizers}"
b.move_all(b2)
puts "after move all (b1):\trandomizers=#{b.randomizers}"
puts "after move all (b2):\trandomizers=#{b2.randomizers}"

# todo - need to properly test select still (remember to use invalid keys, values, and coin keys for dice and vice versa)
b.store(Coin.new(2))
puts "after new coin (b1):\trandomizers=#{b.randomizers}"
puts "after new coin (b2):\trandomizers=#{b2.randomizers}"
hbs = b.select({}, :all)
puts "after select all (b1):\trandomizers=#{b.randomizers}"
puts "after select all (b2):\trandomizers=#{b2.randomizers}"
puts "hand after select all (hbs):\trandomizers=#{hbs.randomizers}"
b.move_all(hbs)
puts "after move all (b1):\trandomizers=#{b.randomizers}"
puts "after move all (b2):\trandomizers=#{b2.randomizers}"
puts "hand after move all (hbs):\trandomizers=#{hbs.randomizers}"
hbs = b.select({denomination: 2}, 1)
puts "after select denom2 (b1):\trandomizers=#{b.randomizers}"
puts "after select denom2 (b2):\trandomizers=#{b2.randomizers}"
puts "hand after select denom2 (hbs):\trandomizers=#{hbs.randomizers}"
b.move_all(hbs)
puts "after move all (b1):\trandomizers=#{b.randomizers}"
puts "after move all (b2):\trandomizers=#{b2.randomizers}"
puts "hand after move all (hbs):\trandomizers=#{hbs.randomizers}"

(0..4).each do |i|
    b2.store(Coin.new(Coin::DENOMINATIONS.sample).randomize)
    b2.store(Die.new(SIDES.sample, Die::COLOURS.sample).randomize)
end
b2.store(Die.new(20, :red).randomize)
hbs_list = []
hbs_list << hbs_1 = b2.select({ item: :die, sides: 4, colour: :yellow, up: 4 }, 1)
hbs_list << hbs_2 = b2.select({ item: :die, colour: :red }, 1)
hbs_list << hbs_3 = b2.select({ sides: 20, colour: :red }, 1)
hbs_list << hbs_4 = b2.select({ item: :die, sides: 6 }, 1)
hbs_list << hbs_5 = b2.select({ item: :die }, 1)
hbs_list << hbs_6 = b2.select({ item: :coin, denomination: 0.25 }, 1)
hbs_list << hbs_7 = b2.select({ item: :coin, up: :H }, 1)
hbs_list << hbs_8 = b2.select({ item: :coin }, 1)
puts "after multi-SELECTS (b1):\trandomizers=#{b.randomizers}"
puts "after multi-SELECTS (b2):\trandomizers=#{b2.randomizers}"
i = 0
hbs_list.each do |hbs_i|
    puts "after multi-SELECTS (#{i += 1}):\trandomizers=#{hbs_i.randomizers}"
end

hbs_asd = b2.select({asd: 3}, 5)
puts "after asd select:\trandomizers=#{hbs_asd.randomizers}"

hb = b.empty
hb2 = b2.empty
puts "after empty (b1):\trandomizers=#{b.randomizers}"
puts "after empty (b2):\trandomizers=#{b2.randomizers}"
puts "hand after empty (hb1):\trandomizers=#{hb.randomizers}"
puts "hand after empty (hb2):\trandomizers=#{hb2.randomizers}"

# ------------------------- CUP -------------------------
puts "------------------------- Cup.rb -------------------------"
cup = Cup.new
puts "after init (cup1):\trandomizers=#{cup.randomizers}"
cup.store(Randomizer.new)
puts "store new r (cup1):\trandomizers=#{cup.randomizers}"
cup2 = Cup.new
puts "after init (cup2):\trandomizers=#{cup2.randomizers}"
cup2.store(Coin.new(Coin::DENOMINATIONS.sample))
puts "store new c (cup2):\trandomizers=#{cup2.randomizers}"
cup.move_all(cup2)
puts "after move_all (cup1):\trandomizers=#{cup.randomizers}"
puts "after move_all (cup2):\trandomizers=#{cup2.randomizers}"
hc = cup.empty
hc2 = cup2.empty
puts "after empty (cup1):\trandomizers=#{cup.randomizers}"
puts "after empty (cup2):\trandomizers=#{cup2.randomizers}"
puts "hand after empty (hc1):\trandomizers=#{hc.randomizers}"
puts "hand after empty (hc2):\trandomizers=#{hc2.randomizers}"
cup.store(Die.new(SIDES.sample, Die::COLOURS.sample))
cup2.store(Die.new(SIDES.sample, Die::COLOURS.sample))
cup.store(Die.new(SIDES.sample, Die::COLOURS.sample))
cup2.store(Coin.new(Coin::DENOMINATIONS.sample))
cup.store(Coin.new(Coin::DENOMINATIONS.sample))
cup2.store(Coin.new(Coin::DENOMINATIONS.sample))
puts "multi-store (cup1):\trandomizers=#{cup.randomizers}"
puts "multi-store (cup2):\trandomizers=#{cup2.randomizers}"

puts "\n"
t = cup.throw
t2 = cup2.throw
puts "after throw (cup1):\trandomizers=#{cup.randomizers}"
puts "after throw (cup2):\trandomizers=#{cup2.randomizers}"
puts "after throw (t1):\trandomizers=#{t.randomizers}"
puts "after throw (t2):\trandomizers=#{t2.randomizers}"
hc = cup.empty
hc2 = cup2.empty
puts "after empty (cup1):\trandomizers=#{cup.randomizers}"
puts "after empty (cup2):\trandomizers=#{cup2.randomizers}"
puts "hand after empty (hc1):\trandomizers=#{hc.randomizers}"
puts "hand after empty (hc2):\trandomizers=#{hc2.randomizers}"
puts "throw after empty (t1):\trandomizers=#{t.randomizers}"
puts "throw after empty (t2):\trandomizers=#{t2.randomizers}"
cup.load(hc2)
cup2.load(hc)
puts "after load hc2 (cup1):\trandomizers=#{cup.randomizers}"
puts "after load hc (cup2):\trandomizers=#{cup2.randomizers}"
puts "hand after load (hc1):\trandomizers=#{hc.randomizers}"
puts "hand after load (hc2):\trandomizers=#{hc2.randomizers}"

# ------------------------ THROW ------------------------
puts "======================== Throw.rb ========================"

puts "throw results (t1):\tresults=#{t.results}"
puts "throw results (t2):\tresults=#{t2.results}"
puts "throw tally (t1):\ttally=#{t.tally}"
puts "throw tally (t2):\ttally=#{t2.tally}"
puts "throw sum (t1):\t\tsum=#{t.sum}"
puts "throw sum (t2):\t\tsum=#{t2.sum}"

# ------------------------ PLAYER ------------------------
puts "\n======================== Player.rb ========================\n\n"
p1 = Player.new("Mitchell Van Braeckel")
puts "after init (p1):\trandomizers=#{p1}"
puts "after init (p1):\trandomizers=#{p1.to_s}"

# todo - modifying to_s for everything to be more efficient and limited output
# todo - then testing Player, then creating use cases and test harnesses
