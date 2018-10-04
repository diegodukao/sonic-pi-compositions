use_synth :piano
use_bpm 60

live_loop :maestro do
  sleep 0.1
end

live_loop :r1 do
  sync :maestro
  
  density 6 do
    # sample :tabla_tas3
    play (chord :c3, :minor7).choose
    sleep 1
  end
end

live_loop :r2 do
  sync :maestro
  
  density 4 do
    play (chord :c5, :minor7).choose
    #stop
    # sample :tabla_dhec
    sleep 1
  end
end