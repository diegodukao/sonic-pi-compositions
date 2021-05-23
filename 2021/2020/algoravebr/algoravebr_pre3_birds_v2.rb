require "~/Projects/sonic-pi/petal-1.3.0/petal.rb"

cps 0.5

d1 "bd ~ bd [~ bd]", amp: 0.5

d2 "hh*4"

d3 "[[~ sn/2] ~] [sn bd/2] ~ sn", n: 1, amp: 0.5

# d4 "tech(11,16)", slow: 2, n: "irand 64"

d5 "birds3(11,16)", n: "irand 19", amp: 1

d6 "birds:1/4 ~ birds/8 ~"



root = :a3

live_loop :chords, sync: :d0 do
  use_bpm get_bpm
  use_synth :piano
  play (chord_degree 1, root, :minor)
  sleep 0.5
  play (chord_degree 1, root, :minor)
  sleep 1
  play (chord_degree 3, root, :minor)
  sleep 0.5
  play (chord_degree 2, root, :minor)
  sleep 1
  play (chord_degree 6, root, :minor)
  sleep 0.5
  play (chord_degree 5, root, :minor)
  sleep 0.5
end

bass_dur = (ring 1,0,0,0,0,0,0,0,1,0,0,0,0,0,1,0)

live_audio :keys, stereo: true

live_loop :bass, sync: :d0 do
  use_synth :fm
  play (scale root, :minor_pentatonic).choose,
    sustain: 0.1, amp: 0.3 * bass_dur.tick, release: 0.2
  sleep 0.125
end