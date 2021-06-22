require "/home/diego/Projects/sonic-pi/petal/petal.rb"

cps 0.5

bass = false
cymbals = true
splash = true
drums = false

doido = true

chords = false

melody = false

pan_melody = 0.5
amp_melody = 0.2

if drums then
  d1 "bd ~  [~ bd]  [~ bd]", slow: 1, amp: 0.45
  
  d2 "[~ sn] ~  sn [~ sn/2]", n: 3, slow: 1, amp: 0.18
  
  d3 "hh hh hh hh", slow: 1, amp: "0.8 0.6 0.7", pan: -0.3
else
  d1 :silence
  d2 :silence
  d3 :silence
end


live_loop :bd, sync: :d0 do
  if not cymbals then stop end
  use_bpm get_bpm
  sample :drum_splash_soft, amp: 0.4, pan: 0.3 if splash
  sleep 4
  sample :drum_cymbal_open, sustain: 0.25, amp: 0.12, pan: -0.3
  sleep 0.12
  sample :drum_cymbal_closed, amp: 0.12, pan: -0.3
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
    play (chord :d3, :minor).choose - 12, amp: 0.28, pan: 0, release: 0.3 if (spread 10, 16, rotate: 1).choose
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

pan_chords = 0
amp_chords = 0.8
live_loop :chords, sync: :d0 do
  if not chords then stop end
  use_bpm get_bpm
  use_synth :piano
  
  with_fx :reverb, mix: 0.5, room: 0.85  do
    nota = chs[0].tick
    set :nota, nota
    play chs[0], amp: amp_chords, decay: 0, pan: pan_chords
    sleep 2
    
    nota = chs[1].tick
    set :nota, nota
    play chs[1], amp: amp_chords, pan: pan_chords
    sleep 1
    
    nota = chs[2].tick
    set :nota, nota
    play chs[2], amp: amp_chords, pan: pan_chords
    nota = chs[0][0]
    set :nota, nota
    sleep 1
    
    nota = chs[3].tick
    set :nota, nota
    play chs[3], amp: amp_chords, decay: 0, pan: pan_chords
    sleep 2
    
    nota = chs[4].tick
    set :nota, nota
    play chs[4], amp: amp_chords, pan: pan_chords
    sleep 1
    
    nota = chs[5].tick
    set :nota, nota
    play chs[5], amp: amp_chords, pan: pan_chords
    nota = chs[0][0]
    set :nota, nota
    sleep 1
  end
end


live_loop :melody, sync: :d0 do
  if not melody then stop end
  use_bpm get_bpm
  use_synth :mod_sine
  use_random_seed 200
  8.times do
    play (chord :d3, 'm9+5').choose, amp: amp_melody, release: 0.5, pan: pan_melody
    sleep (ring 0.25, 0.125, 0.5).choose
  end
  4.times do
    play (chord :g3, :minor7).choose, amp: amp_melody, release: 0.5, pan: pan_melody
    sleep (ring 0.25, 0.125, 0.5).choose
  end
  4.times do
    play (chord :f3, :maj9).choose, amp: amp_melody, release: 0.5, pan: pan_melody
    sleep (ring 0.25, 0.125, 0.5).choose
  end
  use_random_seed 200
  8.times do
    play (chord :d3, 'm9+5').choose, amp: amp_melody, release: 0.5, pan: pan_melody
    sleep (ring 0.25, 0.125, 0.5).choose
  end
  4.times do
    play (chord :c3, :m9).choose, amp: amp_melody, release: 0.5, pan: pan_melody
    sleep (ring 0.25, 0.125, 0.5).choose
  end
  4.times do
    play (chord :f3, :maj9).choose, amp: amp_melody, release: 0.5, pan: pan_melody
    sleep (ring 0.25, 0.125, 0.5).choose
  end
end