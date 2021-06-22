require "/home/diego/Projects/sonic-pi/petal/petal.rb"

cps 0.5

bass = false
cymbals = true
splash = true
drums = true
doido = false

chords = true

melody = true
melody2 = true

if drums then
  d1 "bd ~  [~ bd]  [~ bd]", slow: 1, amp: 0.5
  
  d2 "[~ sn] ~  sn [~ sn/2]", n: 3, slow: 1, amp: 0.2
  
  d3 "hh hh hh hh", slow: 1, amp: 1.8
else
  d1 :silence
  d2 :silence
  d3 :silence
end


live_loop :bd, sync: :d0 do
  if not cymbals then stop end
  use_bpm get_bpm
  sample :drum_splash_soft, amp: 0.4 if splash
  sleep 4
  sample :drum_cymbal_open, sustain: 0.25, amp: 0.2
  sleep 0.12
  sample :drum_cymbal_closed, amp: 0.2
  sleep 3.88
end

chs1 = (ring (chord :d3, 'm9+5'), (chord :g3, :minor7), (chord :f3, :maj9),
        (chord :d3, 'm9+5'), (chord :c3, :m9), (chord :f3, 'm7b5'))

pattern = 1
chs = chs1

live_loop :bass, sync: :d0 do
  use_bpm get_bpm
  use_synth :mod_fm
  if not bass then stop end
  use_random_seed 187
  32.times do
    play (chord :d3, :minor).choose - 12, amp: 0.2, pan: 0, release: 0.3 if (spread 10, 16, rotate: 1).choose
    sleep 0.125
  end
end

live_loop :doido, sync: :d0 do
  use_bpm get_bpm
  use_synth :hollow
  if not doido then stop end
  use_random_seed 85702
  with_fx :tanh do
    32.times do
      play (chord :d3, :m7).choose, amp: 0.4, pan: 0, release: 0.3 if (spread 9, 16).choose
      sleep 0.125
    end
  end
end


live_loop :chords, sync: :d0 do
  if not chords then stop end
  use_bpm get_bpm
  use_synth :piano
  
  if pattern == 1 then
    nota = chs[0].tick
    set :nota, nota
    play chs[0], amp: 1, decay: 0, pan: -0.5
    sleep 2
    
    nota = chs[1].tick
    set :nota, nota
    play chs[1], amp: 1, pan: -0.5
    sleep 1
    
    nota = chs[2].tick
    set :nota, nota
    play chs[2], amp: 1, pan: -0.5
    nota = chs[0][0]
    set :nota, nota
    sleep 1
    
    nota = chs[3].tick
    set :nota, nota
    play chs[3], amp: 1, decay: 0, pan: -0.5
    sleep 2
    
    nota = chs[4].tick
    set :nota, nota
    play chs[4], amp: 1, pan: -0.5
    sleep 1
    
    nota = chs[5].tick
    set :nota, nota
    play chs[5], amp: 1, pan: -0.5
    nota = chs[0][0]
    set :nota, nota
    sleep 1
  else
    puts "bla"
  end
end


live_loop :melody, sync: :d0 do
  if not melody then stop end
  use_bpm get_bpm
  use_synth :mod_sine
  use_random_seed 200
  8.times do
    play (chord :d3, 'm9+5').choose, amp: 0.1, release: 0.5
    sleep (ring 0.25, 0.125, 0.5).choose
  end
  4.times do
    play (chord :g3, :minor7).choose, amp: 0.1, release: 0.5
    sleep (ring 0.25, 0.125, 0.5).choose
  end
  4.times do
    play (chord :f3, :maj9).choose, amp: 0.1, release: 0.5
    sleep (ring 0.25, 0.125, 0.5).choose
  end
end

live_loop :melody2, sync: :d0 do
  if not melody2 then stop end
  use_bpm get_bpm
  use_synth :piano
  use_random_seed 200
  8.times do
    play (chord :d2, 'm9+5').choose, amp: 0.3, release: 0.5
    sleep (ring 0.25, 0.125, 0.5).choose
  end
  4.times do
    play (chord :g2, :minor7).choose, amp: 0.3, release: 0.5
    sleep (ring 0.25, 0.125, 0.5).choose
  end
  4.times do
    play (chord :f2, :maj9).choose, amp: 0.3, release: 0.5
    sleep (ring 0.25, 0.125, 0.5).choose
  end
  
  use_random_seed 200
  10.times do
    play (chord :d2, 'm9+5').choose, amp: 0.3, release: 0.5
    sleep (ring 0.25, 0.125, 0.5).choose
  end
  2.times do
    play (chord :c2, :m9).choose, amp: 0.3, release: 0.5
    sleep (ring 0.25, 0.125, 0.5).choose
  end
  4.times do
    play (chord :f2, 'm7b5').choose, amp: 0.3, release: 0.5
    sleep (ring 0.25, 0.125, 0.5).choose
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
