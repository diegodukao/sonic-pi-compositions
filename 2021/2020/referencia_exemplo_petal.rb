require "~/Projects/sonic-pi/petal-1.3.0/petal.rb"
cps 2.5/6

use_bpm get_bpm * 2
live_loop :paul do
  d1 "hh*2 808:2(3,4) ~ ~"
  with_fx :echo, phase: [2.5, 1.0, 0.5].ring.tick / 6, mix: 1 do
    with_fx :krush, cutoff: 90 do
      d2 "[bd d d ~] cp:3"
    end
  end
  sleep 16
end

live_loop :ringo do
  sleep 4
end

live_loop :john, sync: :ringo do
  use_random_seed 1000
  32.times do
    with_fx :lpf, cutoff: 60 do
      with_fx :slicer, amp_min: 0.4, wave: 2 do
        synth :saw, note: (chord :d3, :augmented, num_octaves: 3).choose, release: 4.5 unless one_in 3
        sleep 0.25
      end
    end
  end
end

live_loop :chris, sync: :ringo do
  sleep [0, 4].choose
  with_fx :echo, decay: [8,12].choose, phase: [0.25,0.5].choose do
    sample :drum_splash_hard, rate: -1, amp: 0.3, lpf: 110
  end
  sleep 8
end
