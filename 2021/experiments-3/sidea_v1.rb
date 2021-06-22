require "/home/diego/Projects/sonic-pi/petal/petal.rb"

cps 0.5

d1 "~ ~ ~ ~"


# E, Em
# C, C#m
# Ddim, Baug (nao)
# A, Am, A#dim

single_amp = 0
isStart = true
if isStart then
  curr_chord = (chord :e3, :minor7)
end
live_loop :chords, sync: :d0 do
  use_bpm get_bpm
  use_synth :piano
  
  play 55 - 12, amp: single_amp
  curr_chord = (chord :e3, :minor7)
  play curr_chord
  sleep 1
  
  play 56 - 12, amp: single_amp
  curr_chord = (chord :cs3, :minor7, invert: 1)
  play curr_chord
  sleep 0.5
  
  play 55 - 12, amp: single_amp
  curr_chord = (chord :c3, '7', invert: 1)
  play curr_chord
  sleep 0.5
  
  play 53 - 12, amp: single_amp
  curr_chord = (chord :f2, 'major7', invert: 3)
  play curr_chord
  sleep 1
  
  #curr_chord = (chord :as1, 'm7b5', invert: 2)
  play 58 - 12, amp: single_amp
  curr_chord = (chord :as2, :diminished7, invert: 2)
  play curr_chord
  sleep 0.5
  
  play 57 - 12, amp: single_amp
  curr_chord = (chord :a2, :minor7, invert: 2)
  play curr_chord
  sleep 0.5
end

arp_amp = 0.1
live_loop :arpeggio, sync: :chords do
  use_bpm get_bpm
  use_synth :pluck
  play 55, amp: arp_amp# , pan: arp_amp
  sleep 1
  
  #play 56, amp: arp_amp
  sleep 0.5
  
  #play 55, amp: arp_amp
  sleep 0.5
  
  #play 53, amp: arp_amp
  sleep 1
  
  play 58, amp: arp_amp
  sleep 0.5
  
  play 57, amp: arp_amp
  sleep 0.5
end




