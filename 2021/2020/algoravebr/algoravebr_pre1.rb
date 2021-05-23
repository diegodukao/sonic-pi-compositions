# Welcome to Sonic Pi

require "~/Projects/sonic-pi/petal-1.3.0/petal.rb"

cps 0.5

d1 "bd ~ bd [~ bd]"

d2 "hh [~ hh] hh hh"

d3 "~ sn:1 [~ ~ sn:1/2 sn:1/2] ~", amp: 0.5

# d3 "~ sn:1/2 sn:1 ~", amp: 0.5

d4 "tech(11,16)", slow: 2, rate: 1, amp: 1, n: "irand 64"

d5 "mp3:2(5,16)", amp: 0.1

d6 "ades4(7,16)", n: "irand 10", amp: 0.2

# d5 "sf(7,16,1)", slow: 2, rate: 1, amp: 0.5, n: "irand 64", pan: "rand -0.5 0.5"

live_audio :foo, stereo: true

live_loop :harmonia, sync: :d0 do
  stop
  use_bpm get_bpm
  use_synth :piano
  play (chord_degree 1, :c3, :minor)
  sleep 1
  play (chord_degree 1, :c3, :minor)
  sleep 1
  play (chord_degree 3, :c3, :minor)
  sleep 1
  play (chord_degree 4, :c3, :minor)
  sleep 1
end

bass_dur = (ring 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 1, 0, 1, 0)

bass_dur = (ring 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 1, 1, 0)

live_loop :bass, sync: :d0 do
  stop
  use_synth :fm
  play (scale :c3, :minor_pentatonic).choose, sustain: 0.1, amp: 0.3 * bass_dur.tick, release: 0.2
  sleep 0.125
end


##| d1 "bd sn:1"
##| d2 "hh [hh hh] [hh ~] hh"
##| d3 "arpy"

## d4 "arpy*8", n: "irand 30"

# d1 "arpy(9,16,1)", n: 'irand 8 12'

# d1 "bd sn:1 ~ sn/2 ~ bd/2"

##| d3 "trump/4 ~ ~ trump/4", speed: "1, -0.5", n: "-2"

##| d4 "trump/4 ~ ~ ~", n: "4"

##| d5 "trump/4 ~ ~ ~", n: "2"

##| d6 "bass3 ~ [~ bass3] ~", n: "1", amp: 1, speed: "1 -0.5"

##| d1 "bd ~ sn:1 [~ bd]"

##| d2 "hh hh [~ hh] hh"
