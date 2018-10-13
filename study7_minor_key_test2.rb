use_real_time

live_audio :bass, amp: 2

key = :e3
type = :minor
prog = (ring 1, 3, 1, 5)
use_bpm 70

live_loop :chords do
  use_synth :piano
  degree = prog.tick
  play (chord_degree degree, key, type),
    sustain: 2
  sleep 2
end

live_loop :drums do
  sync :chords
  sample :drum_bass_hard
  sleep 0.25
  sample :drum_bass_hard
  sleep 0.25
  sample :drum_snare_hard
  sleep 0.25
  sample :drum_bass_hard
  sleep 0.25
  #sample :drum_bass_hard
  sleep 0.25
  #sample :drum_bass_hard
  sleep 0.25
  sample :drum_snare_hard
  sleep 0.25
  sample :drum_bass_hard
end

cymbal_amp = (ring 1, 0.7, 0.7, 0.7)
live_loop :cymbal do
  sync :chords
  7.times do
    sample :drum_cymbal_closed,
      amp: cymbal_amp.tick
    sleep 0.25
  end
  sample :drum_cymbal_closed,
    amp: cymbal_amp.tick
end