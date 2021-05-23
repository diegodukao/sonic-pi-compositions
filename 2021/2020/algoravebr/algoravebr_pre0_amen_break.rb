use_bpm 60

live_loop :clock do
  sleep 0.25
end

live_loop :amen do
  sync :clock
  sample :loop_amen, beat_stretch: 4
  sleep 4
  sample :loop_amen_full, beat_stretch: 16, start: 0.75, amp: 0.45
  sleep 3.9
end

notes = (scale :c3, :minor_pentatonic).shuffle()
sleeps = (ring 1, 1, 1, 1, 1, 1, 2)

live_loop :chords do
  stop
  sync :clock
  use_synth :piano
  play (chord :c4, :minor7)
  sleep 4
  play (chord :g4, :minor7)
  sleep 4 -0.1
end

live_loop :bass do
  sync :clock
  use_synth :fm
  play notes.tick, amp: 0.2 if (spread 3,16).tick
end