# creates buffer to store an audio of 8s
rec = buffer(:rec, 8)

# records audio from audio input
with_fx :record, buffer: rec do
  live_audio :mic
  sleep 8
end
live_audio :mic, :stop

# plays recorded audio on reverse
sample rec, rate: -1
sleep 8

# records audio from audio input applying flanger fx
with_fx :record, buffer: rec do
  with_fx :flanger, phase: 0.1 do
    live_audio :mic
  end
  sleep 8
end
live_audio :mic, :stop

# plays recorded audio slower
sample rec, rate: 0.8