pico-8 cartridge // http://www.pico-8.com
version 32
__lua__
-- horizontal burn
-- alexthescott
-- 9/2/21

p={8,136,130,11,139,131,12,140,129}
pal(p,1)

-- set btn delay
poke(0x5f5d, 30)

function new_screen()
	s={}
	for i=0,128 do
		add(s,i)
	end
	return s
end

function new_beam(c)
	if #screen<1 then
		screen=new_screen()
		global_index+=3
		global_index%=9
	end
	
	point=screen[1+rnd(#screen)\1]
	del(screen,point)

	b={}
	b.c=c
	b.d=rnd(2)\1
	
	-- left, right
	if b.d==0 then
			b.x=127
			b.y=point
			b.dx=-1
	else
			b.x=0
			b.y=point
			b.dx=1
	end
	
	b.draw=function(self)
		pset(self.x,self.y,self.c)
	end
	
	b.update=function(self)
		self.x+=self.dx
	end
	
	b.destroy=function(self)
		if self.x<0 or self.x>129 then
			del(beams,self)
		end
	end
	
	add(beams,b)
end

function burn()
	for p=0,256 do
		x=rnd(128)\1
		y=rnd(128)\1
		pc=pget(x,y)
		if pc!=0 and pc%3!=0 then
			if rnd(2)\1==0 then
				pset(x,y,pc+1)
			end
		elseif rnd(3)\1==0 then
			pset(x,y,0)
		end
	end
end

screen=new_screen()
beams={}
global_index=1

cls()

::♥::
if t()<2 then
	print("horizontal burn",34,64,1)
else
	burn()
	
	if t()%0.125==0 then
		for i=1,2 do 
			new_beam(global_index)
		end 
	end
	
	-- diy beam
	if btnp(4) or btnp(5) then
		for i=1,4 do 
			new_beam(global_index)
		end 
	end
	
	for b in all(beams) do
		b:draw()
		b:update()
		b:destroy()
	end
	
	flip()
end
goto ♥
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__label__
0j0j0j00000b00bj0j000j00000000r0j0brjjjj00rr0rjjj00j00j00j0j0r0rj000b0j00bjr0000jj0j000j000j0000000000r0j00j00j000jj0j0000jj000j
j0jj00jj0j00j000jj00jj00000j00bj0000jj00j00000jjj0j000jj0jr0j0j0r0rj00000jj0rr0j0000jj0j0jjrj00j00j00rj0j00j0rjj0jj0jrjjj0j0r000
0000b000000000000000000000000000000r00r00000000000000000000000000000000000j000000000j0000r0000000000j0000000j0r0j000000j00000000
jrj00rr0b00j00jjj0jrjrbjbrbr000brrb0rrbjj0jjjrbjjrbrb0jrj0rj0jb0jbjrj0r0j000jr0jbr0b0000jb0jr0jj0jj0j000j0rjr0jjbr0j0000b00000jb
000r0j00j000000000000000j00000000000000000000000000000j0000000000000j0000000000000000000000000000000j0000000j0000000000000000000
0r00000j0000r000000000r00j0jj0000000jj0j00000000j0000jj000000jjjj00b0jjj00j0000jj000j000000jj00j00jj000j00jj0000j00000000000j00j
0000j00000jj0j00j000000000000000000000000j000r00000000j000000000j000000000000000000j00000000j000jj0j000j00r0j00000000j00j00j0000
j0jjjj0b000j0rjb00jrrbrbjr0b00jjr0jj0jjjr00jjrj000rjbrrj0000j00b0b0000r0bbrb000j0j0jj00rj000b00000r00j0j0jj0jbb00rjrbj0000000000
00000000000000000000j0000000000j0j000000000000j000000j0000000j000000j00j00000000000000j00000000000000000j00000r000j00j00000000j0
cccccc0000000000000000000000000000000000000000000j000000000000000000j000j000000000000000jrj0j0jj000000j000000000000000j000000j00
000000j000000000j000000000j00j0000000000000000000000000000000000jj00000000j0j00000j00000j00000000000000j0000j000000000000j000000
0000000r0jrbr0bjrjjj0jjrr0rrb000jj0rrrrbbrj0rjrb0jrrjjj0rbbr0rj00jjbrr00rjr0r0bjjjj00r0rjbjjbjrrrjj0r0j0rbjbrjjrrbrbr0bjjr0b0jjb
bbjrjrjrjr0jrr0b0rjjjrjj0brrrbjbrbjr0r0rjjrbbbbjrjjrbrr00rjrbr00rrjbbjrbrjjbrjrrjrrr0jr0bbbrbbbrrjbjjjrbrrrbrrrbbjrbbjbbrr0rbjrj
0000000000000000000000000000000000000000000000j00j00000000000000000000000000000000000000000000000000000000000000000000r000000000
jbrrrrbrrbjbjbbrrrrrbjrbbrbrbbjbbrrrbbbbrbrbrbbbbbrbrbbrbbbbrbbbbbbbbbbbbbbbbbbbb000000000i0i0000i000000000000000000000000000000
00j0j0000j0j0000rj00000j0000j000000000j00000jj0000jr000j0000000jj0jj000r00jbj0j00j00j0jjj000r0jbb0j00j0j0j000jj000rj00r0j00j00j0
000000000000000j00000000000000j00000000000000j00000j00000000000000000000000000000000000000000000000000r00000000j0000r00000000000
00j00jr0000000r000j0000000000r0j00jj0000000000j000000j00000000000000000000j0000000000000j0j00000j0000000000j0000000000j000000000
0b00j00jj00j0000jj0b0j0j000000jj00000j0j00jjjrj00j0j0000000jjjr00j00jjjjj0jjj00j00jjjr0jjr0jj0j0r0jjjj0bj0j000j00j000j0r00000j0j
b0jrj0j0j00j0r0r0jb0j0j0000j000bjjjr00j000jrjrj00j0j00jjjj0j000jj00jr0000jr00r00000j00j00j000000j0000000jj0j000j000000j00r00r000
00r00j00j00000b00000r00jj00000j00000000j0000000r0j00j00000b000jj000000000r00j00000000j00000j0000j000000000rr0000j00000000j00j000
00000000000000j000000000000000000000000000000j000000j0j00000000000000j0000000j000j000000000000b000000000000000000000000000000000
0000000000000000r0000j0000000000000000000j000rj0000000j0000j0000000j00j0000j00j000000j000000000000000000jj00000000j00000j0000000
000000000j00000j00rj00j000000j000000000000r000r000j0j0bj0000000j000000000000000j0000000j0000000jj00000000j0000000000000000000000
0jjj00jb000r00j0j0r00j0j0j0000jj00000rjj0j0j0000j0000jj0jjjj000rjj000jr0j00000000rr0j0000000000jjr0000000j0000j00000j0000b000000
000000000000000000j0000000000000jjj0000b0000000000jj00j00000000000000000000000j000000j00000000j000000000000000000000000000000000
000j000000000000000j00000000j00000000j00000000000000000j0000000000000000j0000000000000j000jj000j000jb000000000j000j000000000000j
sccccccccccscccccccccbrbrrrbrrbrrbbbbjjbrrbrbbbrbrrrrbbrbrbbrjrrjbjrrrbbrbrjbrrjjbrr0bjbbbbjrrbbrrjbjjbb0rrrjr0rrrr00rjb0jjbrjj0
br0jrrbjbrjjjb0jrrjbr0bjrbrrjbrrrr0rrrbrbbjb00bj00bjjjrrjb0rjbjbrjj0rjrjj0bbjbjjj0jjr0rb0jjrjrbbr0rjr0rj0rrrjj0bbrj0rjr0r00r0jrr
0000000000000r0j000000000000jj00000000000000000r0j000j000000j0000000j000jj00000jj00000rr00j0000r0j00000000000000jj000000j00r0j0j
bj00rjbrrjr0bbjbbjjrrjbb0rbrbr0j0brr00jjjj0brj0rjr0bbjb0j0rrbjbbbjb0r0rjr0jj00bbrr0brrrr00rj0jj00bjr0j0bjb00jr0bj0jjr00r0brb0bjj
jbb00j0rb0jjjjjjjr00j0jrrjr0rj0000jj0j0jjr000b00bj0rb0rrrjj0b00rrr0r0000bj0r0rjjb0jrjjj0jjj00rj0rrjrjbr0000j00jrbr00j0j000r00jj0
00r0000j0j00000j0j00000jrj0jj0jj000jr000000j000jjj00j000r0000j000j0j00000j0000j0000000j0000j0000000000000j0000000jr00000jr000000
0b0jr00j000000j000000rj0j0000j0j000r000j00j0000j00j0000r0jj0000r0000j000j0j00r000000r0000r000j00000j0j00jj0rb000jj0jj0j00rjjrr00
00rjrjjjrbr0b000r0rj0rjj00000jrj0jjj0j0j0j0jj000r00j00j00j0j0j00b0j00jjj0rjjr00jr000j000000jj0jjj0jj000j0r0jr0bjjj0000jjj000j0j0
j0jrb0j0bjjj0jjrbj0jrj0j00r00jjrrjj0000rj0jj00jr0jj000jj0jr0rj00jjjjjbrj00000j0000b0jrr0000000000j0r0000r0000000rjrjj0000r00rj00
bjbrbbbbbrbbrrrjjrbbrbbbrrjrbrjbbbrjbbrrbbbbrbbbjrrr0rj0rb0rrbb0bbbbrjrbjbjrrbb00rrbrbrrrbbrrrrrbbjrbrbrbrr0jbj0bjbrbrbrbr0rjrrb
000000j000j000j0000j0j000jj0j0j0000000jj0j0000j0000rj00000000r00j00000r00j0r00000r000j000j0jj00r000jj00jr00rjjjr00j0j0r0j000j000
00000000jjj000000000000j00rj00000j00000000j000000000000j00j000j000j000j00jr000j000000j00r00000000000j0000000000j0j00000000000000
rj0rrbrbbbrjrb0rrrrbrjrjrrrjbbbjrb0rrrbrbbbrrbb0jbbbbrrrrrbbrbbbbjjbrbjbbbrrbrbrbbrjbrbrbbbjbrrbrrrjbbbbbbbrbbbbbbbbbrbbbbbbrbrb
0000000000000000000000000000000i000000000000000000000000000000bbbbbbbbbbbbbbbbrbbbrbbbbrbbbbbbbbrbbbbbbrbrbbbbrbrbrbbbbbbbbbrbbb
00000000000000000000000000000000000000000000000000000000000000j00000000j0000000000000000000000j00j0j0000000000000000j000000j0j0r
b00000j0rrjrj00j0j0rjr0j0rjb0rjjj00br0j00j0bbj0jjjj0r000jjjjj0r00000r0rb0rjjrrj00j0j00rr00r0r0r0rjj0jjj0r000j0j0b00jj0rjb00000j0
j0000000j00j000000000000000j000000j00000000000000000000000000j0000000000000000000000000000000000000000000000j0j00000000000j00j00
jjjjjbbbjrbbjrjbbjjjbrbrjjbrrrr0rbbrrbbbbbrbbbbbbrrbrjbbbbbrrbbbbjbbbrbbbbbbbrbbrbbbbbbbbbbbbbbbbbbbbbbbrbbbbbb00000000000000000
0j000000000000000000j000000000000r0000j00000j00000000jj0000000000000jj000000000j000000000000000000000000j0000000000000000jj00000
j0000j0j0000r0rr0j000j00j0jb00j00j000j0000r00rbj0j0r00jj000j00jrjj0000rj00bj000000jj000jb0j00jj00000r0j00j0j0000000j00j0rrrbrjj0
cccccc00000j00000j000000000j000j000000j000000r00000j00j0j000000000000000j000j0r000000000j0r00000000000j0b00j00j0j000j00000000000
000r0000000000j000j000000j00j00000000j00000j0000000000000j00000000j00000000j0j00000r00000000000000j00000000000j00j00000000000000
00000000000000000000r00000j00000000j000000000000000b0j00j0j00j000000000000r00000000000r0jj0jr0jr00j0000j00000j0j00j000j0j0000000
000000j00000000000j000r0r00j0000j0r0jj000j0j0j0jj00000r00000j00j000000000r000000000000r00000r000r00000000000000000jr00jj0000j00j
bb00bbbjrjjbbrrbjjrjbrbjbrbrbbbrrrbrbrbrbbrrbbjjrrjbbbrbbbrrjbbbrbrbbbrbbrbbrbbbbrbbbbrjbbrbrbbbbbrbrbbbbrbbbbrbbbbbbbbbbbbbbb00
0r000j000j00j0jj0j00r000000jj0jj0000rb00j00j000000j00000jj000000jr00jr00jjr00000jr00r00000r0j000rj0br0000jrj00rr0rj0000j000rj00j
brrrrb0bbjrbjbbrrbrrbrbrbbbrbbbrbrbbbrbbbbbrbbbbjbbbrbbrbbrbrbbbbbbbbbbbrbrbbbbbbbbbbbbbbbbbbbbb00000000000000000000000000000000
00j000000000000000j000000j000000000000000000000000000000000j00000000000000000000000000000000000000000000000000000i00000000000000
0r0000000000j000r00j000j000000000000j0j000j0j0000j0rj000j00000000j00j000000j00000j0000000000jjj0j0000000000j0000000000j000000000
0jrj00000jjj0j000j00000r00jjj00jj0j0jj0j00jj0jrb00jjjj00rj0000j00000000j0jjj00rjjr00bj00jj00rj0rjj0jjj0r0rrr0r0000j0b0jjjj00j00j
bbbbbjbbbbbbbbrbbbbrbrbbbbbbbbbbrrbrbrbbbbrbbbrbrrrbbbbjjrrjbbjbbbbbjbbrrbrrbjbb0rrrjbjrjrrrrrrjjrrrbjrrrbbjjrrjjrrjjrrbrrjjbrbr
0j00000000j0j000j000000000j000jj0j00000000000000000j000000000r0000j00000j0000000j000000000000000000000j00000000000000000j0000000
0000000000j000000000000000000000000000000000000j00000000000000000000j00000000000000000000r0j0000000000000000j0000000000000000j00
bjbrbrr0rbrjbjrr0jrrjbjrjjjj0jrjbr0jrjrrrb0jjjjrjj0jjb00r0r0b0brrbbrjbbb0jj0brrjbjb0bjrr00bbrbbbrrjbbjjrbbbjb0jrbrbbjbjbr0b0rrrb
00b0j00jr0j000000jj00000000000j0rj0jrj00000jj0000b00j0jj0000000j00b000000jr00j00jjj00j0000j0b0b00jr000rj0rj000rb00j0r0r000r00b00
00j0r00000000000rjj000000bj0000000j00000j00j00j0000000j0jjbj0000000j00j00000j000r00000rjj00j0000j00000000000000000j0000jj00000j0
00000j000r0jj0jr000000r0r0jj000j000j0000000j0jb00j00r00j0jj000j00j00b0000rj0000jj0jj000000000000r000000000j000000j0j0j0000r00000
bj00rrjrj0jjbrbrr00jrbjrjb0j0jjjrrrbrbbrrrjrbrjjb0jbbbbrjb0brbrrrjbjrrbrrbrjrb00bbjrrb0rjbrb00jbbrrrrjr0brjjjj0rrrrrrrbjbrbjbrjb
00000000j0000000000j000000000000000000000000000000000000j0000000r00j00r000000j000j0000000jj00j0000j00000b000000r000j0000j0000000
j0br0jr00jbjr0r0r00jjjjjj00jjrj0jjj00r0bjbbrjjj0jjj00brj0jjj00jj0jj0b0000jr0j000rj0br00rj0j0jj00j0jjjj0r0bjjj0jjjjrrr0rj0jbjj000
000j00000j0000j000j0j00000jj0000000000r00r0j00000000j00000j00rj000j0j0r0j000j00j0000rrj00j00j00j000rjj0j000jj00j0j0j00000000r00j
j0000j00000r0jj000000jj000000000000r0jj0j00j0j00000000rj00jrj0000000000000jj00000j000000000000j00j00jr0000000000j0j0rjj00000j000
00j0jj000000000j0000000000j0000000000000000000000j0j0000j0000j000000000000000000j0jr00j0000000j00000000000000j0000000j0j000j0000
0r000000jj0j0000000000000r000000r000000000r00j000jj00000j0000j0j000000000000000000000j0r0r00j0j00000000000000j000b00000j0b000000
rbb0j0rrbrjjbbjbbrbbjbrrb0j0bbrbrbrbbrbjrrbjrjrjbb0jjrrjbrbb0bjrrjrbjrrrjrrrrrjbrbbbbbjbrbbbrbbrbbrbbbbb0brbrjbbrrjrrrrbjbbbbbbb
rrjjr0rrjbrjrbbrrrrbrrbbjrb0rrrbbrbrbrbr0rrbbbbrbjbbbjrjr0jbrrbbbjbbrjrrrbbrrrrrrbbbb0bbrbbbbbbbbbbbbbbbbbbbbbbbbbbbbrbbbbbbbbbb
0000000j00j000j000000000000jj0r000j0000000000000j0j000000000000000r0000jj00j00000000000000000j00rj0j000000000000j000000j000j00j0
rjrjrjbb0rrb0brb0rr0rbb0rrb0jrbjjjbjbb0jbrrjbrbbbrbrjbjbbbbbbbbrbrbbrrjrrrbbrrrbbrrbrbrrrbbrjbbbrrrrjbbbrrbjbbjrrbbbbbjrbbbbbbbb
jrrrbrr0jrrrjrbrrbrbrbjrjrrbbbb0bbjjbbbbjrbrjrbjbrrbrbjbbbjbrjrrjbbbrbrbbrbrrrrbrbbrbbbrbbbbbbjbrbbbrbrrbjbbbjbbrbbrbrbbbrbrrbrb
000000000j000j000000000000000000000000000000000000000000000000000000000j0j000000j00j00000000000000000jr00000000j00jj00000j00000j
rjjrbr0j0rbj0brb0jjjjbb0jrrrrjrrrbrjbbjjjbjjjjbrbrjjbrjbrbbbjrbjrbbrbbrjrrbjrrrrbj0brrbbrrrrjrbjb0rbjbrbbjb0rbrrrbbjbrbrbbbjbbbb
0bjj0jj0j0j0jr0r0j000jr0r0r0r0j0j0000j0rjjj0bjbjrrb0jj00000jjjjjr0j000j0j0rjrj0jjj000b000jj0jjj00jr000r0bj0j0jrr000j000jrj0jj000
r00rjjjjj0jj0b00j0j00b00000j0jrr00000r0jb00j000jr0jj000jr0jj0000000000jb00j0j000jj0000r0000j0000jr0jr000000000000000j000j0000j00
rj0rj0jjjjj0j0j0j0j0jr0rrj00j00j00j0r0000r0000j00000jjjj0000000j000rr0jjj0000jj00jj000r0j0000r0jj0rjj0j00rjjj0jjj0r0jj0j0r00jjjr
jb00r0r0000j0jj0j0000j000jbj0000000j0jj00j0r0j0j00j0j00j0j0j00jj0j0j00rbrjbjjjjj00r0j0000jjj0j0jj0jj0jj00jj0jrr0j0jj00r0000j0jjr
00j0rjj0brjr00j0jrr0rrrj0rb0rrb0rr0jrb0jjjrrr0rrj0bjr0bb0rrj0bj0rjj0j0jbr0rrbjrrjrjjb0r0r0j0rjb0rjrrrbrrrrbjrjjjjrrrrjrbjrjrrbjr
00000000000000000000r0j00000000000000j00000000000000r00000j0000j00j00000jj00j000000000j000j000000jj00j000j000jjj0jb0j0r000jj0jj0
000000j000j0000r000000j0000j0000000000000000000j00000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000i0i0000i00000000000000000000000000000000000000
0000000000000000000000000000j0000jj000000000000j0000j0j000000j000000j00000jj0000000000b000000000j000000000000j0j00000000j0000000
00000000000000000000000000000000000000000000000bbbbbbbbbbbbbbbbbbbbbbbbbrbbbrbbrbbrbrbbrbbbbrbbrbbjbbbbbbbbbbrrrbbb0brrjbbbbbrbr
jr0rjb0j00jjb0b0rjrj0rr0rrrjjbjjjbjjrrrjbrjr0br0jrjjjjr0j000000rbrr0jjjrrbj0jjr0rjjr00r0jr0jj0jjjb0b00j0rjjrjjj00jjj00jr000j0r0j
000r0000r00bj0j00j00j00j000j0j0jr00j00000j0000j00jjr0j000000brj000000000jj00000r0rj00jjjj0j00j00r00j0000000rjjj00j000000000r0000
0j0jrrjjj0000r0jr00jjjrj0j00r00jjjjrj00r00jr00b0rrjjjjjrjjj00j0jjj0rjjjjjjrjrjj0j0br0j0jjrjb0bjj00jbjrrj0j0rbbj0jr0jjrrj00j00jj0
bjbbbjbbrjrrbbbbjbbrbbbbbrbbbbbbbbbbbbbbbbbrbbbbbbbbbbbbbbbbbbbbbb00000000000000000000000000000000000000000000000000000000000000
00j0j000jjjj00bj00jj0000000j0jj0jjj00j00r0000j0jr0jjjj00jr000j0j00000jr0000j000r0000jj0j000r000bj0j000jb00000r0bj0j0j00rrj00j0r0
j000j0rj00rjj00jj00000000j0jr0jjj000jj00r00000j000jj0000jj00000000jjjj00jj00j00j000jr000jj00r0j00000j0jrr0j00j00000000000j0000j0
b0r0j0b0jrrr0jrrj0rbjjrrrbj0000jjrjjbjrjj00bbrjjj0r0bjjr0bj0b0rrbbjr0jrrjj0jrj0rjj0j0jj0b0jjjr00rrjr0jj0j0jr00000rbjj00bjjrjjb0j
rj0rj0r0r0jrrjbj0j0bbb0jbjrjjr0jjj0jb00bb0jjb0r00rj00j0b0rj0rjr00br0j0j00b0rjbjjjjj0brjjrrrjr00r0jbjjr0brrjrrbjj0jbrbj00jjrbjj00
0bjjrj0bj0rrrjj0j0j0jjjjrbrjjrrj0jjbjj000rj0rr000jjr000j00j00jb0r000b0000jr0jjr0jjr0r0000rj0jrj0r0jj0jr0jjj00j00j0jjrr0jj0jjj000
bbrjrbbbjbrrrrrbbbrbrbbbbbrbrrrbrbjjbjbrrbbrjbrrb0rbbrbrrjjrrbbjbr0jjjr0r0000j00jjbrbbrrjrrjr0bjrrrjjjjrjjrj0rjbjj00rjjj0jbjbrr0
j000jj0jr00j0r00rrbbj0jb00000000bb0jjrjj00j00j0rjjjjj00j00jrbbjj0r0jbjrrr0jjjjb00jjr000jjbrrcccccccccccccccccccccccscccccchcccsc
rrjr00jbrrb0r0r00rjjr00j0jbbrjjbbjrrrjr0rjrrj0b0bbrrrjbrbrrjbbr0rrjr0jrb0bjjrbrrrrrrrbr0jjr0rbj0rbjrbrrbbjbjbrrbjrrbrbbjbbr0jbrj
0j0jrjr00bjjbrrr00000jr0bjjj0jjjjrjjrjj00jb0jbr0brjb0j0rrrb0bbjrjbrrbjjbbbrrjbrjrjjrbr0brjjrjbrrjj0bjr0rrbbbbrjjb0bjrbbj0jjrrj0b
0jj00jj0j0000jj00rjj00jr000br000j0000000jj0000bb0j000000j0j0000000j0jr00000j000000jj000r00000r000r0000000j0000000j000000j0r00000
bbbjrbbrrrrbbrbbbbrrrrbrbbjjbbbrbrbbbrbbbrrbrbbbbbrbbrbrjrbbbbbbbbbbbrbrbbbbbbbbbbbbbbbbrbbbbrbrbbbbbbrbbbbbbbb00000000000000000
j00000j0000000000j000j0r0j0j0000j0j0j0000j000000r0j0j00jj00jjr000000rj0j0j00000000000000jj0000j00000j0r000j00j0rj0j00j0000b0j000
0rj00000r00b00000jj0000b0000jj00000000j000r00000jj00000rj0jr0000j0j00jj0rjjj0j00000000000j00000jjj0r00j00j0rj000000j0jrjb000rrj0
00i00000000000000000000000000000000000000000000000000000000000000000000000000bbbbbbbbbbbrbbbbbbrbbbbbrbbrbbrbbbrbbbbrbbbbbbbbrbb
000rj0r00000bjj0j00bj00jb000rj000j0rrjj0jrr0r0jjb0b00r0000rjrjrbrjjjj0rj00j0rrrj00jj000r0000jj0r00r00j0000000rjrj00r0j00jjjj0b00
jb0j0j00r0j00r0jjrjb00b0jrbrr0rb00bjr0jbrrjjbjjb0r0j0jrbj00j0bj00000jb00r0j00brbrr0bjb0rjjrrjrbjr0jjrjr0j00rjrbjrrrb0rr0rrrjb0bb
rjj0j0r0r0jrrjjb0j0rjjbrjjjjr0rr0rbrjj0jbjr0rrj0rbrrjrbrjjjbbbbrjbbrjj0rrjrrjrjjjrbrjbbbrrrbjbbrbrjjrbjrbjjbjrrjjjbrbbbrjrbjbj00
00000000j0000000000000000000000000000000000000000000000000000000j0000j000000000j00000000000jbbbbbbbbbbbbbbbbbbbbbbbbbrbbbbbbbbb0
brbrbbbbbbbbbbbbbbbbrbbbbbbbbbbbbbbbbbbrbbbbbbbbbbb00000000000000000000000000000000000000000000000000000000000000000000000000000
jr0rbbjjrjj0rjbrr0rrrr00rjrrjrb0brjb00jrjbjrjrrjr0rjjjr000jrj0rjrjbjrbrrjrr00jr0jjj00br0j0rbrr000jbj0jrb0rjb0bjbrbr00rjjrrr00r0b
0000000000000000000000000000000j000000000000000000000000j00000000000000000000000j000000j000000000000j00000b00j0000000000000000j0
j0000j0jrj0b00j0j000j000r00r0j000j00j0j0j000rj0000j0jj000j0000r0000000j00rj0jr00000000000000000j000j000000000rj000j00jr00j000000
j000j000j0j0000000j0r0jjj00000jj0000000j00000000000000000j00b000j0r00000j0j0000j00000000jj000000000000j0000000b0000j000j0j0r0000
000jj0r00000j000000j00j00000jr0000j0rr0b0000j0000jj000j0000000b0000000rj00j00r0000j00r0j00j000000j0000000000r0j00j0000000j00000j
j00b0rrjrrjr00jrjrjrrbjbjjbrbrb0rbbrb0jjjrjr0rrj0jrrjb0rbr0jrbjj0rrrjr0bb0bbrbjjrrjrrrjrjb0rjjbjrbbbbrrbjrbjrrj0rrr00rjbbrbjrrbj
jj0000j000j0000000j00j000000000000jj000000000000j0000j00r0000jj0000j000000000000000j000000000j0000j0j000000000000jjj0000000000j0
cccscccccccccccsccccc000j0r000jjjj000j0j0b0jj0jj0r0j0j0000jjb0jj00jjj00jrb0r0jj0j0jjr0000j0j00000000j0j00j00000jr000000brbj00000
rjjrbj000rj00j0j0rj000jrj0r000j0000r00r00jjrjjjb0rj0jbj0000jjrrrr0rrjjb000jj00j0jrb00jjj000jrrj0j0jr0bjjj0bj0rjj0rjb0jjr00jr0bjb
bjrbr0rj0j0rrjjjjb0000bj0j0bjbjjrjb00brrjb00jrr00jjb0j0jrjr0jb0rj0rj0r0jrrjj00rjrb0brrrjr0b0bjjrjb0rj0rjrbjjjjjrbj0j0rbj0j0rr00j
00000000000000000000000000000000bbbbbbbbbbbbbbbbbbbrbbbbbbbbbbbbbbbbbrrrbrbrbbbrbbbbbbrbbrrrbbjrbbbrbbbbbbbbjbbrbbbrbjbbbbbbrbbr
0000000000000000000000000j000000j0r00000000000000j00000000000j0000000000000000000000000000000000000000jjjj00000000000j0000000000
rbrbjrr0bj0r0rjrrrrrrjjb0brr0bbrj00jbjbbjrjbjbrbjrrbrbrbb0jbr00rjj0rrjbjjj0r0jrr0jrr0bbrrjrbjjjr00jrbbr0r0bjj0jrjj0rjjj00jrjrrb0
r00rrrjbrrrrjbjbjrjb0bjrr00j0bbjbb0rjbbrbjbrrr0rbbjrb0rj0jjrjbrjbbjjjbjbbrjrrrjbjbjbrbbrrrjbbbjbrbrbjbj0brj0r0rbbbb0rb0bjbbrbrbb
jbbrbbbbbjbbrrbbbbbr0bjrrbr0bbbbbbrrrbjrrjbr0b0rbrjrjjrjrrb0jrrjr0brbjjbjbbrb0bbjj0bbbjjbrr0jrjjjjjrjrj0bjjjrrbbrj00rbjrjrrjjrjj
00bbbbbbrbbbbbbbbbbbrbrbbbbbbbbbbbrbbbbbbbbbbbrbbbrbbbrbbbbbbrbrrbbrjjbjbbbrbrbjjbbrrbbbbrrrbrrrrr0bbbbbbbb0brjrjbbbr0rbrrbbbrrr
00j00000br0000000j00j0000r0000000jrrjjrj00j0j000j000j000j0j00jj00j000b0j00j00j00j000j0000j0rr000j0000000j0rj0br0000jr0rj000jjr0j

