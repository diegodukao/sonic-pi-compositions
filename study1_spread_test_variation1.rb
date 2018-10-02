live_loop :maestro do
  use_bpm 40
  cue :tick, value: tick - 1
  sleep 0.125
end

live_loop :drums do
  global_tick = sync :tick
  gtick = global_tick[:value]
  
  sample :drum_cymbal_closed, amp: 1.5 if (spread 3, 4)[gtick]
  #sample :drum_bass_hard, amp: 1.5 if (spread 4, 7)[gtick]
  sample :drum_bass_hard, amp: 1 if (ring true, true, false, false, false, false, true, false)[gtick]
  sample :drum_snare_hard, amp: 0.8 if (spread 1, 8)[gtick + 4]
  #sample :bd_haus, amp: 2 if (spread 1, 4).gtick
end

live_loop :bass do
  global_tick = sync :tick
  gtick = global_tick[:value]
  
  use_synth :fm
  play [:c3, :d3].choose, release: 0.15, amp: 0.8 if (spread 4, 7)[gtick]
end

chord_plays = 0
live_loop :synth do
  stop
  global_tick = sync :tick
  gtick = global_tick[:value]
  
  use_synth :dsaw
  if (spread 1, 32)[gtick] then
    chord_plays += 1
    if chord_plays % 4 == 0 then
      play (chord :d3, :minor7), release: 2
    else
      play (chord :c3, :minor7), release: 2
    end
  end
end