pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
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

function vec2.__mul(a,b)
  if type(a) == "number" then
    --Scale b by a
    return makevec2(a * b.x, a * b.y)
  elseif type(b) == "number" then
    --Scale a by b
    return makevec2(b * a.x, b * a.y)
  else
    --Dot product
    return (a.x * b.x) + (a.y * b.y)
  end
end

--Inspired by this queue implementation https://www.lua.org/pil/11.4.html makevec2(64,64),makevec2(60,64)
snakequeue={head=0, tail=-1}
function snakequeue.push(q, value)
  local head = q.head - 1
  q.head = head
  q[head] = value
end

function snakequeue.pop(q)
  local tail = q.tail
  if q.head > tail then error("queue is empty") end
  local value = q[tail]
  q[tail] = nil
  q.tail = tail-1
  return value
end

toadd = 0
snakesize = 4
snakedirection = makevec2(1,0)
updatespermove = 4
updatessincemove = 0

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
  if toadd > 0 then
    --if there are pieces to add, then add them in front of the head
    toadd -= 1
    body:push(body[body.head] + (direction * snakesize))
  else
    --remove the tail and put it in front of the head
    body:pop()
    body:push(body[body.head] + (direction * snakesize))
  end
end

function snakedraw(body, direction)
  --draw the snake's head
  --pset(body[body.head].x,body[body.head].y,14)
  spr(1,body[body.head].x,body[body.head].y)
  --draw the snake's body
  local bodysize = abs(body.head - body.tail)
  if bodysize > 2 then
    for i=body.head+1,body.tail-1,1 do
      pset(body[i].x,body[i].y,6)
    end
  end
  --draw the snake's tail
  pset(body[body.tail].x,body[body.tail].y,7)
end

function _init()
  snakequeue:push(makevec2(64,64))
  snakequeue:push(makevec2(63,64))
end

function _update()
  if (btn(🅾️)) then toadd += 1 end
  if (btn(⬅️)) then snakedirection=makevec2(-1,0) end
  if (btn(➡️)) then snakedirection=makevec2(1,0) end
  if (btn(⬆️)) then snakedirection=makevec2(0,-1) end
  if (btn(⬇️)) then snakedirection=makevec2(0,1) end
  
  updatessincemove += 1
  if updatessincemove >= updatespermove then
    snakemove(snakequeue, snakedirection)
    updatessincemove = 0
  end
end

function _draw()
  cls(0)
  snakedraw(snakequeue,snakedirection)
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
