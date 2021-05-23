require "~/Projects/sonic-pi/petal-1.3.0/petal.rb"
cps 1

pat = 1

d1 "hh*2",  amp: "0.5 0.8"

d2 "sn [~sn] [sn/2 sn/3] sn", amp: "0.2 0.1 0.4 0.3"
d2 :silence

d3 "bd ~ [~ bd/2] [bd/2 ~]", slow: 2, amp: 0.8

d4 "~ [~ sn] ~ sn", n: 1, slow: 2, amp: 0.5

live_loop :lead, sync: :d0 do
  vol = 0.8
  use_bpm get_bpm
  use_synth :pluck
  use_random_seed 20
  # use_random_seed 2000
  32.times do
    play (scale :a4, :minor_pentatonic).choose, amp: vol, release: 0.8 if (spread (ring 2, 3, 2).tick, 8).look
    sleep 0.25
  end
  use_random_seed 300
  # use_random_seed 3000
  16.times do
    play (scale :c5, :minor_pentatonic).choose, amp: vol, release: 0.8 if (spread (ring 2, 3, 3).tick, 8).look
    sleep 0.25
  end
  16.times do
    play (scale :a4, :minor).choose, amp: vol, release: 0.8 if (spread (ring 2, 3, 3).tick, 8).look
    sleep 0.25
  end
end

c_chord = (chord :a2, :minor)


live_loop :chords, sync: :d0 do
  use_bpm get_bpm
  use_synth :piano
  if pat == 1 then
    # c_chord = (chord :d3, :minor)
    play (chord :d3, :minor), sustain: 0.7
    sleep 2
    # c_chord = (chord :d3, :dim)
    play (chord :d3, :dim), sustain: 0.7
    sleep 2
    # c_chord = (chord :d3, :minor)
    play (chord :d3, :minor), sustain: 0.7
    sleep 2
    # c_chord = (chord :e2, '7')
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
