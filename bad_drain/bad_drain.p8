pico-8 cartridge // http://www.pico-8.com
version 33
__lua__
-- bad drain
-- alexthescott
-- 9/13/21

-- z/x changes direction

p={8,136,2,11,139,3,12,140,1,7}
pal(p,1)

function new_center(col)
	-- circle shrinking effect
	c={}
	c.r=95
	c.col=col
	
	c.new_color=function(self,col)
		self.col=col
	end
	
	c.update=function(self)
		dif=-self.r/50
		self.r+=dif
	end
	
	c.draw=function(self)
		if self.r<12 or self.r\1%2==0 then
			circ(64,64,self.r-4,self.col)
			circ(64,64,self.r-2,self.col)
			circ(64,64,self.r,self.col)
		end
		
		if self.r>10 then
			-- lines towards center
			for i=-2,3 do
				line(i+64,-32,64,64-self.r,self.col)
				line(i+-32,64,64-self.r,64,self.col)
				line(i+64+self.r,64,160,64,self.col)
				line(i+64,160,64,64+self.r,self.col)
				line(i+0,0,64-self.r,64-self.r,self.col)
				line(i+128,0,64+self.r,64-self.r,self.col)
				line(i+0,128,64-self.r,64+self.r,self.col)
				line(i+128,128,64+self.r,64+self.r,self.col)
			end
		end
	end
	
	add(centers,c)
end

function new_particle(c,dir)
	p={}
	p.p={}
	p.c=c
	p.s=4
	p.a=rnd(1)
	p.av=-0.0001*(1+rnd(40)\1)
	p.r=91
	p.rv=1
	p.ra=0.00015*(dir*2-1)
	p.x=64+cos(p.a)*p.r
	p.y=64+sin(p.a)*p.r
	
	p.draw=function(self)
		-- draw trail
		for i=1,#self.p-1 do
			a=self.p[i]
			b=self.p[i+1]
			line(a.x,a.y,b.x,b.y,self.c+1)
		end
		circfill(self.x,self.y,self.s,self.c)
	end
	
	p.update=function(self)
		self.a+=self.av
		self.av+=self.ra
		self.r-=self.rv
		self.x=64+cos(self.a)*self.r
		self.y=64+sin(self.a)*self.r
		
		-- shrink particle circle
		if self.r<25 then
			self.s=1
		elseif self.r<40 then
			self.s=2
		elseif self.r<60 then
			self.s=3
		end
		
		-- add trail points
		local pnt={}
		pnt.x=self.x
		pnt.y=self.y
		add(self.p,pnt)
	end
	
	p.destroy=function(self)
		-- destroy @ center of screen
		if self.x<=65 and self.x>=63
					and self.y<=65 and self.y>=63 then
				del(particles,self)
		end
	end
	
	add(particles,p)
end

function burn()
	for i=1,200 do
		x=(rnd(64)\1)*2
		y=(rnd(64)\1)*2
		x=rnd(128)\1
		y=rnd(128)\1
		
		if x<64 then
			dx=2
		else
			dx=-2
		end
		
		if y<64 then
			dy=2
		else
			dy=-2
		end
		
		pc=pget(x,y)
		if pc%3!=0 then
			circfill(x+dx,y+dy,1,pc+1)
		end
		if rnd(1)<0.4 then
			circ(x,y,2,0)
			pset(x,y,0)
		end
	end
end

particles={}
dir=rnd(2)\1
global_color=1+3*(rnd(3)\1)
fc=0

centers={}
new_center(global_color)

cls()
::♥::
if t()<2 then
	print("bad drain",46,64,global_color)
else
	burn()
	
	fc+=1
	
	if fc%3==0 then
		new_particle(global_color,dir)
	end
	
	if fc%800==0 then
		fc=0
		global_color+=3
		global_color%=9
		new_center(global_color)
		
		if #centers==3 then
			del(centers,centers[1])
		end
		
		if dir==0 then
			dir=1
		else
			dir=0
		end
	end
	
	for p in all(particles) do
		p:draw()
		p:update()
		p:destroy()
	end
	
	for c in all(centers) do
		c:draw()
		c:update()
	end
	
	circfill(64,64,4,0)
	
	if btnp(5) or btnp(4) then
		if dir==0 then
			dir=1
		else
			dir=0
		end
	end
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
88880000000008000000000000000000800000008800000008888888888888888888080000000000080000008000000000000800000000000000000000000088
88888000000000000000000000000000000000000008000088888888888888o8880o0000000080o0000880000000000000080000000000000000000000000888
8888880000000000000000000000000000000000000000088888888888888oo888ooo00000000000800000000oo0000000000000000000o00000000008008888
0888888000000000000000000000000000000000000000088888888888888oo8880o0000000000o00000000000o0000000880000000000000000000000088888
0o8888880000000000000000000000000000000000000088888888888888o0o888000000000o02000800000000000000o0000000000000000000020000888880
00088888000000000000000000080000000oo00000000088888888888888o0088800000000800200000000000000000o000o00000000000000000002088888o0
000o88888000000000000800000000oo000o0000000000888888888888220228880o00002020000000000000000o000000080000000000800000000o88888o00
00002288880000022000000o00000000000000000000008888888o88022202288800000008008000002000000000002000800000o0000000000000o88888o080
00002008888000o2o0000000002000oo000o0000oo000o088888o800002000088800000000000000o000000000o0000000o000000o80020000000o88888o0008
000000008888000000000000000800000o000000o00o000088880088000000o88820000000000000000000o000o00000000000020008028000000888888o0000
00800000o8888000o00000o002200o000000000000000000080oo0000000800888000000000000000000000000000000000000220o0008000000888820000000
000000000o88880000000000020022008000000000000000o000o2280000000088000000808000000080000000020o0080000000o00o008000o8888000000000
080000000008888000000oo080o02020008000022000000000002220000000o088000008000000000000800000000200000000000oooo0000oo8880002000000
000o0o0000008880000o0000008022228000o00200000000000002200000000088000000888800oo00o0ooo08000000880000000020o08000o88800000000000
00ooo00000000888o0oo020000000o00000o0o00000000000808002000800008880088000000088o0ooo8o000080008000000000222000000888000000000000
000o020000000088880o0208008000000000o80000800008000o080000000000800000008808800000o2000000000008000000000200000088800000000o0000
000o000000000008880802220o0000o000o00022oo00880000000000000000o080008800000008080o0o000o00008800080o0000000000088o00000000000000
000o02000000800088800000oooo00o000800820o000008o800o0000000000o080000008880800000800o0o0o088008o0o0o00oo000000880000000002000000
000o002o000000o00888ooo00o0000000008o00800000000o808000o00088000808888800000880o00002000080000022000o0000000088o0000000000000000
800020200200000o00088200000o0000008ooo800008000o000o080808000000800o000888o000ooo0000200oo00000020002020000o88000000000000000000
80800020220000000o008828000022000000oo00000008000o8000o000228808888888800o00880o00880000000000080088220002o880000000000000000000
08o00200020000000000o8000800200000000o0000000008080oo80008200o008o0o000888000000080o0000000000008800020000880o000000000000000000
0ooo000000000000000000820000oo000000000000000000oo88800o00000oo88oo8888000000800008800000oo00088008000000800008000000oo000200000
00o000000000000000000008008000000000800000080008o800o08080oo20o08o000008888000020o00800000o088000008o0008000000o000000000000o000
000000000o00000008000000880o80000000008000oo08800088800o008888888888888000008880ooo8000000000080000000080000000800000o0000000000
0o0002000000000000800000800000000000800000o000o0880oo0000oo00000o0000008888o00088o00880008000000o0oo0o00000000000000000002000008
000000000000000000o00008o0008008000000000000oo88000888000o8888888888888000o8880008800088000000oo00200080200000200000000000000o00
0080020000000000000o00000000000000000800800088008880008888000o00o0000000008ooo888008802000oooo0000200000000000200000000000000oo0
0000o080000o000000000800o000000000oo00o00088o088000888000008888888888800000888000880088228008o008000oo000o0000000000000000000o80
000ooo00000002000000800000000oo000o0088008008800088o0088888000o00000000808000088000880080008208008000000000000000000000000000800
0000oo0oo00002000800000oo0080o00080000088008000880o888ooo0000ooo0000000000088800880008008800800800000800000000000o000000000o0000
00000000o0000200000o0o000000080000000000088008800880000o000000o000000oo0000000880088008800800800822000000oo000200000000000ooo000
80008080o000000000ooo0080000802800800000800880088000000000000000000000o000000000880088008oo8oo800820808000o000000000000800000000
00000000o020002000oo8080000000800000800800800880000000000000000000000000000000000088008008o2oo08000000000000800000o0000000000000
0000o000o02080o0o0o0008000080000000808800800800000000000000000000000000000000000000080080088ooo080000000808oo0080000008o000o0000
80000oo000o800808020280000008000008080088oo8000000000000000000000000000000000000000008008802808008000000080800002000000008000000
80o00o0008000800022222000800008008080o800880000000000000000000000000000000000000000000880080080800808o00o82000800000000800000000
000000000080080o082o000000080800808008008000000000000000000000000000000000000000000000008oo8008080080020822000000008oo0080200000
00000000008080oo0808000000000808008080000000000000000000000000000000000000000000000000000800808o08080080800008000o000o0000200008
000000000000808o2080000o0800808008o8008000000000000000000000000000000000000000000000000002802808008o800800oo0000ooo00o0008000808
00000000000008o222000000o800008080o8000000000000000000000000000000000000000000000000000020080800808o0808000000800o20000000000800
0000000000000ooo2o000080008208080080800o000000000000000000000000000000000000000000000000000080800808008000000000080000ooo0008080
00oo000000000oooo80808008080800808008000000000000000000000000000000000000000000000000000000080080800808200000o0o0000000000000000
08o00000000000008oo80808o8008080800800oo0000000000000000000000000000000000000000000000000000080080o080080808080o0080000o00000000
000008000000008200808008o808080080800ooo000000000000000000000000000000000000000000000000000000808ooo080808000o0oo000000000000000
00000000000000020000808080080808080000o00000000000000000000000000000000000000000000000000000000808o808022000000ooo00020oo0000000
000020000000000008008080808080080800000000000000000000000000000000000000000000000000000000000008o8o080802oo00000o0000000o0000000
0000000000000000000008080080808080000000000000000000000000000000000000000000000000000000000000008o80808008o000000008000000000000
000oo000000000000800080808080o80000000000000000000000000000000000000000000000000000000000000000280800808080008000000000080808000
800o800000000000000oo8080808080800000000000000000000000000000000000000000000000000000000000000222808o808o0oo00000000000000808080
0000808000000000008o80808008080800000000000000000000000000000000000000000000000000000000000000020808o80o80o0o08o8000000000000000
00000800000000000o80800080808000000000000000000000000000000000000000000000000000000000000000000000808080808o80000000800000000o00
000o000000000000o0o00080008080800000000000000000000000000000000000000000000000000000000000000000008o808022000000888000080000o000
00000000000000080oo8080800808080000000000000000000000000000000000000000000000000000000000000000000808080o20820088888080000000000
000000000000000808o808080800000000000000000000000000000000000000000000000000000000000000000000000008o808080800888888800000o00000
00000000000000oo08022000080808000000000000000000000000000000000000000000000000000000000000000000000808080808oo888888880000000000
0000000000000oooo0002808080808000000000000000000000000000000000000000000000000000000000000000000000808080800oo888888888000000000
8000000000o0020008o80808080808000000000000000000000000000000000000000000000000000000000000000000000808o8o8000o088888888800000000
800000000oo08000000o008080800000000000000000000000000000000000000000000000000000000000000000000000080280808080o08888o88800000000
888000000o808000008002808080800000000000000000000000000000000000000000000000000000000000000000000000828o80808ooo08888o8800000000
888000ooo00200000000oo208080800000000000000000000000000000000000000000000000000000000000000000000000828o808080o08088o8o080000000
888800o0002220000000o280808080000000000000000000o00000000000000000000000000000000000000000000000000080808080008o8ooooo8oo008o000
88880o0000020000o0o080808080800000000000000000000o0o00000000000000000000000200000000000000000000000080808082008o80ooo88ooo0ooo08
88880o0000208000o08080808080800000000000000000000000o000000000000000000000220000000000000000000000008080828o0080828oo8888oo0o088
888888888888888888888888808080000000000000000000002ooo0000000000000000000000o000000000000000000000008888888888888888888888888888
8880220000oo00820o0080808080800000000000000000800000o00022000000000000000000000000000000000000000000808o80008oo0002288888888ooo8
80000200000200000080808080808o000000000000000000008000002000000000000000000000000000000000000000000080808o800ooo800088888888oo00
00000000000o0o8000o0808080808000000000000000000000000000000000000000000000000000000000000000000000008080800000o000008888888808o8
000000000000o0008ooo808082808o00000000000000000000000000000000000000000000000000000000000000000000008082808000008000888888ooo80o
000000000000000280o08000022o8oo00000000000000000000000000000000000000000000000000000000000000000000o808080008o800080008888880ooo
0000008080800000808080808080o800000000000000000000000000000000000000000000000000000000000000000000oooo8080808oo08080808888000000
000000000000008008000000000808000000000000000000000000000000000000000000000000000000000000000000000oo8o808080o0o000080008088o000
00000800000000000o00000oo0080800000000000000000000000000000000000000000000000000000000000000000000080808o8o808oo0000000000800008
08000000000000000oo0080008080800000000000000000000000000000000000000000000000000000000000000000000080808080808000800000800008080
08080000000000o80000000008080800000000000000000000000000000000000000000000000000000000000000000000080808080808000000000000000000
00000000000000oo0000000000808080000000000000000000000000000000000000000000000000000000000000000000808080080800000000000000000000
0800000000002008008000008080808000000000000000000000000000000000000000000000000000000000000000000080808o808000000000000008000000
0800o0000002000000808o8080808o8000000000000000000000000000000000000000000000000000000000000000000080808o808080808000000008080000
800000020o0o00000080808080000oo0000000000000000000000000000000000000000000000000000000000000000008080800808000808200000000002080
800ooo0o00o00020008002080008000800000000000000000000000000000000000000000000000000000000000000000808o808080000002200000000022000
800000o08000822208000228000000808000000000000000000000000000000000000000000000000000000000000000808ooo08080000080000000000800o00
8000ooo00800000000oo00000080808080000000000000000000000000000000000000000000000000000000000000008080o0800808080800o0000000000000
000000080000o00000008080000000080800000000000000000000000000000000000000000000000000000000000008080080828o0000000000000000000o00
00000800o0000000000000808008080808000000000000000000000000000000000000000000000000000000000000080808080080o000000000000000000000
08000000008000008000000800080800808000000000000000000000000000000000000000000000000000000000008080080808000000020o00200000020000
000080800000000020000800022080808008000000000000000000000000000000000000000000000000000000000800808o800800o00000ooo2000080000000
800000000000080222000000022080080800800000000000000000000000000000000000000000000000000000008o0808ooo0808oooo0000o080o8000800000
000o00000000000020000080808228080080800000000000000000000000000000000000000000000000000000008o80080o0o0080oooo0002080o0802000000
00000000000000o0000000o0o0o8208o8008080000000000000000000000000000000000000000000000000000080800800008080080o000o0000o0800000000
00000000000000000000000000o2228o080800800000o000000000000000000000000000000000000000000000800808o00080080800008o0000000000000000
000000000000008000oo08000080222800808008000ooo0000000000000000000000000000000000000000000800808o08000080800808000000808080000000
000000000080o00000o000oo80o80200808008008000o00000000000000000000000000000000000000000008008008080080000o080000000o0000080000000
00000000000ooo0o8000800o0ooo00800808008008800000000000000000000000000000000000000000008800o008080080800ooo0200000000080002000000
000000o00800o000000008080ooo00080o8080088008000000000000000000000000000000000000000008o08ooo808008008020o82200008000000000080000
000200000080000000o800008000080000080880o80080000000000000000000000000000000000000008008o0o80800800002228080000000000o8000000000
000000o000000000000080800820000000008008oo8008800000000000000000000000000000000000880080o800800800000028o00080000000000000000000
00000000000000000080000000020000oo8008008oo8800880000000000000000000000000000000880088008008o08008oo208oo000o0000008000000000000
000008000o0000000000000o0002080080o000800880088008800000000000000000000000o0000800080088008ooo000o0222o0000o00000000000002200000
0008000002o00000080000000000200000o080088008000880o888000000000000000000ooo88800880228008800o008o0002ooo0002000000000000000ooo00
08080080800000000000800o000000080002088002008800088o0088808000o00000008ooo800o800022200000800080000080o0082200000000000000000000
00000000o00802000008000000800800000820000228008800o8800000o88oo000888800o008880oo88200800000o000800000808o0008000000000000000000
00000020o00o0000o800000000000000oo02200080o088008880008880oo00022000000888822o888008000000080o0000000008oooo00000000000000000000
0000002200o00000oo8000000080880000082080o0800088o0088800008888080o000080000888o0080000080000000000000080oo0080000000000000000000
00000000000o00000oo0000o800800000oo08000o0088000880000888800o00o8000000888o0oooo00000000080000o800000008800820200000000000000000
00000008080000000000000808000000000008000880o88000888000008oooo0800808000oo000o000880000o00000800000000880800o000000000000000000
000000000o800000000000800000000080000008000ooo00000008800000o00o820000088808000888ooo00000000000800000000800oo000000000000000o00
000000000000000000000800800800000000080088ooo00000088000008888888880008000000800o08o0o00000000o800000000808800000000080000000000
000000020000000000008800o000o00020020008008o000008000o8888o0000080000008880800008o0008000000000080000008000880000000000000000008
80000002000000000008800ooo8ooo8000222000880080000008ooo0008280888088888000200080oo0000000000000000000000000088o000000o0000000000
000000020000000020880000o000o000000200000o88000000000o8088222000800000088888000000000000000020000822000o000008800002000080000000
00008o800000000228800080088000000o0000000oo002000888800000o28ooo88880880000o088800008000000000000020o000000008880000000000000000
000000o800000000880000000008000000000000008o2228000008008oo000o0800000088888o088808000000080208o0020o00080000o888000000000000000
80000000000000o88000208008200002020800o0000802002880000000088ooo880o00000o0008888800080008o000oo0000o000000000088800000000000000
0000000002000088800000000022088008000000000o0oo222000000800000oo88002000oo0088888880000o000000000000000000008000888o002200000000
00000000000008880080080000008000000000000008oooo28000000002200oo8802220000088888888080ooo000000000o00000000000000888000000000000
000000000008888000080000000000oo2800o00000800oo8000o8000000000oo88002000008888888880o08o8000000080o0000002200800008888000000o000
00000000088888o000oo000800080002220o2o0000088000000oo0000008000o88o800o2088888888802o000080000000000000000000000000888800o000000
0000000008888o00000008000000000o20200000000000000000000o0000000o88200o2o88oooo8888202008000000000o00000000o00o00o000888800000000
000000008888200000000000000000000o0020000008000000000200080008o888o888oo0oooo88880o00800000000000000000000000000o000088880000000
000000088888020000800000000000000o0000080000o800000008800000000888000o8088oo888800800o0800000000000000000000000o0000008888000000
00000088888o000000o0000000000000000000000000oo00000oo000080000o888o80o8080o888000000o000000000000000000000000000o000000888800000
0000o88888o0000000o000000008000000000000802000200000002800000oo8880808808o808000002880000000000000000000080000000000000088880000
000088888o000000000000000000000000000000000000208080o022200000o8880808o8o00880000222008o0000000000000000000000o00000000288888o00
000888880000022200000000000000000080000o000o000000000000220000o888008ooo00800000002220ooo00020000000000000000oo000000000088888o0
0088888000000oo000000000000000000888o0000000000000o00o0o00o00oo888o080o08808008088o2000o00000000000000o0o00000000000000000888888
08888880000000oo00000000000oo008888888000000000000000ooo0ooo00088800oo080800000000808o00080000000000000o008000000000000000088888
8888880000000000080000000000088888888800000000000080000o08o00808880o0808080000008000008000080000000000000800000000000000000o8888
888880000000000000000000000088888888888000000000000080008000880888o8888000000000008088000880000000000000000000000000000000000888

