pico-8 cartridge // http://www.pico-8.com
version 32
__lua__
-- sin orbit alt
-- alexthescott
-- 8/20/21

function burn()
	for p=0,512 do
		x=rnd(128)
		y=rnd(128)
		if pget(x,y)==13 and rnd(2)\1==1 then
			if x<64 then
				xd=-1
			else
				xd=1
			end
			if y<64 then
				yd=-1
			else
				yd=1
			end
			pset(x+xd,y+yd,13)
		else
			pset(x,y,0)
		end
	end
end

o={}
pal({7,6,134,5,1,129,13,141,133,131,140,6,2},1)

for n=6,1,-1 do
	add(o,{0,n/300})
end

cls()
::♥::
burn()
if t()<2 then
	print("sin orbit alt",38,64,1)
	circ(64,64,63,13)
else
	for n=1,6 do
		x=64+n*9*(sin(o[n][1]))
		y=64+n*9*(-cos(o[n][1]))
		circfill(x,y,5,n)
		circfill(-x+128,y,5,6+n)
		o[n][1]+=o[n][2]
		if o[n][1]>=2 then
			o[n][1]=0
		end
	end
	circ(64,64,63,13)
end
flip()
goto ♥
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__label__
00000000000000000000000000000000000000200000000000020000202002200222222220020220000000000002000000000000000200000000000000000000
00000000000000000000000000000000202002020000000000002202022222222222222200220200020000000000000000000000000000000000000000000000
00000000000000000000000000000000000200000002202000022222200000000000000022222200200020000000000000000000000000000000000000000000
00000000000000000000000000020000002020002000220222200000000000000000000000000022220202000000000000000000000000000000000000000000
00000000000000000000000000002000000202000000222000000000000000000000000000000000002220002020000000000000000000000000000000000000
000000000000000000000000002000000000202002220000000066666660000000000hhhhhhh0000000002220020020000000000000000000000000000000000
00000000000000000000000000020002020022022000000666066666666600000000hhhhhhhhhhh0h00000002200000200000000000000000000000000000000
0000000000000000000000000000200020200220000066666066666666666000000hhhhhhhhhhhhhh0hh00000022022000002000000000000000000000000000
000000000000000000200000000002200202200000606660666666666666660000hhhhhhhhhhhhhhhhhhh0000000220000020200000000000000000000000000
000000000000000000000000000000200220000006006666666666666666660000hhhhhhhhhhhh0hhh0h0hh00000002202002000000000000000000000000000
000000000000000000000000000000022000000606666666666666666666660000hhhhhhhhhhhhhhhhhhh0000h00000022020020000000000000000000000000
000000000000000000000000000000200000666666666660666666666666660000hhhhhhhhhhhhhh0h0hhh0hh0hh000000200200000200000000000000000000
000000000000000000000020202022000066060666666666666666666666660000hhhhhhhhhhhhhh0hhhhh000000h00000022020002000020000000000000000
0000000000000000200000200202000066000666666666666666666666666000000hhhhhhhhhh0hhhh0hhhh00hhhhhhh00000200002000000020000000000000
0000000000000000020000020020000006666060066666060666666666660000s000hhhhhhhhhh0hhhhh0h0hhhh0hhh000000020220002000000000000000000
0000000000000000002000202200006006006660666666606sssss666660000s00000hhhhh11111h00hhhhh00hhh0hhh00000002202000002000000000000000
00000000000000000002000200000606606666660066660ssssssss000000000000000000111111110hhhhhhhh0hhhh0h0hh0000020200000000000000000000
0000000000000020200020200000000660660006666sssssssssssss0000000000000000111111111101100hh00h0hhhh0h00000002020000000000000000000
000000000000000002020200000006060066660660ss0ssssssssssss0000000000000011111111111111100000hhh0hh0hhhhh0000200000000000000000000
0000000000000020000020000066006060066660s0sssssssssssssss0000000000000011111111111111111h000h0h000hh0000000020200020000000000000
00000000000000020002000600006060660606sssssss0sssssssssss0000000000000011111111111110111010h00h0hh0hh0h0h00002020200000000200000
0000000002000000202000000060006666066ssssssssssssssssssss00000000000000111111111111111111110h0h0h00hhh00hh0000202000000002000000
000000000000000002000606066606660000sssss0sssssssssssssss0000000000000011111111111111111111110h00h0h000hhhh000020000000020000000
0000000000000000200006606660060666ssssss0s0sssssssssssss0000050000000000111111111111111111111000000hh0hh0h0000002020000200000000
0000000000000022000066060006060000ssssssssssss0ssssssss50000000500000j00011111110111111011110111000h000h00hh00000220000000000000
0000000000020202000006000600006ssssss0ss0ss000ssssssss0000000050000000000011111111111111111111111hhhhh000hh000000202020000002000
000000000020202000600006000600ssss0sssssssssssjsjjjjjjj0000000000000000005555555151111111111111011h00h00hh00h0000020200000000000
000000000000020000660000666000sssss00s0sssssjjjjjjjjjjjj00000005000j0j0055555555555511111111111101100hhh0000h0000002020000200000
0000000200002000600006060060ss0s0ssssssssssjjjjjjjjjjjjjj05000000000000555555555555551111111111110000h0h0hhhhh000000200200000000
0200000000002000600006000660sss0ss0s0ssssjjjjjjjjjjjjjjjj005000000000005555555555555550111110110111010hh0hhhh00h0000200000000000
00200000020200000600000666ssssssss00sssjjj0jjjjjjjjjjjjjj000000000000005555555555555555551111111111111h0h00000000000020000000000
0000000000200060060666000000s00ssssss0jjjjjjj0jjjjjjjjjjj0000000000000055555555555550555551101101101011h0hh000h0h000002000000000
0000000020200660666600006ss0sssssssssjjjjjjjjjjjjjjjjjjjj000000000000005555555555555555555511111011101100h0h0h000h00002000000000
0000002002000006000060600ss0ss0sssssjjj0jjjjjjjjjjjjjjjjm00000000000000055555555555505055555100100001011hhh0h0000000000200000000
000000020200000000000000000s000ss0sjjjjjjjjjjjjjjjjjjjj00mm000000ll00000l55555555555055555555111110101010hh000h0h0h0000202000002
000000002000006600600060ssssssss00jjj0jjjjjjjjjjjjjjjjm000000000000l000000555555555505055555051101110111100hh00h0000000020000020
0000002020000066600000sss0sss0sssjjjjjjjjjjj0jjllllllll000m00000000000l00mmmmmmmm505555555555051111010001000h0000hh0000020000200
000000020000600000000s00s0s0ssssjj0jjjjjjjjjjlllllllllllm00000m00000l000mmmmmmmmmmm555055555550511010011100000hhh00h000002002000
000000020000000000666sss0s0ss000j00jjjjjjjjjlllllllllllll00m00000000000mmmmmmmmmmmmm5505055555500011011111100000hh0h000002020000
0000002000006006006600ss00000sj0jjjjjjjjjjjllllllllllllll000000m0000000mmmmmmmmmmmmmm55555555555001011001101h0h0h0h0000000220200
0000002000060000000s0s0s0sssssjjjj00jjjjjjlllllllllllllll00m000000000l0mmmmmmmmmmmmmmm55555555555501110100110hhh0000000000202000
00000200066000600000000ss000sjjjj0j0jjj0jllllllllllllllll060600000000t0mmmmmmmmmmmmmm0m555555555550011101100000000000h0000022000
000002000000000060s0000ss00ssj00jjjj0jjjlllllllllllllllll00000600t0t0t0mmmmmmmmmmmmmmmmm555555005001100111010100h000h0hh00022002
002002006606606000000sss00s0jjjjjjjjj0j0l0lll0llllllllllt060000000000006mmmmmmmmmmmmmmmmm555550505551100011101000000hh0h00020200
00022000600000066ss00ssssssjj0jjjj0jjjllllll0llllllllllttt6066000t00t0666mmmmmmmmmmmmm0mmm505555555051101001110h0000000000002000
20022006600000600s0sss0000jjjjjjj0jj0ll00lll0lllllllllttttt000600t00066666mmmmmmmmmmmmmm0mm550005055550000111000h0000000h0002200
02202000660006000sss000s0sjjjj000jjjjllllllllllllttttttttttt0000t00066666666666mm0mm0mmmmmm055005555500101110001h0h0h00000002020
00220000060000000s0sssss0jjj000jjjj0lllllllllllltttttttttttt0606000t666666666666mm0mmmmmmmm05505505050510000001000h0000hh0000220
0022000000000000ss0ssss0sjjj00jjj00jlllllllllltttttttttttttt0606t00066666666666666mmmmm0mmmm555055055550010010100000000000000200
0022000006000600s0000s000000j0j0jjjllllllllllltttttttttttttt000tt00066666666666666mmm0mmmmmm0500550555510011111010000000h0000200
000200600000000s00s00ssssjj0jjjj00jllllllllllttttttttttttttt07070d0d666666666666666m0mmmmmm0m00505550500101110001h000000hh000202
002000606000006ssssssss0j00jjjj0000ll0llll0lt0ttttttttttttt00000d00d0666666666066606mmmm0mmmmm55005005501111001110hh00h000000022
0020000000000600000sss0s0jj0jj0jjjl00ll00lllttttttttttttttdd077d0d0077666666666666660mmmmm0mmm5555550555011010100hh00hh00h000020
2020006600000600s0s0s0ssjj0jj0j0jl0llllllll0tt00tttttttttdddd707dd07777666666666666660mmmmmmmmm550055055110011000100h00000000020
02200000000006s0sssssssj0j00jj0j000llll0l0ltt0tt0ttttddddddddd00007777777776666666660mm0mmmmm0m550550555001010010000000000000020
002000600000000ss0s0s00jjj00j0jj0lllll0lllttt0tttt0tddddddddddd00777777777776666666660mm00m0mmmm55550505500010001000000h00000020
20200000000060s0s00s00sj000jj0jjl0lll0lllltttttt0t0tddddddddddd0d7777777777706600666660mmmmmmm0000555555501110001000000000h00020
2200060000000000ss000ss0jjjj0jj0lll00ll0ltttt00ttttdddddddddddd007777777777776666666606mm0m00mmm50000550000010011000h00000000002
02000000000000s0s0s00s0jjjjjjjjj00llll00lttt0tttttddddddddddddd007777777777777666666660mm0m0mm0m00555005500001010100000000000002
22000006600606000000s0sj0jjj00000ll000l0ltttttttttddddddddddddd707777777777777666660666mmm0m0mmm5555550550101000000h0h0000000002
0200000000000000ss0ss0sjjj00j000000lllllltttttt00t0dddddddddddd007777777777707660606660mm00mmm0m055550555110010001000hh000000002
22000600000000000s00s0s0000j0jj000llllllltttttttttdddddddddddd0000777777777777066666666mmm0mmmmm55500050010111111100000000000002
220006000060000s00s000s0jjjjjj0jl00lll0lltttt0ttttddddddddddd00000077777777777666666606mmmm0000m55500505510000100100000000000002
02000000000000s0s00ssssjj0j000jj0lllll00ltttt0ttt0ddddd0ddddd00000077777707777666666666m00mmmmm00050500550101111000000h000000002
02000000000000000s0ss0s0j0j0000jll0llll0ltttttttttddddddddddd0000007777707777706666666600mmmmm0m55000555510101000000000000000002
02000000060600000s0000000000000jl0l0lllllttt000ttt0dddddddddd00000077777777777606666666m00mmm0m050550505511101010100000hh0000002
020000000060060s000ss0sjj0j0j000l0l0lllllttt0t00ttdddddd0ddddd0000007777777777660606660mmm00m00m5000550050010111000000h000000002
220000000000060s0ss0000jj00000j0lll0lll00tt0t0ttttdddddddddd0ddd00777770777777006666666m0mmmmm0m50500500501110101100h00000000002
02000000000000ss00s00000jjj00jjjllll00l00tt000ttttdddddddddddd0077707707777077660600660mmmmmm0m050005050011000011000000000000002
02000006000006000s000s0jjjj000j0l00lll0l0tt0ttttttddddddddd00d0d007077777770776666666660m00mmmmm000505505011001100h0000000000002
020000000000000s00s00s00jjjjjjjjl0ll0ll0l0t0ttt0tt00d0d0ddddd0dd707077777770766006660600m0m0mmm005055555000011010100000000000002
22000000006000000ss0000j0jj0j0j0llll0lll0l00tttttttt00dd0d0dd0dd707777000777600660066600mmmm0m005055555550101101000000h000000002
2020000000060600s000s0s0jj0jj00jl00llllll0ttt00t0ttt00ddddddd00077777077777706660666000mmmmm00m055500055000001010000000h0h000020
00200000006000ss00s0s00jjjj00jj00l0l00l00l0ttttt00tttdd00dd0d00d77777070700660660666660m0m00mmm0555050500100110000000000h0000020
00200000000060s0000s0s0000jj00000l0l0l0lllltt00t0ttt00dddddddddd077770770760660660666m0mmm00mm0000000055110010100000000000000022
0020000000000000ss00s00sjj0jj00j0lll0000lllt0t000tttt0tdddd000d0d07700707066666666066mm0m00m0mm055005005110010001000000000000022
0020006006000000ssss0sss0j000jjjjj0l0l00l00ltttt000ttt0tdddddddd07777707006000666066mmm0000mm0000500050510001000000h000000000020
0020000000000000ss00s0s0000jjjjjjjl00l0lll00000tttttt0ttttd000d0777070066666666600000m0mmmmm0m0050055050010100010h00000000000020
020200000000000000000s0000jjj000jj0ll00l00ll00tttt0t0t0t0tt00t00t6666006066066066660000mmm0mm0000005550101000100h00000h000000202
0002000000006000s0000s0s00j0j0000jj0l000l00000t0t0tttttt0t0t0t00060606666066666666mm00mm0mm0000000005501000110110h00h00000000220
0022000000000000000sss000j0j00j0j00000llllll00l0t00ttt0t000000t066606606666660600mm0m000m00m505500555051000000000000000000000220
0002000000000000s000000000jj0j000j000lll0l00ll00tttt00tttt0t0t0t6666066606060000mm00m0mm0m0m550050050500000010110000000000000220
0020200000006000000000000000000000000l0llll0l00l00t0t00ttttt0t0t0066060000600000mmmmmm0mm0m5055005005001000000000000000h00002000
00002000000000000000s0s000000jj0jj00jjl0000l0lll0l0t0000tttt0ttt60666600666060m00mmmmmmm0m5550055505001010100100000h000000002200
0022200000060006000s0s00s00j00j000000000lll0000ll00l00t0000t00t0t0666066606mm0mm0m00m0mm0050005000505100110010000000000000002000
002202000000000600sssssss0s0jjj0j00000jjl0000l0000l00l00000ttt0006600000600mm0mmm0000m005000555500501010010000000000000000020200
00202200000000000000000000000jjjj0j00jj0jlll00lll0000l0l00ttt0000666666600m00mmm0mm0m0m05000500000500001000000h00000000000020020
0200220000000060000000ss0s000sj0j00000000j0000l0l000l0l00l000l00000000000mm00m0000mm0055505000005010011000100000h00h000000022002
002000200060000000000s0000ss000j00000000j0jl0llll000ll000ll00l00lm00m00m0m0m0mmm000m0500000005000501000011101h00h000000000202200
0000022000600000000000ss0ss0000jj0jj000j00j0000l0l00l00l0l0l00l00000mm0000000m000mmm00505000005051100001000000000000000000200200
0000000200000000000000ss00sss000j00j00j000jjjl0ll0ll0l0ll00l000l00m0m0mm00m0m0mmmmm005550005050011010000110000000000000002020002
00000022000000000000000s0000s00000j00j0j000j0j0l0l000ll0l0l0ll00lm0mmm0mmmm0m0m0050500000050505000000100010h00000h00000002202000
0020022020000000000060s0s0000s0s0s0jjjj0j0jjjj0j0lll0ll00llll0l00mmmm00m0m0mm0m0000000005505001001010101110000000000000020200200
02000200200060600000000000ss0s00000000000jjjjj00j0jl0000l000000ll0m000m00mmm005500005505005551010010001100000000000h000020020000
2200000202000000000000000s0000ss0s00j00jjjjj0j0000jjmll0ll0000ll0m0mm0m00m000550505050500000000011010001hh00h0000000000200000000
0000000022000000000000600s0s0s00ss000jj00000j000000000j0l00lll00l0000m0000500500050000000001000011010010h00000000000000200000000
000000002020000000000000000s0000s000s0000jjjj00j00j0j000j00j000jj05000000500050500000050000000010100010000000h000000002000000000
0000000000200000000000000000000sss000000j0j0000jj000j0j00000000j5000005550005000000005050100100000100000000000000000002000000000
0000000022020006000000000000s0000000000s00j000j0jj0jj000000j0j000550000505000000500500010010000010100000000000000000020000000000
00000000000020000000000000000s00000ss0s0s000jjj000j0000j000j0j000000000000500500000500001011100010110000000000000000200000020000
00000002000020000600600000000s000s00ss000000jj0jj000jjj00jjj000j5000000005500500000000000001000000000000000000000000220000000000
00000020000002000000600000000000s0s0000000000jj0000j00jj0000000j050000005500050000000001000001000100h000000000000002020000000000
00000000000020200006600000000000ss000ss00000s000000jj00j00jj0jj00005050000050550000000010100000000000000000000000020200000000000
00000000000002020000000000000000000000000000000s0000000j0000j0jj00000000000550000001000010000010000000000h0000000202000000000000
0000000000000022000000000000006000000s0000s00000000000000jjj0000j000050500100010000001000000000000000000000000000220000000000000
00002000020002202000000000000000000s00000000s00000ss0000s00000s00100000001010010000000000010000000h000h0000000002002000000000000
00020000000000020200000000060000006000000s0s0s00s00000000000s0000000001000000010000100000000000000000000000000020200200000000000
00000002000000202020000000000000000000000s0000s00s0000000000s0s00010000000000001000000001000000000000000000000202000020000000000
0000002000000002000200000000000000000000000000000000s00s000000000000000000000000000010001000000000000000000002000000002000000000
00000200000000002020200000000000000000000s000000s0000s0s0s000000000001010000000000000000000000000h000000000020000000000000000000
00000000000000000002020000000000000000000000000s000s0000000000s00000011000000000100000000000000000000000000202000000000000000000
00000000000000002020002000000600000060000000000000000s00000s0000000000000100000000000000h000000000000000002020200000000000000000
00000000000000000002000200000000000000000000600000s00000000000000010000001000100000000000000000000000000020202000200000000000000
00000000000000000000002022000000600000000000000000000000s0s00000000000001000000000h000000000000h00000002200000000020000000000000
00000000000000000000020020200000000000000000000000000000000000000000000000000000000000000000000000000020020000000000000000000000
00000000000000000000000000020000000000000000000000000000000000000000000000000000000000000000000000000200000000000000000000000000
00000000000000000000000000202200000000000000000000000000000000000000000000000000000000000000000000022000202000000000000000000000
00000000000000000000000002002020000000000000000000000000000000000000000000000000h00000000000000000202202000200000000000000000000
00000000000000020000000000000002200000000000000000000000000000000000000000000000000000000000000022020020000000000000000000000000
00000000000000200000000000002022022000000000000000006000000000000000000000000000000000000000002200002000000000000000000000000000
0000000000000000000000000202002002022000000000000000000000000000000000000000h000000000000000220200000200000000000000000000000000
00000000000000000000000020000200200002200000000000000000000000000000000000000000000000000022002000000000000000000000000000000000
00000000000000002000000200000000020020022000000000000000006000000000000000000000000000002200200002002000000000000000000000000000
00000000000000020000002000000000000000020222000000000000000000000000000000000000000002220020020000000200000000000000000000000000
00000000000000000000000000000000000000002220222000000000000000000000000000000000002220222020000000002000000000000000000000000000
00000000000000000000000000000000000000020200200222200000000000000000000000000022220200002202000000000000000000000000000000000000
00000000000000000000000000000000000000000002202020022222200000000000000022222200022000000000200000000000000000000000000000000000
00000000000000000000000000000000000000000000000000002002022222222222222202000220000000020000000000000002000000000000000000000000

