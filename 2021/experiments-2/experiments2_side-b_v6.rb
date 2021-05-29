require "/home/diego/Projects/sonic-pi/petal/petal.rb"

cps 0.9

d1 "bd ~ ~ ~"

d2 "hh hh [hh hh/2] hh", amp: "0.8 0.3 0.7 0.4"

d3 "~ ~ sn/4 ~", n: 5, amp: 0.6

chs = [
  (chord :d3, :m11),
  (chord :g3, :m11),
  (chord :d3, :m11),
  (chord :eb3, :m11),
  (chord :cs3, :diminished7),
]

live_loop :chords, sync: :d0 do
  use_bpm get_bpm
  # use_synth :pretty_bell
  use_synth :zawa
  with_fx :reverb, mix: 0.7, room: 0.9 do
    ch = chs[0]
    set :ch, ch
    play ch, amp: 0.3, attack: 0.6, sustain: 0.4, decay: 0.4
    sleep 4
    ch = chs[1]
    set :ch, ch
    play ch, amp: 0.3, attack: 0.6, sustain: 0.4, decay: 0.4
    sleep 4
    ch = chs[2]
    set :ch, ch
    play ch, amp: 0.3, attack: 0.6, sustain: 0.4, decay: 0.4
    sleep 4
    ch = chs[3]
    set :ch, ch
    play ch, amp: 0.3, attack: 0.6, sustain: 0.4, decay: 0.1
    sleep 2
    ch = chs[4]
    set :ch, ch
    play ch, amp: 0.3, attack: 0.3, sustain: 0.4, decay: 0.4
    ch = chs[0]
    set :ch, ch
    sleep 2
  end
end

live_loop :bass, sync: :d0 do
  use_bpm get_bpm
  use_synth :fm
  use_random_seed 5892
  32.times do
    ch = get(:ch)
    play (ch.choose-12), release: 0.2, amp: 0.5 if (spread 7, 12).tick
    sleep 0.25
  end
end


live_loop :melody, sync: :d0 do
  use_bpm get_bpm/2
  use_synth :pluck
  
  use_random_seed 421
  with_fx :flanger, feedback: 0.85, depth: 5 do
    ch = get(:ch)
    16.times do
      play (scale ch[0], :minor_pentatonic).choose, amp: 0.3 if (spread 5,16, rotate: 1).tick
      sleep 0.125
      puts 1
    end
    ch = get(:ch)
    16.times do
      play (scale ch[0], :minor_pentatonic).choose, amp: 0.3 if (spread 4, 15, rotate: 1).tick
      sleep 0.125
      puts 2
    end
    use_random_seed 421
    ch = get(:ch)
    16.times do
      play (scale ch[0], :minor_pentatonic).choose, amp: 0.3 if (spread 5,16, rotate: 1).tick
      sleep 0.125
      puts 1
    end
    ch = get(:ch)
    16.times do
      play (scale ch[0], :minor_pentatonic).choose, amp: 0.3 if (spread 4, 15, rotate: 1).tick
      sleep 0.125
      puts 2
    end
  end
end
