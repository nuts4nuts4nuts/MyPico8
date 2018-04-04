pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
snakedirection = {x=1,y=0}

vec2 = {}

function makevec2(xa, ya)
  local v = {x=xa, y=ya}
  setmetatable(v, vec2)
  return v
end

function vec2.__add(a,b)
  return makevec2(a.x+b.x,a.y+b.y)
end

function vec2.__sub(a,b)
  return makevec2(a.x-b.x,a.y-b.y)
end

head=makevec2(64,64)
tail=makevec2(60,64)
snakepositions={head,tail}
snakesize = 4

--pure
function getdir(pointa, pointb)
  local dist = pointb-pointa

  local direction = makevec2(0,0)

  if dist.x > 0 then
    direction.x = 1
  elseif dist.x < 0 then
    direction.x = -1
  else
    direction.x = 0
  end

  if dist.y > 0 then
    direction.y = 1
  elseif dist.y < 0 then
    direction.y = -1
  else
    direction.y = 0
  end

  return direction
end

function snakemove(body, direction)
  local bodysize = #body
  --move the body from the tail forward
  for i=bodysize,2,-1 do
    body[i] = move(body[i],getdir(body[i],body[i-1]))
  end
  --move the head forward
  body[1] = move(body[1], direction)
end

function snakedraw(body, direction)
  --draw the snake's head
  --pset(body[1].x,body[1].y,14)
  spr(1,body[1].x,body[1].y)
  --draw the snake's body
  local bodysize = #body

  if bodysize > 2 then
    for i=2,bodysize-1 do
      pset(body[i].x,body[i].y,10)
    end
  end
  --draw the snake's tail
  pset(body[bodysize].x,body[bodysize].y,7)
end

function snakegrow(body)
  newpiece=makevec2(0,0)
  add(body, newpiece)
end

function _update()
  if (btn(🅾️)) then snakegrow(snakepositions) end
  if (btn(⬅️)) then snakedirection={x=-1,y=0} end
  if (btn(➡️)) then snakedirection={x=1,y=0} end
  if (btn(⬆️)) then snakedirection={x=0,y=-1} end
  if (btn(⬇️)) then snakedirection={x=0,y=1} end
  snakemove(snakepositions, snakedirection)
end

function _draw()
  cls(0)
  snakedraw(snakepositions,snakedirection)
end

__gfx__
00000000555500000033333300333300333330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000533500000033333300333300333330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700533500003333332300333300323333330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000555500003333333333333333333333330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000003333333333333333333333330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000003333332333333333323333330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000033333333233233333330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000033333333333333333330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
