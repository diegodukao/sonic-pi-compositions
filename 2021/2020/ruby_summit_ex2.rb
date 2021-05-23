# @diegodukao
#
#  dó ré mi fá sol lá si
#  c  d  e  f  g   a  b
#  1  2  3  4  5   6  7

# samples

live_loop :bateria do
  sample :drum_bass_hard
  sleep 0.5
  sample :drum_snare_hard
  sleep 0.5
end

live_loop :hh do
  sample :drum_cymbal_closed
  sleep 0.25
end

live_loop :harmonia do
  play (chord_degree 1, :c4, :minor)
  sleep 1
  play (chord_degree 3, :c4, :minor)
  sleep 1
  play (chord_degree 2, :c4, :minor)
  sleep 1
  play (chord_degree 4, :c4, :minor)
  sleep 1
end

live_loop :melodia do
  
  use_synth :piano
  play (scale :c4, :blues_minor).choose, amp: 0.4
  sleep 0.25
end

























##| live_loop :bateria do
##|   sample :drum_bass_soft
##|   sleep 0.5
##|   sample :drum_snare_soft
##|   sleep 0.5
##| end

##| live_loop :hh do
##|   sample :drum_cymbal_closed, amp: 0.3
##|   sleep 0.25
##| end

##| live_loop :melodia do
##|   use_synth :hollow
##|   play (scale :c3, :minor_pentatonic).choose, amp: 0.4
##|   sleep 0.25
##| end

##| live_loop :harmonia do
##|   use_synth :piano
##|   play (chord_degree 1, :c3, :minor)
##|   sleep 1
##|   play (chord_degree 1, :c3, :minor)
##|   sleep 1
##|   play (chord_degree 3, :c3, :minor)
##|   sleep 1
##|   play (chord_degree 4, :c3, :minor)
##|   sleep 1
##| end