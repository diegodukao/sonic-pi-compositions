# OLAR

require "~/Projects/sonic-pi/petal-1.3.0/petal.rb"
cps 0.5

pat = 3
play_chord = true
play_bass = true
play_drums = true
play_snare = true
play_riff = true
bass = 0

final = true

if final == true then
  play_bass = false
end

if pat == 3 then
  play_riff = false
end

if pat == 1 or pat == 3 then
  chord1 = 1
  chord2 = 2
else
  chord1 = 5
  chord2 = 4
end

if pat == 1 then
  d1 "bd*4", amp: 0.7
  d2 "hh(11,16)",  amp: "0.8 0.6 0.5 0.7"
  if play_drums then
    d3 "sn(3,8) a", amp: 0.6, pan: -0.2
    d4 "a sn(3,8,3)", amp: 0.6, pan: 0.2
    if play_snare then
      d5 "~ sn ~ sn", amp: 0.4, n: 1
    end
  else
    d3 :silence
    d4 :silence
    d5 :silence
  end
else
  d1 "bd bd/2 [~ bd] [~ bd]", amp: 0.7
  d2 "hh hh hh [~ hh]",  amp: "0.8 0.6 0.5 0.7"
  d3 "sn(1,8) a", amp: 0.6, pan: -0.2
  d4 "a sn(1,8,3)", amp: 0.6, pan: 0.2
  d5 "[sn [~ sn]] [sn/2 [~ sn]] sn/3 [~ sn]", amp: 0.3, n: 1
end


live_loop :bass, sync: :d0 do
  if not play_bass then
    stop
  end
  
  use_synth :fm
  if pat == 1 or bass == 1 then
    use_random_seed 100
    32.times do
      play (chord_degree chord1, :e2, :minor).choose,
        sustain: 0.1,
        amp: 0.32,
        release: 0.2 if (spread 7, 16).tick
      sleep 0.125
    end
    
    use_random_seed 100
    32.times do
      play (chord_degree chord2, :e2, :minor).choose,
        sustain: 0.1,
        amp: 0.32,
        release: 0.2 if (spread 7, 16).tick
      sleep 0.125
    end
  else
    use_random_seed 1000
    32.times do
      play (chord_degree chord1, :e2, :minor).choose,
        sustain: 0.1,
        amp: 0.32,
        release: 0.2 if (spread 3, 8).tick
      sleep 0.125
    end
    
    use_random_seed 3000
    32.times do
      play (chord_degree chord2, :e2, :minor).choose,
        sustain: 0.1,
        amp: 0.32,
        release: 0.2 if (spread 3, 16).choose
      sleep 0.125
    end
  end
end

live_loop :riff, sync: :d0 do
  if not play_riff then
    stop
  end
  
  use_synth :chipbass
  use_random_seed 100
  if pat == 1 or pat == 3 then
    32.times do
      play (scale :e3, :minor_pentatonic, num_octaves: 1).choose,
        release: 0.4,
        pan: -0.3,
        amp: 0.25 if (spread (ring 11, 7, 5, 2).choose, 16).choose
      sleep 0.125
    end
    
    32.times do
      play (chord_degree 2, :e3, :minor, 5).choose,
        release: 0.7,
        pan: 0.3,
        amp: 0.25 if (spread (ring 11, 7, 5, 2).choose, 16).choose
      sleep 0.125
    end
  else
    32.times do
      play (chord_degree 5, :e3, :minor, 5).choose,
        release: 0.4,
        pan: -0.3,
        amp: 0.25 if (spread (ring 7, 5, 2).choose, 16).choose
      sleep 0.125
    end
    
    32.times do
      play (chord_degree 4, :e3, :minor, 5).choose,
        release: 0.7,
        pan: 0.3,
        amp: 0.25 if (spread (ring 7, 5, 2).choose, 16).choose
      sleep 0.125
    end
  end
end

root = :e3

live_loop :chords, sync: :d0 do
  if not play_chord then
    stop
  end
  
  use_synth :hollow
  
  with_fx :normaliser, mix: 0.3, level: 0.6  do
    with_fx :distortion do
      if pat == 1 or pat == 3 then
        play (chord_degree 1, root, :minor, 5)
        sleep 4
        play (chord_degree 2, root, :minor, 5)
        sleep 4
      elsif pat == 2 then
        play (chord_degree 5, root, :minor, 5)
        sleep 4
        play (chord_degree 4, root, :minor, 5)
        sleep 4
      end
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
