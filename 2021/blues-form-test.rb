require "/home/diego/Projects/sonic-pi/petal/petal.rb"

cps 0.9

d1 "~ bd ~ bd"
#d2 "hh hh hh hh"
#d3 "~ sn ~ sn", n: 1, amp: 0.3
d4 "~"

live_loop :chords, sync: :d0 do
  use_bpm get_bpm
  use_synth :piano
  16.times do
    sleep 0.5
    play (chord :g3, '7'), amp: 0.5
  end
  8.times do
    sleep 0.5
    play (chord :c4, '7'), amp: 0.5
  end
  8.times do
    sleep 0.5
    play (chord :g3, '7'), amp: 0.5
  end
  4.times do
    sleep 0.5
    play (chord :d4, '7'), amp: 0.5
  end
  4.times do
    sleep 0.5
    play (chord :c4, '7'), amp: 0.5
  end
  8.times do
    sleep 0.5
    play (chord :g3, '7'), amp: 0.5
  end
end

live_loop :hh, sync: :d0 do
  use_bpm get_bpm
  sample :drum_cymbal_closed
  sleep 0.25
end