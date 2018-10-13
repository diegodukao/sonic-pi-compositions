tonic = :g2
type = :minor
prog = (ring 1, 3, 2, 6)

live_loop :chords do
  use_bpm 60
  use_synth :piano
  c_chord = prog.tick
  play chord_degree(c_chord, tonic, type, 3), sustain: 1
  sleep 1
  play chord_degree(c_chord, tonic, type, 3), sustain: 1
  sleep 1
end

live_loop :hh do
  sync :chords
  sample :drum_cymbal_closed
  sleep 0.25
  sample :drum_cymbal_closed, amp: 0.5
  sleep 0.25
  sample :drum_cymbal_closed
  sleep 0.25
  sample :drum_cymbal_closed, amp: 0.5
  sleep 0.25
  sample :drum_cymbal_closed
  sleep 0.25
  sample :drum_cymbal_closed, amp: 0.5
  sleep 0.25
  sample :drum_cymbal_closed
  sleep 0.25
  sample :drum_cymbal_closed, amp: 0.5
end