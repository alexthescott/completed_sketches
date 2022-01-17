pico-8 cartridge // http://www.pico-8.com
version 33
__lua__
-- random step a
-- alexthescott
-- 9/17/21

function new_line(x,ori)
	l={}
	l.x=x
	l.y=0
	l.p=30+rnd(68)
	l.gp=30+rnd(68)
	l.new_p=true
	l.dif=0
	l.gap=32
	l.ori=ori
	
	l.update=function(self)
		if self.new_p==true then
			self.dif=(self.gp-self.p)/75
			self.new_p=false
		end
		self.p+=self.dif
	end
	
	l.new_h=function(self,p)
		self.new_p=true
		if p==-1 then
			self.gp=20+rnd(88)
		else
			self.gp=p
		end
	end
	
	l.draw=function(self)
		local g=self.gap
		if self.ori==1 then
			line(self.x,0,self.x,self.p-g,7)
			line(self.x+1,0,self.x+1,self.p-g,7)
			line(self.x,self.p+g,self.x,128,7)
			line(self.x+1,self.p+g,self.x+1,128,7)
		else
			line(0,self.x,self.p-g,self.x,7)
			line(0,self.x+1,self.p-g,self.x+1,7)
			line(self.p+g,self.x,128,self.x,7)
			line(self.p+g,self.x+1,128,self.x+1,7)
		end
	end
	
	return l
end

function burn()
	for i=1, 1000 do
		x=rnd(128)\1
		y=rnd(128)\1
		pc=pget(x,y)
		if pc!=0 then
			pset(x,y,0)
		end 
	end
end

lines={}
size=64
for i=0,size do
	nl=new_line(i*(128/size),1)
	add(lines,nl)
end

for i=0,size do
	nl=new_line(i*(128/size),0)
	add(lines,nl)
end

across={}

fc=0

cls(7)
::♥::
if t()<2 then
	print("random step a",38,64,0)
else
	burn()
	
	for l in all(lines) do
		l:draw()
		l:update()
	end
	
	fc+=1
	
	if fc==75 then
		lines[1]:new_h(-1)
		for i=1,#lines-1 do
			lines[i+1]:new_h(lines[i].p)
		end
		fc=0
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
