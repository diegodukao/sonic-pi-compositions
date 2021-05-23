# OLAR

require "~/Projects/sonic-pi/petal-1.3.0/petal.rb"
cps 0.5

d1 "bd*4", amp: 0.7

d2 "hh(11,16)",  amp: [0.8, 0.5, 0.9, 0.7]

d3 "sn(3,8) a", amp: 0.6, pan: -0.2

d4 "a sn(3,8,3)", amp: 0.6, pan: 0.2


live_loop :bass, sync: :d0 do
  use_synth :fm
  play (chord :e2, :minor).choose, sustain: 0.1, amp: 0.6, release: 0.2 if (spread 3, 16).tick
  sleep 0.125
end

live_loop :riff, sync: :d0 do
  use_synth :pluck
  play (scale :e4, :minor_pentatonic, num_octaves: 1).choose, amp: 0.5 if (spread (ring 11, 7, 5, 2).choose, 16).choose
  sleep 0.125
end

root = :e3

live_loop :chords, sync: :d0 do
  use_synth :hollow
  
  with_fx :normaliser, mix: 0.3  do
    with_fx :distortion do
      play (chord_degree 1, root, :minor, 5), amp: 1.2
      sleep 4
      play (chord_degree 2, root, :minor, 5)
      sleep 4
    end
  end
end

##| root = :a3

##| live_loop :chords, sync: :d0 do
##|   use_bpm get_bpm
##|   use_synth :piano
##|   play (chord_degree 1, root, :minor)
##|   sleep 0.5
##|   play (chord_degree 1, root, :minor)
##|   sleep 1
##|   play (chord_degree 3, root, :minor)
##|   sleep 0.5
##|   play (chord_degree 2, root, :minor)
##|   sleep 1
##|   play (chord_degree 6, root, :minor)
##|   sleep 0.5
##|   play (chord_degree 5, root, :minor)
##|   sleep 0.5
##| end

##| bass_dur = (ring 1,0,0,0,0,0,1,0,1,0,0,0,1,0,1,0)

##| live_loop :bass, sync: :d0 do
##|   stop
##|   use_synth :fm
##|   play (scale root, :minor_pentatonic).choose, sustain: 0.1,
##|     amp: 0.3 *bass_dur.tick, release: 0.2, oct: 2
##|   sleep 0.125
##| end


##| d3 "[[~ sn/2] ~ ] [sn bd/2]", n: 1, amp: 0.5

##| d4 "tech(11,16)", slow: 2, n: "irand 64"

##| d5 "birds3(11,16)", n: "irand 19"

##| d7 "ades4(7,16)", n: "irand 10", amp: 0.2

##| d6 "birds:1/4 ~ birds/8 ~"



##| live_audio :keys, stereo: true
