require "~/Projects/sonic-pi/petal-1.3.0/petal.rb"
cps 1

pat = 2

d1 "hh*2",  amp: "0.3 0.6"

d2 "sn [~sn] [sn/2 sn/3] sn", amp: "0.2 0.1 0.4 0.3"

live_loop :lead, sync: :d0 do
  stop
  use_bpm get_bpm
  use_synth :piano
  use_random_seed 20
  32.times do
    play (scale :a4, :minor).choose, amp: 0.3 if (spread (ring 2, 4, 3).tick, 8).look
    sleep 0.125
  end
  use_random_seed 300
  16.times do
    play (scale :c5, :minor_pentatonic).choose, amp: 0.3 if (spread (ring 2, 4, 3).tick, 8).look
    sleep 0.125
  end
  16.times do
    play (scale :a4, :minor).choose, amp: 0.3 if (spread (ring 2, 4, 3).tick, 8).look
    sleep 0.125
  end
end

c_chord = (chord :a2, :minor)


live_loop :chords, sync: :d0 do
  use_bpm get_bpm
  use_synth :piano
  if pat == 1 then
    play (chord :d3, :minor), sustain: 0.7
    sleep 2
    play (chord :d3, :dim), sustain: 0.7
    sleep 2
    play (chord :d3, :minor), sustain: 0.7
    sleep 2
    play (chord :e3, '7'), sustain: 0.7
    sleep 2
  else
    c_chord = (chord :a2, :minor)
    play (chord :a2, :minor), sustain: 0.7
    sleep 1.5
    c_chord = (chord :b2, :major)
    play (chord :b2, :major), sustain: 0.7
    sleep 2.5
    c_chord = (chord :c3, :minor)
    play (chord :c3, :minor), sustain: 0.7
    sleep 1.5
    c_chord = (chord :bb2, :major)
    play (chord :bb2, :major), sustain: 0.7
    sleep 2.5
    c_chord = (chord :a2, :minor)
    play (chord :a2, :minor), sustain: 0.7
    sleep 1.5
    c_chord = (chord :b2, :major)
    play (chord :b2, :major), sustain: 0.7
    sleep 2.5
    c_chord = (chord :c3, :minor)
    play (chord :c3, :minor), sustain: 0.7
    sleep 1.5
    c_chord = (chord :e2, '7')
    play (chord :e2, '7'), sustain: 0.7
    sleep 2.5
  end
end

live_loop :other, sync: :d0 do
  use_synth :fm
  use_random_seed 500
  32.times do
    play c_chord.choose, amp: 0.2 if (spread 3, 8).tick
    sleep 0.25
  end
end
