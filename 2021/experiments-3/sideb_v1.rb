require "/home/diego/Projects/sonic-pi/petal/petal.rb"

cps 0.9

d1 "bd ~ ~ ~", amp: 0.6
#d2 "hh hh hh ~hh"
#d3 "~ sn ~ sn", n: 1, amp: 0.3
d4 "~"

d9 :silence
d7 :silence

# d5 "dork2(5,16,2)", n: "irand 4", rate: 4

d5 "future(5,16)" , slow: 2, n: "irand 4", amp: 0.6 # rate: 'rand 1 2'

# d7 "house(3,16,2)" , slow: 2, n: 1, rate: 'rand 1 0.8, 1.2, 0.6'

# d6 "jungbass(1,16,2)" , slow: 2, n: "irand 6" # , rate: 'rand 1 0.8, 1.2, 0.6'

#d9 "koy(1,16,2)" , slow: 4, rate: "1"

# d9 "kurt(5,16,2)" , slow: 2, n: "irand 6"  , rate: 'rand 1 -0.8, 1.2, -0.6'

# d9 "less(5,16,2)" , slow: 1, n: "irand 0, 1, 1, 2, 1," # , rate: 'rand 1 0.8, 1.2, 0.6'

live_loop :ble, sync: :d0 do
  use_bpm get_bpm
  use_synth :pluck
  with_fx :reverb, room: 1, mix: 0.4 do
    with_fx :tremolo do
      with_fx :distortion do
        play (chord :c2, '5'), amp: 0.6
        sleep 4
        play (chord :c2, :minor), amp: 0.6
        sleep 4
      end
    end
  end
end

live_loop :bla, sync: :ble do
  use_bpm get_bpm
  use_random_seed 412341
  32.times do
    #play :c3, amp: 0.6, release: 0.5 if (spread 7, 16, rotate: 14).tick
    play (scale :c3, :minor_pentatonic).choose, amp: 0.2, pan: 0.8 if (spread 5,16, rotate: 3).tick
    sleep 0.125
  end
end

b_rel = 0.3
b_amp = 0.3
live_loop :baixo, sync: :ble do
  use_bpm get_bpm
  use_synth :fm
  play :c3, release: b_rel, amp: b_amp
  sleep 0.125
  play :c3, release: b_rel, amp: b_amp
  sleep 0.125
  sleep 0.25
  sleep 0.25
  play :eb3, release: b_rel, amp: b_amp
  sleep 0.25
  sleep 1
  play :g3, release: b_rel, amp: b_amp
  sleep 0.125
  play :g3, release: b_rel, amp: b_amp
  sleep 0.125
  sleep 0.5
  play :f3, release: b_rel, amp: b_amp
  sleep 0.25
  sleep 1
end
