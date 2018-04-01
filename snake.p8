pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
-- 0=y-,1=x+,2=y+,3=x-
snakedirection = 1
-- arrays are 1-indexed!!!!!!!
snakebody = {{x=64,y=64},{x=63,y=64}}

--pure
function updatecoord(coord, direction)
	if direction == 0 then
		return {coord.x, coord.y-1}
	elseif direction == 1 then
		return {coord.x+1, coord.y}
	elseif direction == 2 then
		return {coord.x, coord.y+1}
	else
		return {coord.x-1, coord.y}
	end
end

function snakemove(body, direction)
	bodysize = #body
	print(body[1].x)
	for i=1,bodysize do
		body[i] = updatecoord(body[i], direction)
	end
end

function snakedraw(body, direction)
	--draw the snake's head
	circfill(body[1].x,body[1].y,1,14)
	--draw the snake's body
	bodysize = #body
	if bodysize > 2 then
			for i=2,bodysize-1 do
				circfill(body[i].x,body[i].y,1,10)
			end
	end
	--draw the snake's tail
	circfill(body[bodysize].x,body[bodysize].y,1,7)
end


function _update()
	snakemove(snakebody, snakedirection)
-- if (btn(0)) then x=x-1 end
-- if (btn(1)) then x=x+1 end
-- if (btn(2)) then y=y-1 end
-- if (btn(3)) then y=y+1 end
end

function _draw()
snakedraw(snakebody,snakedirection)
end

