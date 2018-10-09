# Rubber Dub
# Coded by: KniKnoo. https://gist.github.com/kniknoo/9bba301ab048cbfa350777d39a6098f6
# Remixed by: Just Eli... https://soundcloud.com/just-eli-139271289/

use_bpm 75
use_debug false
use_random_seed 98736

tracker = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

n = (ring :r, :r, :d2, :d3, :f3, :r, :d1, :f2)

fade_in = (line 0, 2, inclusive: true, steps: 40).ramp
fade_in1 = (line 0, 3, inclusive: true, steps: 15).ramp
fade_out = (line 3, 1, inclusive: true, steps: 40).ramp
fade_out1 = (line 2, 0.5, inclusive: true, steps: 15).ramp
fade_out2 = (line 3, 1.5, inclusive: true, steps: 40).ramp
fade_through = fade_in+fade_out
fade_through1 = fade_in+fade_out1
fade_through2 = fade_in+fade_out2

dchord = chord(:g4, :minor, num_octaves: 3)
synth_cutoffs = range(60, 100, 0.5).mirror
synth_rhythm = (ring 1.5, 1.5, 1)
synth_transpositions = (stretch 0, 36) + (stretch -12, 6) + (stretch 12, 6)
synth_phases = (stretch 0.75, 15) + [0.25]
synth_pans = (ring -0.5, 0.5)
synth_volume = 1

dubpad_cutoffs = range(70, 100, 5).mirror
dubpad_phases = (ring 8, 8, 8, 0.5)
dubpad_mixes = (ring 0.5, 0.5, 0.5, 0)
dchord = chord(:g4, :minor, num_octaves: 3)

# Repeat a loop.
define :repeat_loop do |i|
  tracker[i] = 2
end


define :start_loop do |i|
  tracker[i] = 1
end

define :stop_loop do |i|
  tracker[i] = 0
end

define :stop_all do
  tracker[0] = 0
  tracker[1] = 0
  tracker[2] = 0
  tracker[3] = 0
  tracker[4] = 0
  tracker[5] = 0
  tracker[6] = 0
  tracker[7] = 0
  tracker[8] = 0
  tracker[9] = 0
  tracker[10] = 0
  tracker[11] = 0
  
end


define :sn_roll do #|length|
  in_thread do
    sn_amp = 0.05
    4.times do
      sample :sn_dolf, amp: sn_amp, sustain: 0, release: 0.125
      sleep 0.0625
      sn_amp += 0.07
    end
  end
end

define :dubpad do |ch, amp|
  with_fx :echo, amp: amp, mix: dubpad_mixes.look,
  phase: 1.5, decay: 2 do
    with_fx :reverb, room: 0.8 do
      with_fx :ixi_techno, phase: dubpad_phases.tick, cutoff_min: 70 do
        with_synth :tb303 do
          with_synth_defaults attack: 0.1, release: 8,
          cutoff: dubpad_cutoffs.look, res: 0.5 do
            play_chord ch
            play_chord ch.map { |n| n + 0.3 } # Detune chord
          end
        end
      end
    end
  end
end

live_loop :bar do
  sleep 1
end

live_loop :beats do
  sync :bar
  sleep 4
end

live_loop :kick do
  if tracker[0]>0 then
    sample :drum_heavy_kick
    sleep 1
  else
    sleep 1
  end
end

with_fx :reverb, mix: 0.35, room: 0.1, damp: 0.9 do
  live_loop :snare do
    if tracker[1]>0 then
      use_sample_defaults sustain: 0, release: 0.25
      sleep 0.75
      sn_roll if rand > 0.8
      sleep 0.25
      sample :sn_dolf
      del = [0.25, 0.5, 0.75].choose
      cue :bass
      sleep del
      sample :drum_snare_soft, amp: 0.7 if rand > 0.5
      sleep 1 - del
    else
      sleep 1
    end
  end
end


live_loop :hats do
  if tracker[2]>0 then
    sample :drum_cymbal_closed, sustain: 0.125, amp: 0.3 if rand > 0.9
    sleep 0.5
    sample :drum_cymbal_closed, sustain: 0.125, amp: 0.5
    sleep 0.5
  else
    sleep 1
  end
end

live_loop :hats2 do
  if tracker[2]>0 then
    sample [:elec_tick, :elec_blip].choose, sustain: 0.006, amp: 0.8, hpf: 100 if rand > 0.3
    sleep 0.25
  else
    sleep 1
  end
end

live_loop :bass do
  if tracker[3]>0 then
    if rand(1) > 0.75
      n = (ring :r, :r, :d2, :d3, :f3, :r, :d1, :f2)
    else
      n=n.shuffle
    end
    use_synth :fm
    use_transpose +12
    use_synth_defaults release: 0.125 + rrand(0, 0.2), amp: 0.25, pan: rrand(-0.5, 0.5)
    use_transpose +12
    play n.look, cutoff: rrand(30, 130)
    sleep 0.25
    tick
  else
    sleep 1
  end
end

with_fx :gverb, mix: 0.1, room: 20, amp: 0.6 do
  live_loop :skank do
    if tracker[4]>0 then
      with_fx :bitcrusher, mix: 0.7, amp: 0.5, bits: 8, sample_rate: 3136 do
        use_synth :dpulse
        use_synth_defaults release: 0.125
        sleep 0.5
        if rand > 0.8
          with_fx :echo, phase: [0.25, 0.333, 0.375, 0.75].choose, decay: 4, mix: 0.5 do
            play (chord, :g4, :m, invert: -1)
          end
        else
          play (chord, :g4, :m, invert: -1)
        end
        3.times do
          sleep 1
          play (chord, :g4, :m, invert: -1)
        end
        sleep 0.5
      end
      
    else
      sleep 1
    end
  end
end

with_fx :echo, mix: 0.8, phase: 0.75, decay: 4 do
  with_fx :flanger, stereo_invert_wave: 1, feedback: 0.5, amp: 0.5 do
    
    live_loop :lead do
      if tracker[5]== 1 then
        with_fx :flanger, stereo_invert_wave: 1, feedback: 0.5, amp: 0.5 do
          sync :bass
          sync :bass
          use_synth :mod_beep
          rps = (range 6, 9).choose
          use_synth_defaults res: 0.9, attack: 0.25, noise: 2, release: 2 , cutoff: 100, amp: 0.2,
            note_slide: 0.02, sustain: 0.25 * rps / 1.25, decay: 0.25 * rps / 1.25, sustain_level: 0.8,
            mod_range: 0.5, mod_phase: 0.125, mod_wave: 2, pulse_width: 0.2
          mynote = (note_range, :g4, :g6, pitches: (scale, :g, :minor_pentatonic))
          play mynote.reverse.tick
          rps.times do
            control note: mynote.tick - [0, 12].choose
            sleep [0.25, 0.25, 0.5, 0.5, 0.75].choose
          end
          tracker[5] = 0
          sleep 2.5
        end
      else
        sleep 1
      end
    end
    
    if tracker[5] > 0 then
      with_fx :flanger, stereo_invert_wave: 1, feedback: 0.5, amp: 0.5 do
        sync :bass
        sync :bass
        use_synth :mod_beep
        rps = (range 6, 9).choose
        use_synth_defaults res: 0.9, attack: 0.25, noise: 2, release: 2 , cutoff: 100, amp: 0.2,
          note_slide: 0.02, sustain: 0.25 * rps / 1.25, decay: 0.25 * rps / 1.25, sustain_level: 0.8,
          mod_range: 0.5, mod_phase: 0.125, mod_wave: 2, pulse_width: 0.2
        mynote = (note_range, :g4, :g6, pitches: (scale, :g, :minor_pentatonic))
        play mynote.reverse.tick
        rps.times do
          control note: mynote.tick - [0, 12].choose
          sleep [0.25, 0.25, 0.5, 0.5, 0.75].choose
        end
        sleep 2.5
      end
    else
      sleep 1
    end
    
  end
end

live_loop :boom do
  sync :kick
  if tracker[6] == 1 then
    with_fx :reverb, room: 1 do
      sample :bd_boom, amp: 3
    end
    sample :drum_tom_hi_hard, amp: 3, rate: 0.2
    tracker[6]=0
    sleep 4
  end
  
  if tracker[6]>0 then
    with_fx :reverb, room: 1 do
      sample :bd_boom, amp: 1
    end
    sample :drum_tom_hi_hard, amp: 3, rate: 0.2
    sleep 4
  else
    sleep 1
  end
end

live_loop :alien_woosh do
  sync :kick
  if tracker[7] == 1 then
    with_fx :reverb, room: 1 do
      sample :ambi_dark_woosh
      tracker[7]=0
      sleep 4
    end
  end
  
  if tracker[7]>0 then
    with_fx :reverb, room: 1 do
      sample :ambi_dark_woosh
      sleep 4
    end
  else
    sleep 1
  end
end

live_loop :zawa do
  sync :kick
  if tracker[8] == 1 then
    with_fx :reverb, room: 1 do
      with_fx :slicer do
        with_fx :pitch_shift, pitch: -12 do
          use_synth :zawa
          
          [3,5,6,7,8,10].choose.times do |i|
            play chord(:e3, :minor).choose, release: [0.2, 0.4, 0.6, 0.8, 1].choose, pan: [1,0,-1].choose, cutoff: rrand(80, 110)
            tracker[8]=0
            sleep [0.25,0.5,0.75].choose
          end
        end
      end
    end
  end
end

live_loop :pad do
  sync :kick
  if tracker[9] == 1 then
    dubpad dchord, 0.125
    tracker[9] = 0
    sleep 16
  end
  if tracker[9] > 0 then
    dubpad dchord, 0.125
    sleep 16
  end
  sleep 0.1
end

live_loop :synth do
  sync :kick
  if tracker[10] == 1 then
    ch = invert_chord(dchord, rand_i(3))
    sleep synth_rhythm.tick
    # get random values for 1-shot synth.
    tick_advance = rrand_i(0,10)
    tick_advance.times do
      tick
    end
    with_fx :echo, amp: synth_volume, mix: 0.3,
    decay: 8, phase: synth_phases.look do
      with_fx :pan, pan: synth_pans.look do
        with_fx :reverb, room: 0.7, damp: 0.8 do
          with_synth_defaults attack: 0.05, release: 0.3 do
            with_transpose synth_transpositions.look do
              with_synth :sine do
                play_chord ch
              end
              cutoff = synth_cutoffs.look
              with_fx :ixi_techno, cutoff_min: cutoff,
              cutoff_max: cutoff - 30, phase: 1, res: 0.3 do
                with_synth :dsaw do
                  play_chord ch, attack: 0.1
                  tracker[10] = 0
                end
              end
            end
          end
        end
      end
    end
  end
  
  if tracker[10] > 0 then
    ch = invert_chord(dchord, rand_i(3))
    sleep synth_rhythm.tick
    with_fx :echo, amp: synth_volume, mix: 0.3,
    decay: 8, phase: synth_phases.look do
      with_fx :pan, pan: synth_pans.look do
        with_fx :reverb, room: 0.7, damp: 0.8 do
          with_synth_defaults attack: 0.05, release: 0.3 do
            with_transpose synth_transpositions.look do
              with_synth :sine do
                play_chord ch
              end
              cutoff = synth_cutoffs.look
              with_fx :ixi_techno, cutoff_min: cutoff,
              cutoff_max: cutoff - 30, phase: 1, res: 0.3 do
                with_synth :dsaw do
                  play_chord ch, attack: 0.1
                end
              end
            end
          end
        end
      end
    end
  else
    sleep 0.1
  end
end

live_loop :burp do
  sync :kick
  if tracker[11] == 1 then
    with_fx :reverb, room: 1 do
      with_fx :echo, mix: 0.3, phase: 0.25 do
        with_fx :slicer do
          with_fx :pitch_shift, pitch: 12 do
            sample :misc_burp, rate: 0.2, amp: 3
            tracker[11] = 0
            sleep 4
          end
        end
      end
    end
  end
  
  if tracker[11]>0 then
    with_fx :reverb, room: 1 do
      with_fx :echo, mix: 0.3, phase: 0.25 do
        with_fx :slicer do
          with_fx :pitch_shift, pitch: 12 do
            sample :misc_burp, rate: 0.2, amp: 3
            sleep 4
          end
        end
      end
    end
  else
    sleep 1
  end
end

kick = 0
snare = 1
hats = 2
bass = 3
skank = 4
lead = 5
boom = 6
alien_whoosh = 7
zawa = 8
dub_pad = 9
dub_synth = 10
burp= 11
boom = 6

start_loop lead
sleep 8

repeat_loop kick
sleep 2
repeat_loop snare
repeat_loop hats
sleep 4
repeat_loop bass
sleep 4
repeat_loop skank
sleep 4
start_loop lead
sleep 8
repeat_loop dub_pad
sleep 16
stop_loop dub_pad
repeat_loop dub_synth
sleep 32
start_loop zawa
sleep 8
start_loop burp
sleep 12
start_loop boom
sleep 12
start_loop burp
sleep 12
start_loop zawa
sleep 12
stop_loop dub_synth
sleep 8
repeat_loop dub_pad
sleep 12
start_loop lead
sleep 16
stop_loop dub_pad
sleep 4
start_loop lead
sleep 16
start_loop zawa
sleep 4
stop_all