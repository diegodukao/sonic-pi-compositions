# https://rbnrpi.wordpress.com/2017/10/09/a-visualiser-for-sonic-pi-resizable-version/

#Program to drive Sonic Pi 3 visualiser written in "processing"
#by Robin Newman, September 2017
#see article at https://rbnrpi.wordpress.com
#This program for resizeable version of visualiser
#set up OSC address of processing sketch

use_osc '127.0.0.1',5000
#select shapes to show
osc "/viz/shapes","se"  #"s" "e" "r" Star,Ellipse, Rectangle or combination
sleep 0.1

live_loop :c do
  #choose starting colour for shapes
  osc "/viz/col",rrand_i(0,64),rrand_i(128,255),rrand_i(0,255)
  sleep 0.1
end

live_loop :f do
  #set Stroke max min widths and audioThreshold
  osc "/viz/float",([8.0,5.0,3.0].choose),[1.0,2.0].choose,(0.4+rand(0.3))
  sleep 2
end

#set range of random positional offset (can be 0,0)
#automatically disabled when showng more than one shape
osc "/viz/pos",10,0

#control "bouncing" shapes around the screen 1 for on 0 for off
osc "/viz/shift",0

live_loop :s do
  #setup star data inner/outer circle radius, number of points
  #and random variation of number of points
  osc "/viz/stardata",[1,2,3].choose,[1,2,4].choose,5,1
  sleep 2
end

rv=0 #variable for current rotation
live_loop :r do
  rv+=5*[1,1].choose # choose rotation increment
  rv=rv%360
  osc "/viz/rotval",rv #change rv to 0 to disable rotation
  sleep 0.1
end

#Now setup the sounds to play which will trigger the visualiser
use_bpm 60
set_volume! 5
use_random_seed 999

with_fx :level do |v|
  control v,amp: 0 #control the volume using fx :level
  sleep 0.1
  
  in_thread do #this loop does the volume control
    control v,amp: 1,amp_slide: 10 #fade in
    sleep 140
    control v,amp: 0,amp_slide: 10 #fade out
    sleep 10
    osc "/viz/stop" #send /viz/stop OSC message to sketch
    #sketch sends back a /stop_all_jobs command to port 4557
  end
  
  #  This drum loop is written by Eli see https://groups.google.com/forum/#!topic/sonic-pi/u71MnHnmkVY
  #  used with his permission. I liked it, and it has good percussive output
  #  to drive a visualiser
  live_loop :drums do
    this_sample = [:loop_compus, :loop_tabla, :loop_safari].ring
    start = [ 0.0 , 0.125 , 0.25 , 0.375 , 0.5 , 0.625 , 0.75 , 0.875 ].ring
    sample this_sample.look , beat_stretch: 4, start: start.look, rate: 0.5
    sleep 1
    tick
  end
end