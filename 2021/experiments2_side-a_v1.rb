require "/home/diego/Projects/sonic-pi/petal/petal.rb"

cps 0.9

d1 "bd ~ ~ ~"

live_loop :chords, sync: :d0 do
  use_bpm get_bpm
  # use_synth :pretty_bell
  use_synth :zawa
  with_fx :reverb, mix: 0.7, room: 0.9 do
    play (chord :d3, :m11), amp: 0.8, attack: 0.6, sustain: 0.4, decay: 0.4
    sleep 4
    play (chord :eb3, :m11), amp: 0.8, attack: 0.6, sustain: 0.4, decay: 0.4
    sleep 4
  end
end

live_loop :bass, sync: :d0 do
  use_bpm get_bpm
  use_synth :fm
  use_random_seed 200
  6.times do
    play (chord :d2, :m11, num_octaves: 1).choose, amp: 0.4
    puts 
    sleep (ring 1, 0.75, 0.5, 1, 0.25, 0.5).tick
  end
  use_random_seed 300
  6.times do
    play (chord :d2, :m11, num_octaves: 1).choose, amp: 0.4
    sleep (ring 1, 0.75, 0.5, 1, 0.25, 0.5).tick
  end
end

live_loop :melody, sync: :d0 do
  stop
  use_bpm get_bpm
  use_synth :pulse
  
  32.times do
    play (scale :d3, :minor_pentatonic).choose, amp: 0.15 if (spread 11, 16).tick
    sleep 0.125
  end
end
