# drum patterns awesome spreadsheet
# https://docs.google.com/spreadsheets/d/19_3BxUMy3uy1Gb0V8Wc-TcG7q16Amfn6e8QVw4-HuD0/

live_loop :cold_sweat do
  stop
  
  use_bpm 100
  sample :drum_cymbal_soft
  sample :drum_bass_hard
  sleep 0.25
  
  sleep 0.25
  
  sample :drum_cymbal_soft
  sample :drum_bass_hard
  sleep 0.25
  
  sleep 0.25
  
  sample :drum_cymbal_soft
  sample :drum_snare_hard
  sleep 0.25
  
  sleep 0.25
  
  sample :drum_cymbal_soft
  sleep 0.25
  
  sample :drum_snare_hard
  sleep 0.25
end

live_loop :impeach_the_president do
  
  use_bpm 90
  
  sample :drum_cymbal_closed
  sample :drum_bass_hard
  sleep 0.25
  
  sleep 0.25
  
  sample :drum_cymbal_closed
  sleep 0.25
  
  sleep 0.25
  
  sample :drum_cymbal_closed
  sample :drum_snare_hard
  sleep 0.25
  
  sleep 0.25
  
  sample :drum_cymbal_closed
  sleep 0.25
  
  sample :drum_cymbal_closed
  sample :drum_bass_hard
  sleep 0.25
  
  sample :drum_cymbal_closed
  sample :drum_bass_hard
  sleep 0.25
  
  
  sleep 0.25
  
  sample :drum_cymbal_open, sustain: 0.42
  sleep 0.25
  
  sleep 0.25
  
  sample :drum_cymbal_pedal, amp: 1.5
  sample :drum_snare_hard
  sleep 0.25
  
  sleep 0.25
  
  sample :drum_cymbal_closed
  sample :drum_bass_hard
  sleep 0.25
  
  sleep 0.25
end