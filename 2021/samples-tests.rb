require "/home/diego/Projects/sonic-pi/petal/petal.rb"

d1 "bd [~ bd/2] bd/2 [~ bd]"
d2 "hh [~ hh/3] [~ hh] hh"
d3 "~ sn ~ sn", n: 1, slow: 2

##| d4 "dork2(3,16,2)", n: "irand 4", rate: 'rand 1 2'

##| d4 "future(5,16,2)" , slow: 2, n: "irand 4"# rate: 'rand 1 2'

##| d4 "hoover(5,16,2)" , slow: 2, n: "irand 2 6", rate: 'rand 1 0.8, 1.2, 0.6'

##| d4 "house(5,16,2)" , slow: 2, n: 5, rate: 'rand 1 0.8, 1.2, 0.6'

##| d4 "jungbass(5,16,2)" , slow: 2, n: "irand 6" # , rate: 'rand 1 0.8, 1.2, 0.6'

##| d4 "jvbass(5,16,2)" , slow: 2, n: "irand 6" # , rate: 'rand 1 0.8, 1.2, 0.6'

##| d4 "koy(5,16,2)" , slow: 2, n: "irand 6" # , rate: 'rand 1 0.8, 1.2, 0.6'

##| d4 "kurt(5,16,2)" , slow: 2, n: "irand 6"  , rate: 'rand 1 0.8, 1.2, 0.6'

##| d4 "led(5,16,2)" , slow: 2, n: "irand 6" # , rate: 'rand 1 0.8, 1.2, 0.6'

##| d4 "less(5,16,2)" , slow: 2, n: "irand 6" # , rate: 'rand 1 0.8, 1.2, 0.6'

###

d4 "sitar(3,8)" , slow: 4, n: 2 , rate: 'rand 1 0.8, 1.2, 0.6'

d4 "toys(3,8)" , slow: 4, n: "irand 5", rate: -1 #, rate: 'rand 1 0.8, 1.2, 0.6'

d4 "rave(3,8)" , slow: 2, n: "irand 30", rate: 'rand 1 0.8, 1.2, 0.6'

d4 "outdoor(3,8)" , slow: 2, n: "irand 30", rate: 'rand 1 0.8, 1.2, 0.6'

d4 "newnotes(3,8)" , slow: 2, n: "irand 30", rate: 'rand 1 0.8, 1.2, 0.6'

d4 "speakspell(3,8)" , slow: 2, n: "irand 30", rate: 'rand 1 0.8, 1.2, 0.6'
