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

d1 "bd ~  [~ bd]  [~ bd]", slow: 1, amp: 1.2

d2 "[~ sn] ~  sn [~ sn/2]", n: 3, slow: 1

d3 "hh hh hh hh", slow: 1, amp: 2

#d6 "sitar:1 ~ sitar:3 sitar:4" , slow: 4, amp: 2.5, rate: 0.8

d6 :silence

cymbals = true
melody = false
melody2 = false
chords = true
counter = false
arpeggio = true

#d1 "bd [~ bd]  ~  [~ bd]", slow: 1, amp: 1.2

#d2 "[~ sn] ~  sn [~ sn/2]", n: 3, slow: 1

live_loop :bd, sync: :d0 do
  if not cymbals then stop end
  use_bpm get_bpm
  sample :drum_splash_soft
  sleep 4
  sample :drum_cymbal_open, sustain: 0.25, amp: 0.6
  sleep 0.12
  sample :drum_cymbal_closed, amp: 0.6
  sleep 3.88
end

live_loop :melody, sync: :d0 do
  if not melody then stop end
  use_bpm get_bpm
  use_synth :mod_sine
  use_random_seed 200
  8.times do
    play (chord :d3, 'm9+5').choose, amp: 0.6, release: 0.5
    sleep (ring 0.25, 0.125, 0.5).choose
  end
  4.times do
    play (chord :g3, :minor7).choose, amp: 0.6, release: 0.5
    sleep (ring 0.25, 0.125, 0.5).choose
  end
  4.times do
    play (chord :f3, :maj9).choose, amp: 0.6, release: 0.5
    sleep (ring 0.25, 0.125, 0.5).choose
  end
end

live_loop :melody2, sync: :d0 do
  if not melody2 then stop end
  use_bpm get_bpm
  use_synth :piano
  use_random_seed 200
  8.times do
    play (chord :d2, 'm9+5').choose, amp: 0.6, release: 0.5
    sleep (ring 0.25, 0.125, 0.5).choose
  end
  4.times do
    play (chord :g2, :minor7).choose, amp: 0.6, release: 0.5
    sleep (ring 0.25, 0.125, 0.5).choose
  end
  4.times do
    play (chord :f2, :maj9).choose, amp: 0.6, release: 0.5
    sleep (ring 0.25, 0.125, 0.5).choose
  end
end

live_loop :bass, sync: :d0 do
  use_bpm get_bpm
  use_synth :fm
  use_random_seed 2
  
  # play :g3, release: 0.2 if (spread 3, 8).look
  play (scale :d3, :minor)[0], release: 0.2, amp: 0.4
  sleep 1
end

notes = (scale :d2, :minor, num_octaves: 2)
ind = (ring 7, 6, 5, 4)
live_loop :counter, sync: :d0 do
  if not counter then stop end
  use_synth :prophet
  
  play notes[ind.tick], sustain: 3, amp: 0.4
  sleep 4
end

chs1 = (ring (chord :d3, 'm9+5'), (chord :g3, :minor7), (chord :f3, :maj9))
chs2 = (ring (chord :bb3, :maj9), (chord :f4, :maj9), (chord :c4, :maj9))
pattern = 2
chs = chs2
live_loop :chords, sync: :d0 do
  if not chords then stop end
  use_bpm get_bpm
  use_synth :dsaw
  use_random_seed 2
  
  # play :g3, release: 0.2 if (spread 3, 8).look
  if pattern == 1 then
    play chs1.tick, amp: 0.8, decay: 0
    sleep 2
    
    play chs1.tick, amp: 0.8
    sleep 1
    
    play chs1.tick, amp: 0.8
    sleep 1
  else
    play chs2.tick, amp: 0.8, decay: 0
    sleep 2
    
    play chs2.tick, amp: 0.8
    sleep 1
    
    play chs2.tick, amp: 0.8
    sleep 1
  end
  
end


live_loop :arpeggio, sync: :d0 do
  if not arpeggio then stop end
  use_bpm get_bpm
  use_synth :piano
  
  if pattern == 1 then
    play chs1[0].tick, amp: 0.8, decay: 0
    sleep 2
    
    play chs1[1].tick, amp: 0.8
    sleep 1
    
    play chs1[2].tick, amp: 0.8
    sleep 1
  else
    play chs2[0].pick(1), amp: 0.8, decay: 0
    sleep 2
    
    play chs2[1].tick, amp: 0.8
    sleep 1
    
    play chs2[2].tick, amp: 0.8
    sleep 1
  end
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

# d4 "outdoor ~ ~ ~" , slow: 2, n: 2, rate: 'rand 1 0.8, 1.2, 0.6'

# d5 "outdoor ~ ~ ~" , slow: 4, n: 2

#d4 "outdoor:4 [ ~ outdoor:5/2] ~ ~" , slow: 2

# d7 "speakspell(3,8)" , slow: 2, n: "irand 30", rate: 'rand 1 0.8, 1.2, 0.6'
