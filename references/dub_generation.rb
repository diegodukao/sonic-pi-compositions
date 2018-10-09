# https://in-thread.sonic-pi.net/t/reggaeton-dembow-rhythm-with-sonic-pi/985/12

"                              Dub Generation" # V3.0
#___________________________________________________________________________________
"TRACK"#___0___1___2___3___4___5___6___7___8___9__10___11___12___13__14___15___16__17__18 |
track =   [2 , 0 , 2 , 0 , 2 , 2 , 0 , 0 , 2 , 2, 0 ,  0 ,  0 ,  0 , 0 ,  0 ,  0 , 0 , 0  ]
"             0 to deactivate, 1 for 1-shot effect, 2 for continuous loop."#              |
#_________________________________________________________________________________________|
"                           ALT-R or CLICK 'RUN to ACTIVATE"
#_________________________________________________________________________________________|

#_Track_______Track______________Track_____________Track_______
#           |                  |                 | 12 Dub Pad  \
# 0 Kick    | 6  Rim           | 12 Whoosh       |              |
# 1 Boom    | 7  Bass          | 13 Train        |              |
# 2 Beat 1  | 8  Skank         | 14 Zawa         |              |
# 3 Beat 2  | 9  Swirl         | 15 Burp         |              |
# 4 Snare   | 10 Guitar 1      | 16 Ghostly keys |              |
#_5 Hat     | 11_Guitar 2      | 17 Synth tune   |              |
#___________|__________________|_________________|______________/
#
#   See end of code for examples of how to make and use 'script' mode.
# Complete script language is in the associated document, DUB Scripting.
#
#      Note: Not all effect/volume changes are instantaneous...
#             you will need to judge them for yourself.
#
#                           Control Panel by: Eli...
#
# Extra 'BOOM' added for my friend Xomby.  'Respec'...






















x=0
use_bpm 75

kick = 0
boom = 1
base_drum = 2
secondary_drum = 3
snare = 4
hat = 5
rim = 6
bass = 7
skank = 8
lead = 9
guitar1 = 10
guitar2 = 11
alien_whoosh = 12
train = 13
zawa = 14
burp = 15
ghostly_keys = 16
dub_synth = 17
dub_pad = 18

synth_cutoffs = range(60, 100, 0.5).mirror
synth_rhythm = (ring 1.5, 1.5, 1)
synth_transpositions = (stretch 0, 36) + (stretch -12, 6) + (stretch 12, 6)
synth_phases = (stretch 0.75, 15) + [0.25]
synth_pans = (ring -0.5, 0.5)
synth_volume = 1

dubpad_cutoffs = range(70, 100, 5).mirror
dubpad_phases = (ring 8, 8, 8, 0.5)
dubpad_mixes = (ring 0.5, 0.5, 0.5, 0)
dchord = chord(:e3, :minor, num_octaves: 3)
dubpad_volume = 1

n = (ring :r, :r, :d2, :d3, :f3, :r, :d1, :f2)

define :combo do |s, t, u|
  start_loop s
  start_loop t
  start_loop u
  sleep 4
  stop_loop s
  stop_loop t
  stop_loop u
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

define :dubpad do |ch, amp=0.25|
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

# Repeat a loop.
define :repeat_loop do |i|
  track[i] = 2
end

# Bring in a loop.
define :start_loop do |i|
  track[i] = 1
end

# Remove a loop.
define :stop_loop do |i|
  track[i] = 0
end

live_loop :kick do
  if track[0] > 0 then
    sample :bd_tek, amp: 0.2
    sleep 1
    if track[0] == 1 then
      track[0] = 0
    end
  else
    sleep 0.25
  end
end

live_loop :boom do
  sync :kick
  if track[1] > 0 then
    with_fx :reverb, room: 1 do
      sample :bd_boom, amp: 3
    end
    sample :drum_tom_hi_hard, amp: 3, rate: 0.2
    if track[1] == 1 then
      track[1]=0
      sleep 1
    end
  else
    sleep 1
  end
end

live_loop :base_drums do
  sync :kick
  if track[2] > 0 then
    with_fx :reverb, room: 0.5, phase: 0.5 do
      with_fx :echo, mix: 0.3, phase: 0.25 do
        2.times do
          sample :drum_heavy_kick, amp: 1, release: 1
          sleep 1.5
          sample :drum_snare_hard, amp: 0.3, release: 1
          sleep 1.5
        end
        if track[2] == 1 then
          track[2]=0
          
        end
      end
    end
  else
    sleep 1
  end
end

live_loop :secondary_drums do
  sync :kick
  if track[3] > 0 then
    with_fx :reverb, room: 0.5, phase: 0.5 do
      with_fx :echo, mix: 0.3, phase: 0.25 do
        sleep 1.5
        
        sample :drum_snare_hard, amp: 0.3, release: 1
        sleep 1.5
        
        sample :drum_heavy_kick, amp: 0.8, release: 1
        sleep 1.5
        
        sample :drum_snare_hard, amp: 0.5, release: 1
        sleep 0.5
        
        sample :drum_bass_soft, amp: 0.25, release: 1
        sleep 0.25
        sample :drum_bass_hard, amp: 0.75, release: 1
        sleep 0.25
        sample :drum_bass_soft, amp: 0.5, release: 1
        sleep 0.5
        if track[3] == 1 then
          track[3]=0
        end
        
      end
    end
  else
    sleep 1
  end
end

with_fx :reverb, mix: 0.35, room: 0.1, damp: 0.9 do
  live_loop :snare do
    if track[4]>0 then
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
      if track[4] == 1 then
        track[4] = 0
      end
    else
      sleep 1
    end
  end
end



live_loop :hat1 do
  if track[5]>0 then
    sample :drum_cymbal_closed, sustain: 0.125, amp: 0.3 if rand > 0.9
    sleep 0.5
    sample :drum_cymbal_closed, sustain: 0.125, amp: 0.5
    sleep 0.5
    if track[5] == 1 then
      track[5] = 0
    end
  else
    sleep 1
  end
end


live_loop :rim do
  if track[6]>0 then
    sample [:elec_tick, :elec_blip].choose, sustain: 0.006, amp: 0.8, hpf: 100 if rand > 0.3
    sleep 0.25
    if track[6] == 1 then
      track[6] = 0
    end
  else
    sleep 1
  end
end


live_loop :bass do
  if track[7]>0 then
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
    if track[7] == 1 then
      track[7] = 0
    end
  else
    sleep 1
  end
end


with_fx :gverb, mix: 0.1, room: 20, amp: 0.6 do
  live_loop :skank do
    if track[8]>0 then
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
        if track[8] == 1 then
          track[8] == 0
        end
      end
    else
      sleep 1
    end
  end
end


with_fx :echo, mix: 0.8, phase: 0.75, decay: 4 do
  with_fx :flanger, stereo_invert_wave: 1, feedback: 0.5, amp: 0.5 do
    
    live_loop :lead do
      if track[9] > 0 then
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
          if track[9]== 1 then
            tracker[9] = 0
          end
          sleep 2.5
        end
      else
        sleep 1
      end
    end
    
  end
end

live_loop :guitar1 do
  sync :kick
  if track[10] > 0 then
    with_fx :reverb, room: 1 do
      with_fx :echo, mix: 0.3, phase: 0.25 do
        with_fx :slicer do
          sample :guit_em9, rate: 1
          sleep 4
          if track[10] == 1 then
            track[10]=0
            sleep 1
          end
        end
      end
    end
  else
    sleep 1
  end
end

live_loop :guitar2 do
  sync :kick
  if track[11] > 0 then
    with_fx :reverb, room: 1 do
      with_fx :pitch_shift, pitch: -6 do
        sample :guit_e_fifths, rate: 1
        sleep 4
        if track[11] == 1 then
          track[11] = 0
          sleep 1
        end
      end
    end
  else
    sleep 1
  end
end

live_loop :alien_woosh do
  sync :kick
  if track[12] > 0 then
    with_fx :reverb, room: 1 do
      sample :ambi_dark_woosh
      sleep 4
      if track[12] == 1 then
        track[12]=0
        sleep 1
      end
    end
  else
    sleep 1
  end
end

live_loop :train do |s|
  sync :kick
  if track[13] > 0 then
    with_fx :reverb, room: 0.5, phase: 0.5 do
      if s
        sleep 2
        end_release = 4
      else
        end_release = 6
      end
      use_synth :bnoise
      play :Cs3, amp: 0.5, pan: -1
      sleep 0.25
      play :Es3, amp: 0.25, pan: 1
      sleep 0.5
      play :Cs2, amp: 0.4, pan: -1
      sleep 0.25
      play :Es2, amp: 0.25, pan: 1
      sleep 0.5
      play :Ds3, amp: 0.3, pan: -1
      sleep 0.25
      play :Bs3, amp: 0.25, pan: 1
      sleep 0.5
      play :Ds2, amp: 0.3, pan: -1
      sleep 0.25
      play :Bs2, amp: 0.25, pan: 1, release: end_release
      if track[13] == 1 then
        track[13]=0
        sleep 1.5
      end
    end
  else
    sleep 1
  end
end

live_loop :zawa do
  sync :kick
  if track[14] > 0 then
    with_fx :reverb, room: 1 do
      with_fx :slicer do
        with_fx :pitch_shift, pitch: -12 do
          use_synth :zawa
          [3,5,6,7,8,10].choose.times do |i|
            play chord(:e4, :minor).choose, release: [0.2, 0.4, 0.6, 0.8, 1].choose, pan: [1,0,-1].choose, cutoff: rrand(80, 110)
            sleep [0.25,0.5,0.75].choose
            if track[14] == 1 then
              track[14]=0
              sleep [0.25,0.5,0.75].choose
            end
          end
        end
      end
    end
  else
    sleep 1
  end
end

live_loop :burp do
  sync :kick
  if track[15] > 0 then
    with_fx :reverb, room: 1 do
      with_fx :echo, mix: 0.3, phase: 0.25 do
        with_fx :slicer do
          with_fx :pitch_shift, pitch: 12 do
            sample :misc_burp, rate: 0.2, amp: 3
            sleep 4
            if track[15] == 1 then
              track[15] = 0
              sleep 4
            end
          end
        end
      end
    end
  else
    sleep 1
  end
end

live_loop :ghostly_keys do
  sync :kick
  if track[16] > 0 then
    with_fx :reverb, room: 0.8 do
      with_fx :echo, delay: 0.5, decay: 4 do
        use_synth :dark_ambience
        play chord([:b3, :b4, :e3, :e4].choose, :minor).choose,
          amp: 1.5, release: 6
        [5,6,7,8,9,10].choose.times do |i|
          use_synth :piano
          play chord([:b1, :b2, :b3, :e1, :e2, :e3].choose,
          :minor).choose, cutoff: rrand(40, 100),
            amp: 0.75, attack: 0, release: rrand(1, 2),
            cutoff_max: 110, pan: [-1, 0, 1].choose
          sleep [0.25, 0.5, 0.5, 0.5, 1, 1].choose
          if track[16] == 1 then
            track[16] = 0
            sleep 1
          end
        end
      end
    end
  else
    sleep 1
  end
end

live_loop :synth do
  sync :kick
  if track[17] > 0 then
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
                  sleep synth_rhythm.look
                  if track[17] == 1 then
                    track[17] = 0
                  end
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

live_loop :pad do
  sync :kick
  if track[18] > 0 then
    dubpad dchord, 0.25
    sleep 16
    if track[18] == 1 then
      track[18] = 0
      sleep 1
    end
  else
    sleep 1
  end
end

comment do
  repeat_loop dub_synth
  sleep 5
  repeat_loop alien_whoosh
  repeat_loop boom
  repeat_loop base_drum
  repeat_loop secondary_drum
  sleep 1
  stop_loop alien_whoosh
  stop_loop boom
  sleep 16
  stop_loop secondary_drum
  combo alien_whoosh, dub_pad, zawa
  sleep 4
  combo boom, base_guitar, secondary_guitar
  sleep 4
  combo train, base_guitar, alien_whoosh
  sleep 4
  combo boom, base_guitar, zawa
  sleep 4
  combo alien_whoosh, base_guitar, train
  sleep 4
  combo boom, base_guitar, zawa
  sleep 4
  combo boom, base_guitar, burp
  sleep 4
  combo burp, base_guitar, ghostly_keys
  sleep 4
  combo secondary_guitar, base_guitar, ghostly_keys
  
  sleep 5
  
  stop_loop boom
  stop_loop base_drum
  stop_loop secondary_drum
  stop_loop dub_synth
end