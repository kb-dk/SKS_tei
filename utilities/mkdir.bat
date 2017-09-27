@echo off
set ts_txt=lp bi ee1 ee2 g fb ps ba f 2t43 3t43 4t43 2t44 3t44 4t44 ttl slv ae la ota kg ct lf tsa sd yts ic eot taf fv ts dss hcd oi1 oi2 oi3 oi4 oi5 oi6 oi7 oi8 oi9 gu fqa km fp ol aas fee ph elf eel dj aev pf kks ydr bms dbd ppm sbm tns bmd cgn hg drt et sa hjv af rk ck hgs er em atv oic bmt
set uts_txt=oia jc pmh boa sfv bn pcs ds oi10
set p_txt=p1 p2 p30 p48 p95 p247 p252 p254 p255 p259 p260 p261 p264 p265 p270 p271 p277 p283 p284 p305 p306 p307 p309 p315 p318 p319 p327 p339 p341 p345 p350 p364 p372 p378 p381 p385 p400 p421 p424 p431 p433 p434 p435 p440 p447 p469 p551 p592
set jp_txt=aa bb cc dd ee ff gg hh jj kk not1 not2 not3 not4 not5 not6 not7 not8 not9 not10 not11 not12 not13 not14 not15 nb nb2 nb3 nb4 nb5 nb6 nb7 nb8 nb9 nb10 nb11 nb12 nb13 nb14 nb15 nb16 nb17 nb18 nb19 nb20 nb21 nb22 nb23 nb24 nb25 nb26 nb27 nb28 nb29 nb30 nb31 nb32 nb33 nb34 nb35 nb36 %p_txt%
set b_txt=b1 b43 b70 b79 b120 b127 b161 b171 b208 b234 b241 b259 b276 b308
set bd_txt=%b_txt% ded
set dok_txt= dok

md v1.9
for %%t in (%ts_txt% %uts_txt% %jp_txt% %bd_txt% %dok_txt%) do (
if not exist v1.9\%%t md v1.9\%%t
)
