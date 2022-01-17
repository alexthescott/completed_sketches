pico-8 cartridge // http://www.pico-8.com
version 33
__lua__
-- random walk alt
-- alexthescott
-- 9/21/21
-- https://w.wiki/46ny

p={143,142,133,13,141,130,140,131,129}
pal(p,1)

function new_walk(col)
	w={}
	w.c=col
	w.x=64
	w.y=64
	
	w.draw=function(self)		
		pset(self.x,self.y,self.c+1)
	end
	
	w.update=function(self)
		local d=rnd(4)\1
		if d==0 then
			self.x+=2
		elseif d==1 then
			self.y+=1
		elseif d==2 then
			self.x-=2
		else
			self.y-=1
		end
		
		if self.x<=0 then
			self.x=126
		elseif self.x>=128 then
			self.x=0
		end
		
		if self.y<=0 then
			self.y=126
		elseif self.y>=128 then
			self.y=0
		end
	end
	
	add(walks,w)
end

function burn()
	for p=0,1200 do
		x=rnd(128)\1
		y=rnd(128)\1
		pc=pget(x,y)
		coin=rnd(2)\1
		if pc!=0 and pc%3!=0 then
			if rnd(2)\1==0 then
				pset(x,y+1,pc+coin)
				pset(x,y+coin+1,pc+coin)
			end
		end
		if rnd(1)<0.25 then
			pset(x,y,0)
		end
	end
end

fc=0
global_color=1+3*(rnd(3)\1)
walks={}
for i=1,120 do
	new_walk(global_color)
end

cls()
_set_fps(60)
::♥::
if t()<2 then
	print("random walk alt",34,64,global_color)
else
	burn()
	
	fc+=1
	
	if fc%1600==0 then
		global_color+=3
		global_color%=9	
		for w in all(walks) do
			w.c=global_color
		end
		fc=0
	end
	
	for w in all(walks) do
		w:draw()
		if fc%2==0 then
			w:update()
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
