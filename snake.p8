pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
-- 0=y-,1=x+,2=y+,3=x-
snakedirection = 1
-- arrays are 1-indexed!!!!!!!
snakebody = {{x=64,y=64},{x=63,y=64},{x=62,y=64}}

--pure
function movehead(head, direction)
	if direction == 0 then
		return {x=head.x, y=head.y - 1}
	elseif direction == 1 then
		return {x=head.x + 1, y=head.y}
	elseif direction == 2 then
		return {x=head.x, y=head.y + 1}
	else
		return {x=head.x - 1, y=head.y}
	end
end

function snakemove(body, direction)
	bodysize = #body
	--move the body from the tail forward
	for i=bodysize,2,-1 do
		body[i].x = body[i-1].x
		body[i].y = body[i-1].y
	end
	--move the head forward
	body[1] = movehead(body[1], direction)
end

function snakedraw(body, direction)
	--draw the snake's head
	pset(body[1].x,body[1].y,14)
	--spr(snakedirection+1, body[1].x, body[1].y)
	--draw the snake's body
	bodysize = #body
	if bodysize > 2 then
			for i=2,bodysize-1 do
			 pset(body[i].x,body[i].y,10)
			end
	end
	--draw the snake's tail
	pset(body[bodysize].x,body[bodysize].y,7)
end

function snakegrow(body)
	add(body, {x=0,y=0})
end

function _update()
	if (btn(🅾️)) then snakegrow(snakebody) end
	if (btn(⬅️)) then snakedirection=3 end
	if (btn(➡️)) then snakedirection=1 end
	if (btn(⬆️)) then snakedirection=0 end
	if (btn(⬇️)) then snakedirection=2 end
	snakemove(snakebody, snakedirection)
end

function _draw()
	cls(0)
	snakedraw(snakebody,snakedirection)
end

__gfx__
00000000333333330033333300333300333330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000332332330033333300333300333330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700333333333333332300333300323333330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000333333333333333333333333333333330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000333333333333333333333333333333330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700003333003333332333333333323333330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000003333000033333333233233333330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000003333000033333333333333333330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
