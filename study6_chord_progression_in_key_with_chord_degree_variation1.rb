bpm = 120

define :play_ch_key do |degree|
  return (chord_degree degree, :g3, :major, 3)
end

live_loop :prog do
  use_synth :prophet
  use_bpm bpm
  play (ch_key 1), sustain: 1.5
  sleep 2
  play (ch_key 3), sustain: 0.8
  sleep 1
  play (ch_key 2), sustain: 0.8
  sleep 1
  play (ch_key 6), sustain: 1.5
  sleep 2
  play (ch_key 4), sustain: 0.8
  sleep 1
  play (ch_key 5), sustain: 0.8
  sleep 1
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