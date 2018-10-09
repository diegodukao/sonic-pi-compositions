# https://in-thread.sonic-pi.net/t/kick-drum-synthesis/269/9

x=0 # V1.02                                         The Techno Toolbox
#________________________________________________________________________________________________________________________
"TRACK" #__0_____1_____2_____3_____4_____5_____6_____7_____8_____9____10____11____12____13____14____15____16
track =   [0  ,  0 ,  0  ,  0  ,  0  ,  0  ,  0  ,   0 ,   0  ,  0 ,  0 ,   0  ,  0  ,  0  ,  0  ,  0  ,  0]
#                                     Set to 1 to activate loop. 0 to deactivate
#________________________________________________________________________________________________________________________
"EFFECT"#__0_____1_____2_____3_____4_____5_____6_____7_____8_____9____10____11____12____13____14____15____16
effect =  [x  ,  x  ,  x  ,  x  ,  x  ,  x  ,  1  ,  x  ,  x  ,  x  ,  3  ,  1  ,  1  ,  0  ,  1  ,  x  ,  x]
#                                          Change number to change effect.
#________________________________________________________________________________________________________________________
"VOLUME"#__0_____1_____2_____3_____4_____5_____6_____7_____8_____9____10____11____12____13____14____15____16
volume =  [0  ,  0  ,  0  ,  0  ,  0  ,  0  ,  0  ,  0  ,  0  ,  0  ,  0  ,  0  ,  0  ,  0  ,  0.5  ,  0  ,  0]
#                                   Increase number to increase volume above default.
#________________________________________________________________________________________________________________________
"SPEED "#__0_____1_____2_____3_____4_____5_____6_____7_____8_____9____10____11____12____13____14____15____16
speed  = [125 , 125 , 125 , 125 , 125 , 125 , 125 , 125 , 125 , 125 , 125 , 125 , 125 , 125 , 125 , 125 , 125]
#                                            Set BPM for a loop (1-999)
#________________________________________________________________________________________________________________________
#                                       ALT-R or CLICK 'RUN to ACTIVATE CHANGES
#________________________________________________________________________________________________________________________#
#             Effect             Effect                             Effect                                Effect
#_Track_______Value___Track______Value______________Track___________Value__________________Track__________Value____________________________
# 0 Bass.      None | 6 Tom       0 - Regular Tom | 10 Snare         0 - Normal electric | 12 Synth2 Climb 0 - FM
# 1 Kick.      None |             1 - Fuzz Tom    |                  1 - Phased electric |                 1 - TRI
# 2 Kick plus. None | 7 Cowbell   None            |                  2 - Normal hard     | 13 Synth2 Top   0 - FM
# 3 Hi Hat.    None | 8 Xylo Low  None            |                  3 - Phased hard     |                 1 - TRI
# 4 Shaker     None | 9 Xylo Hi   None            | 11 Synth1        0 - Clavinet        | 14 Synth3       None
# 5 Cabasa     None |                             |                  1 - Organ           | 15 Melody1      None
#                   |                             |                                      | 16 Melody2      None
#___________________|_____________________________|______________________________________|_________________________________________________
#
# See end of code for examples of how to make and use 'script' mode.
# Complete script language is in the associated document, TTT Scripting.
#
"#      Note: Not all effect/volume changes are instantaneous... you will need to learn to judge them for yourself.
"#                                Code Courtesy of: G.Martin Butz. Control Panel by: Eli...

use_bpm 125
set_sched_ahead_time! 0.5
use_debug false
bs = 0.5
bp = 0.095
bass_rel = (ring bs, bs, 0, bp, bp, bs, 0, bs, bs, 0, bp, bp, bp)
bass_dur = (ring 0.5, 0.5, 0.25, 0.25, 0.25, 0.25, 0.25, 0.5, 0.25, 0.25, 0.25, 0.25, 0.25)
bass_amp = (ring 1.25, 1, 0, 1, 1, 1, 0, 1, 1, 0, 1.5, 1, 1)
tom_ptn = (ring 5 * 0.25, 2 * 0.25, 5 * 0.25, 2 * 0.25, 2 * 0.25)
fuzz_tom_rate = (ring 1.8, 1.8, 1.8, 1.8, 1.8, 1.8, 1.8, 1.8, 2.05, 1.8) # values for fuzz tom
tom_rate = (ring 2, 2, 2, 2, 2, 2, 2, 2, 2.25, 2)
cowbell_ptn = (ring 1, 0, 1, 0, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0,1, 0, 1, 0, 1, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1,
               0, 0, 1, 0, 1, 1, 0, 1, 0, 1, 0, 1, 0, 1, 1, 0, 1, 0, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 1, 0)

cowbell_ptn2 = (ring 1, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 1, 1, 0, 1, 0, 0, 1, 1, 0, 1, 0, 1,
                0, 0, 1, 0, 1, 1, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0)
xylo_hi_nte = (ring :c5, :eb5, :c5, :c5, :c5, :eb5, :d5, :eb5)
xylo_hi_ptn = (ring 2 * 0.25, 3 * 0.25, 2 * 0.25, 2 * 0.25, 1 * 0.25, 2 * 0.25, 2 * 0.25, 2 * 0.25)
c1 = chord_invert(chord(:c2, 'm7'), 2)
c2 = chord_invert(chord(:c2, 'm7'), 1)
c3 = chord_invert(chord(:c2, 'm7+9'), 1)
c1 = chord_invert(chord(:c3, 'm7'), 2)
c2 = chord_invert(chord(:c3, 'm7'), 1)
c3 = chord_invert(chord(:c3, 'm7+9'), 1)
s1_chrds = (ring c1, 0, c2, 0, 0, c1, 0, c1, 0, c2, 0, c3, 0, c1, c2, c3, 0, 0, c1, 0, 0, c1, 0, c1,
            0, 0, c1, c1, 0, c1, c2, c3)
synth2_vol = (range 0, 0.75, step: 0.1).ramp
synth3_inv = (ring 0, 4, 3, 4, 0)

live_loop :half_beat do
  sleep 0.5
end

live_loop :beat do
  sleep 1
end

live_loop :beat4 do
  sync :half_beat
  sleep 4
end

live_loop :beat16 do
  sync :half_beat
  sleep 16
end

define :track_start do |i|
  track[i] = 1
end

define :track_stop do |i|
  track[i] = 0
end

define :stop_all do
  for i in 0.. 18
    track[i] = 0
    effect[i] = 0
    volume[i] = 0
    speed[i] = 125
  end
end

define :track_decrease do |i, n |
  if volume[i] - n > 0 then
    volume[i] = volume[i] - n
  end
end

define :track_increase do |i, n |
  if volume[i] + n < 10 then
    volume[i] = volume[i] + n
  else
  end
end

define :track_effect do |i, n |
  effect[i] = n
end

define :track_speed do |i, n |
  speed[i] = n
end

live_loop :bass do
  if track[0] > 0 then
    sync :beat4
    use_bpm speed[0] if speed[0] > 000
    use_synth :fm
    use_synth_defaults divisor: 1, attack: 0, sustain: 0, amp: 1, cutoff: 130,  depth: 3
    13.times do
      play :f1, release: bass_rel.tick, amp: bass_amp.look+volume[0]
      sleep bass_dur.look
    end
  else
    sleep 0.1
  end
end

live_loop :kick do
  if track[1] > 0 then
    sync :beat4
    use_bpm speed[1] if speed[1] > 000
    with_fx :lpf, cutoff: 40 do
      4.times do
        sample :bd_gas, rate: 1, amp: 3+volume[1]
        sleep 1
      end
    end
  else
    sleep 0.1
  end
end

live_loop :kick_plus do
  if track[2] > 0 then
    sync :beat4
    use_bpm speed[2] if speed[2] > 000
    with_fx :lpf, cutoff: 40, mix: 1 do
      4.times do
        sample :bd_zum, rate: 1, amp: 1+volume[2]
        sleep 1
      end
    end
  else
    sleep 0.1
  end
end

live_loop :hihat do
  if track[3] > 0 then
    sync :beat4
    use_bpm speed[3] if speed[3] > 000
    4.times do
      sleep 0.5
      sample :drum_cymbal_open, start: 0.025, finish: 0.15, rate: 1.1, pan: -0.3, amp: 0.35+volume[3]
      sleep 0.5
    end
  else
    sleep 0.1
  end
end

live_loop :shaker do
  if track[4] > 0 then
    sync :beat4
    use_bpm speed[4] if speed[4] > 000
    use_synth :cnoise
    use_synth_defaults attack: 0, sustain: 4, release: 0, amp: 5+volume[4]
    with_fx :slicer, phase: 0.25, pulse_width: 0.35 do
      with_fx :hpf, cutoff: 130 do
        play 60
      end
      sleep 4
    end
  else
    sleep 0.1
  end
end

live_loop :cabasa do
  if track[5] > 0 then
    sync :beat4
    use_bpm speed[5] if speed[5] > 000
    use_synth :noise
    use_synth_defaults attack: 0.0, decay: 0.02, release: 0.05, pan: 0.75, amp: 2+volume[5]
    with_fx :rhpf, cutoff: 123, res: 0.75, reps: 16 do
      if (spread 11, 16).tick then
        play :c1
      end
      sleep 0.25
    end
  else
    sleep 0.1
  end
end

live_loop :tom do
  if track[6] > 0 then
    sync :beat16
    use_bpm speed[6] if speed[6] > 000
    with_fx :reverb, room: 0.5 do
      20.times do
        if effect[6] == 0 then
          sample :elec_bong, start: 0, rate: tom_rate.look, amp: 1+volume[6]
        end
        if effect[6] == 1 then
          sample :elec_fuzz_tom, start: 0.1, finish: 1, rate: tom_rate.look, amp: 0.75+volume[6]
        end
        sleep tom_ptn.tick
      end
    end
  else
    sleep 0.1
  end
end

live_loop :cowbell do
  if track[7] > 0 then
    sync :beat16
    use_bpm speed[7] if speed[7] > 000
    with_fx :reverb, room: 0.25, mix: 0.5 do
      64.times do
        if cowbell_ptn.tick > 0 then
          sample :elec_bell, rate: 2.04, pan: 0.75, amp: cowbell_ptn.look+volume[7]
        end
        if cowbell_ptn2.look > 0 then
          sample :elec_bell, rate: 2.74, pan: 0.75, amp: (cowbell_ptn2.look * 0.75)+volume[7]
        end
        sleep 0.25
      end
    end
  else
    sleep 0.1
  end
end

live_loop :xylo_lo do
  if track[8] > 0 then
    sync :beat4
    use_bpm speed[8] if speed[8] > 000
    use_synth :fm
    use_synth_defaults divisor: 0, depth: 1, attack: 0, sustain: 0, release: 0.25, pan: 0.3, amp: 0.5+volume[8]
    with_fx :reverb, room: 0.5, mix: 0.5 do
      4.times do
        sleep 0.75
        play :eb4, attack: 0.25
        sleep 0.25
        play :g4, release: 0.25
        sleep 0.25
        play :f4, release: 0.25
        sleep 0.75
      end
    end
  else
    sleep 0.1
  end
end

live_loop :xylo_hi do
  if track[9] > 0 then
    sync :beat4
    use_bpm speed[9] if speed[9] > 000
    use_synth :fm
    use_synth_defaults divisor: 0, depth: 1, attack: 0, sustain: 0, release: 0.25, amp: 0.5+volume[9], pan: 0.3
    with_fx :reverb, room: 0.5, mix: 0.5 do
      32.times do
        play xylo_hi_nte.tick
        sleep xylo_hi_ptn.look
      end
    end
  else
    sleep 0.1
  end
end

live_loop :snare do
  if track[10] > 0 then
    sync :beat4
    use_bpm speed[10] if speed[10] > 000
    if effect[10] == 0 then
      with_fx :reverb, room: 0.5, mix: 0.25 do
        2.times do
          sleep 1
          sample :elec_hi_snare, finish: 0.75, rate: 0.75, pan: -0.3, amp: 1.0
          sleep 1
        end
      end
    end
    if effect[10] == 1 then
      with_fx :echo, phase: [0.25, 0.5, 0.75].choose, decay: 8, mix: 0.5 do
        2.times do
          sleep 1
          sample :elec_hi_snare, finish: 0.75, rate: 0.75, pan: -0.3, amp: 1.0
          sleep 1
        end
      end
    end
    if effect[10] == 2 then
      with_fx :reverb, room: 0.5, mix: 0.25 do
        2.times do
          sleep 1
          sample :drum_snare_hard, rate: 2, pan: -0.3, amp: 1
          sleep 1
        end
      end
    end
    if effect[10] == 3 then
      with_fx :echo, phase: [0.25, 0.5, 0.75].choose, decay: 8, mix: 0.5 do
        2.times do
          sleep 1
          sample :drum_snare_hard, rate: 2, pan: -0.3, amp: 1
          sleep 1
        end
      end
    end
  else
    sleep 0.1
  end
end

live_loop :synth1 do
  if track[11] > 0 then
    sync :beat16
    use_bpm speed[11] if speed[11] > 000
    if effect[11] == 1 then
      use_synth :fm
      use_synth_defaults divisor: 0.5, depth: 2, attack: 0, sustain: 0, release: 0.25, pan: -0.5, amp: 1.5+volume[11]
    end
    if effect[11] == 0 then
      use_synth :pluck
      use_synth_defaults release: 0.25, noise_amp: 1, coef: 0.5, amp: 5+volume[11]
    end
    with_fx :reverb, room: 0.25, mix: 0.25 do
      128.times do
        if s1_chrds.tick != 0 then
          play s1_chrds.look
        end
        sleep 0.25
      end
    end
  else
    sleep 0.1
  end
end

live_loop :synth2_climb do
  if track[12] > 0 then
    sync :beat16
    use_bpm speed[12] if speed[12] > 000
    vol = synth2_vol.tick+volume[12]
    if effect[12] == 1 then
      use_synth :tri
    end
    if effect[12] == 0 then
      use_synth :fm
    end
    use_synth_defaults release: 0.25
    with_fx :flanger do
      8.times do
        sleep 0.75
        play :eb5, amp: 0.4 * vol, pan: -0.6
        play :c5, amp: 0.15 * vol, pan: -0.3
        sleep 0.25
        play :g5, amp: 0.4 * vol, pan: -0.3
        play :eb5, amp: 0.15 * vol, pan: -0.1
        sleep 0.25
        play :f5, amp: 0.4 * vol, pan: -0.1
        play :d5, amp: 0.15 * vol, pan: 0
        sleep 0.25
        play :a5, sustain: 0.25, release: 0.5, amp: 0.3 * vol, pan: 0.2
        play :f5, sustain: 0.25, release: 0.5, amp: 0.15 * vol, pan: 0.4
        sleep 0.5
      end
    end
  else
    sleep 0.1
  end
end

live_loop :synth2_top do
  if track[13] > 0 then
    sync :beat16
    use_bpm speed[13] if speed[13] > 000
    vol = synth2_vol.tick+volume[13]
    if effect[13] == 1 then
      use_synth :tri
    end
    if effect[13] == 0 then
      use_synth :fm
    end
    with_fx :flanger do
      8.times do
        sleep 0.5
        play :c6, sustain: 0.25, release: 0.15, amp: 0.5 * vol, pan: 0.5
        play :eb6, sustain: 0.25, release: 0.15, amp: 0.25 * vol, pan: 0.75
        sleep 1.25
        play :c6, sustain: 0.25, release: 0.25, amp: 0.5 * vol, pan: -0.8
        play :eb6, sustain: 0.25, release: 0.5, amp: 0.15 * vol, pan: -0.8
        sleep 0.25
      end
    end
  else
    sleep 0.1
  end
end

live_loop :synth3 do
  if track[14] > 0 then
    sync :beat16
    use_bpm speed[14] if speed[14] > 000
    if effect[14] == 0 then
      use_synth :blade
      use_synth_defaults amp: 0.25+volume[14], vibrato_depth: 0.05, vibrato_rate: 0.5
    end
    if effect[14] == 1 then
      use_synth :dpulse
      use_synth_defaults amp: 0.25+volume[14], detune: 0.1, pulse_width: 0.5, dpulse_width: 0.99, cutoff: 130
    end
    with_fx :reverb, room: 0.5, mix: 0.5 do
      play chord_invert((ring :f5, :a5, :bb5, :c5, :eb5), synth3_inv.tick), attack: 3, sustain: 5, release: 5
      sleep 16
    end
  else
    sleep 0.1
  end
end

live_loop :melody1 do
  if track[15] > 0 then
    sync :beat16
    use_bpm speed[15] if speed[15] > 000
    use_synth :beep
    use_synth_defaults attack: 0, sustain: 0.25, release: 0.75, pan: 0.5, amp: 0.5+volume[15]
    with_fx :reverb, room: 0.5, mix: 0.5 do
      play :f6, sustain: 0.5, release: 0.5, amp: 0.8+volume[15], pan: -1
      sleep 0.5 * 3
      play :f5, release: 0.75, pan: 0.5
      sleep 0.5 * 4
      play :c6, release: 0.3, pan: -0.5
      sleep 0.5 * 2
      play :eb6, release: 0.75, pan: 1
      sleep 0.5 * 7
      play :c6, release: 0.3, pan: -0.1
      sleep 0.5 * 4
      play :a5, sustain: 0.1, release: 0.1, pan: -1
      sleep 0.5 * 1
      play :bb5, sustain: 0.1, release: 0.1, pan: 1
      sleep 0.5 * 1
      play :c6, sustain: 0.1, release: 0.1, pan: 0
      sleep 0.5 * 1
      play :f5, sustain: 0.75, release: 0.1, pan: 0.5
      sleep 0.5 * 9
    end
  else
    sleep 0.1
  end
end

live_loop :melody2 do |idx|
  if track[16] > 0 then
    sync :beat4
    use_bpm speed[16] if speed[16] > 000
    use_random_seed 66776
    with_fx :reverb, phase: 0.125, mix: 0.8  do
      this_note = [:e5, :a5, :c5].choose
      notes = scale(this_note, :minor_pentatonic, num_octaves: 2)
      8.times do |idx|
        sleep 0.5
        play notes.choose, pulse_width: 0.2, attack: 0, release: 0.1, pan: (range -1, 1, 0.125)[idx], amp: rrand(1, 2)+volume[16]
      end
    end
  else
    sleep 0.1
  end
end

# An Example Script
comment do
  track_start 16
  sleep 5
  track_start 8
  sleep 3
  track_start 6
  sleep 5
  track_start 4
  track_start 5
  track_start 0
  sleep 3
  track_start 11
  sleep 5
  track_start 12
  sleep 5
  track_start 1
  sleep 5
  track_start 9
  sleep 10
  track_increase 9, 2
  track_start 10
  sleep 10
  track_decrease 9, 2
  track_effect 10,1
  sleep 20
  track_effect 10,0
  sleep 5
  stop_all
end

# Changing an effect
comment do
  track_effect 10,0
  track_start 10
  sleep 10
  track_effect 10,1
  sleep 20
  track_effect 10,0
  sleep 10
  stop_all
end

# Changing the BPM of a loop
comment do
  track_speed 15,125
  track_start 15
  sleep 10
  track_speed 15,45
  sleep 20
  track_speed 15, 90
  sleep 10
  stop_all
end