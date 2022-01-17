pico-8 cartridge // http://www.pico-8.com
version 32
__lua__
-- digital dash
-- alexthescott
-- 9/1/21

p={8,136,130,11,139,131,12,140,129}
pal(p,1)

function new_screen()
	s={}
	for i=0,128 do
		add(s,{'v',i})
		add(s,{'h',i})
	end
	return s
end

function new_beam(c)
	p=screen[1+rnd(#screen)\1]
	del(screen,p)

	b={}
	b.c=c
	b.o=p[1]
	b.d=rnd(2)\1
	
	if b.o=='v' then
		-- top
		if b.d==0 then
			b.x=p[2]
			b.y=1
			b.dx=0
			b.dy=1
		-- bottom
		else
			b.x=p[2]
			b.y=127
			b.dx=0
			b.dy=-1
		end
	elseif b.o=='h' then
		-- left
		if b.d==0 then
			b.x=127
			b.y=p[2]
			b.dx=-1
			b.dy=0
		-- right
		else
			b.x=0
			b.y=p[2]
			b.dx=1
			b.dy=0
		end
	end
	
	b.draw=function(self)
		rectfill(self.x,self.y,self.x+1,self.y+1,self.c)
	end
	
	b.update=function(self)
		self.x+=self.dx
		self.y+=self.dy
	end
	
	add(beams,b)
end

function burn()
	for p=0,1000 do
		x=rnd(128)\1
		y=rnd(128)\1
		pc=pget(x,y)
		if pc%3!=0 then
			-- herein lies our anomaly
			pset(x,y,p+1)
		elseif rnd(4)\1==0 then
			pset(x,y,0)
		end
	end
end

screens={}
screen=new_screen()

beams={}

global_index=1

cls()
::♥::
burn()

if #screen<4 then
	screen=new_screen()
	global_index+=3
	global_index%=9
end

if t()%0.5==0 then
	for i=1,4 do 
		new_beam(global_index)
	end 
end

for b in all(beams) do
	b:draw()
	b:update()
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
