bpm = 80

live_loop :prog do
  use_synth :prophet
  use_bpm bpm
  play (chord_degree, 1, :c3, :major, 3), sustain: 1.5
  sleep 2
  play (chord_degree, 6, :c3, :major, 3), sustain: 1.5
  sleep 2
  play (chord_degree, 5, :c3, :major, 3), sustain: 1.5
  sleep 2
  play (chord_degree, 5, :c3, :major, 3), sustain: 1.5
  sleep 2
end

live_loop :drums do
  sync :prog
  use_bpm bpm
  3.times do
    sample :drum_bass_hard
    sleep 0.75
    sample :drum_bass_hard
    sleep 0.25
    sample :drum_snare_hard
    sleep 0.5
    sample :drum_bass_hard
    sleep 0.5
  end
  sample :drum_bass_hard
  sleep 1
  sample :drum_snare_hard
end

live_loop :hh do
  sync :prog
  use_bpm bpm
  7.times do
    sample :drum_cymbal_closed
    sleep 0.5
    sample :drum_cymbal_closed, amp: 0.5
    sleep 0.5
  end
  sample :drum_cymbal_closed
  sleep 0.5
  sample :drum_cymbal_closed, amp: 0.5
end