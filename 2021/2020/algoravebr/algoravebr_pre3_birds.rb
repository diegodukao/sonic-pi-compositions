# Welcome to Sonic Pi

require "~/Projects/sonic-pi/petal-1.3.0/petal.rb"

cps 0.5



d1 "bd ~ bd [~ bd]", amp: 0.5

d2 "hh*4"

d3 "[[~ sn/2] ~] [sn bd/2] ~ sn", n: 1, amp: 0.5

d5 "birds:1/4 ~ birds/8 ~"

d6 "birds3(11,16)", n: "irand 19"

live_audio :foo, stereo: true
