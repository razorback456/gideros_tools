 base={}
base.x=0
base.y=0

local function onTouchesBegin(event)

		 base.x =  event.touch.x-room1:getX()
		 base.y =  event.touch.y-room1:getY()
		 
		

end

------------------------------------------
--   			 ДВИЖЕНИЕ
------------------------------------------
local function onTouchesMove(event)
		pos_room1x=event.touch.x-base.x
		pos_room1y=event.touch.y-base.y
		
		
		room1:setPosition(pos_room1x,pos_room1y)-- перемещаем
	

end

--  СОБИТИЯ ТАЧА
stage:addEventListener(Event.TOUCHES_BEGIN, onTouchesBegin)
stage:addEventListener(Event.TOUCHES_MOVE, onTouchesMove)
