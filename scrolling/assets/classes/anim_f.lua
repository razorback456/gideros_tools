device={application:getDeviceInfo()}



-- ПЕРЕМІСТИТИ З ЗАДАНОЮ ШВИДКІСТЮ
function speed_move(arg)
		local sprite=arg.sprite
		local x2=arg.x2
		local y2=arg.y2
		local speed=arg.speed
		if device[1]=="Windows" then speed=speed*6 end  -- швидкість віндвса в 6 рази швидша ніж на андроїд
		local eff=arg.effect
		local event=arg.event
		
        speed=speed/1000*60  --60fps
        x1, y1 = sprite:getPosition()

        sprite.speed_move = MovieClip.new{
                        {1, speed, sprite, {x = {x1, x2, eff},y = {y1, y2, eff}}}  -- відтворити з 1 до 100 кадру з рухом по осі  Х від 0 до 200
                }
        sprite.speed_move:gotoAndPlay(1)
		
		function moveout()
			 sprite:dispatchEvent(Event.new(event))  -- створити подію
		end
		sprite.speed_move:addEventListener(Event.COMPLETE, moveout)  --слхати подію завершення анімації
		
		--conf.pauza=true 
end

-- МАСШТАБ З ЗАДАНОЮ ШВИДКІСТЮ
function speed_scale(sprite,xs2,ys2,speed)
local eff="outElastic"
        xs1, ys1 = sprite:getScale()
        speed=speed/1000*60
        sprite.scale = MovieClip.new{
                {1, speed, sprite, {scaleX = {xs1, xs2, eff},scaleY = {ys1, ys2, eff}}}    
        }
        sprite.scale:gotoAndPlay(1)
		
		function moveout2()
			 sprite:dispatchEvent(Event.new("out2"))  -- створити подію
		end
		sprite.scale:addEventListener(Event.COMPLETE, moveout2)  --слхати подію завершення анімації
end

