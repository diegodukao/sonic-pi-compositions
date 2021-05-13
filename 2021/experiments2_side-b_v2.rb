require "/home/diego/Projects/sonic-pi/petal/petal.rb"

##| d1 "bd [~ bd/2] bd/2 [~ bd]", slow: 2
##| d2 "hh [~ hh/3] [~ hh] hh"
##| d3 "~ sn ~ sn", n: 1, slow: 4

# d6 "sitar(3,8)" , slow: 4, n: "irand 2" , rate: 'rand 1 0.8, 1.2, 0.6', amp: 1.2

#d7 "sitar(3,8)" , slow: 8, n: "1 3", amp: 1.2

#d6 "sitar(3,8)" , slow: 4, n: "irand 2" , rate: 'rand 1 0.8, 1.2, 0.6', amp: 1.2

#d7 :silence
# 1, 2, 3, 4

cps 0.5

d1 "bd ~ bd ~  ~", slow: 5

d2 "~ ~ ~ sn ~", n: 3, slow: 5

d3 "hh hh hh hh hh", slow: 2.5

# d6 :silence

live_loop :sitar, sync: :d0 do
  use_bpm get_bpm
  d6 "sitar:1 ~ sitar:3 sitar:4 ~" , slow: 5, amp: 1.2, rate: 0.8
  sleep 25
end

live_loop :melody, sync: :d0 do
  use_bpm get_bpm
  use_synth :pluck
  use_random_seed 200
  35.times do
    play (chord :d3, :maj9).choose, amp: 0.5
    sleep (ring 0.25, 0.125, 0.75).choose
  end
end

# d6 "sitar:2 sitar:4 ~ sitar:1" , slow: 4, amp: 1.2, rate: 0.8


live_loop :bass, sync: :d0 do
  stop
  use_bpm get_bpm
  use_synth :fm
  use_random_seed 2
  
  # play :g3, release: 0.2 if (spread 3, 8).look
  play (scale :g3, :minor)[0], release: 0.2, amp: 1 if (spread 3, 8).tick
  
  
  sleep 0.125
end

########

##| d7 "dork2(3,16,2)", n: "irand 4", rate: 1

# d7 "future(5,16,2)" , slow: 2, n: "irand 4"# rate: 'rand 1 2'

# d7 "house(5,16,2)" , slow: 2, n: 1, rate: 'rand 1 0.8, 1.2, 0.6'

# d7 "jungbass(1,16,2)" , slow: 2, n: "irand 6" # , rate: 'rand 1 0.8, 1.2, 0.6'

# d7 "koy(1,16,2)" , slow: 2, n: "irand 6" # , rate: 'rand 1 0.8, 1.2, 0.6'

# d7 "kurt(5,16,2)" , slow: 2, n: "irand 6"  , rate: 'rand 1 -0.8, 1.2, -0.6'

# d7 "less(5,16,2)" , slow: 2, n: "irand 6" # , rate: 'rand 1 0.8, 1.2, 0.6'

###



# d7 "toys(3,8)" , slow: 4, n: "irand 5", rate: -1 #, rate: 'rand 1 0.8, 1.2, 0.6'

# d5 "rave(3,8)" , slow: 4, n: "irand 30", rate: 'rand -1 0.8, 1.2, -0.6'

# d5 "rave(3,8)" , slow: 4, n: "irand 30", rate: 'rand -1, 0.8, 1.2, -0.6'

#d5 "rave(3,8)" , slow: 4, n: "2", rate: '-1 0.8 1.2 -0.6'

#d5 "rave(3,8,1)" , slow: 4, n: "0", rate: -0.8

d5 :silence

# d4 "outdoor ~ ~ ~" , slow: 2, n: 2, rate: 'rand 1 0.8, 1.2, 0.6'

# d5 "outdoor ~ ~ ~" , slow: 4, n: 2

#d4 "outdoor:4 [ ~ outdoor:5/2] ~ ~" , slow: 2
d4 :silence

# d7 "speakspell(3,8)" , slow: 2, n: "irand 30", rate: 'rand 1 0.8, 1.2, 0.6'
