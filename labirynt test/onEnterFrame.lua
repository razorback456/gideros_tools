-------------------------------------------
--			onEnterFrame
--------------------------------------------
endstar=1  
function connect(i)
							table.insert(POS, i)
							endstar=i
							LIN2()
							--print("колізія "..i)
							
							Z[i].col=1
	if endstar==2 then
		-- ПЕРЕИОГА
		print("перемога")

	end

end 


local accelerometer = Accelerometer.new()
accelerometer:start()
b_mode=0-----------------------------------------------------------   РЕЖИМ КЕРУВАННЯ
 local fx, fy, fz = 0, 0, 0
 filter = 0.2
 
  local afx, afy, afz = 0, 0, 0
 afilter = 0.009
 
local function onEnterFrame()
---------------------------------
-- АКСЕЛЕРОМЕТР
--------------------------------

local x, y, z = accelerometer:getAcceleration()

	-- do the low-pass filtering
	fx = x * filter + fx * (1 - filter)
	fy = y * filter + fy * (1 - filter)


	rx,ry=(fy *3* 400),(200+fx*3 * 240)
	
	-------------------------------------------------------------------------------------------------------
	if  b_mode==1 then
	
		bx,by = Z[1]:getPosition()
		ax,ay=Z[endstar]:getPosition()
	
		afx = (bx-ax) * afilter + afx * (1 - afilter)
		afy = (by-ay) * afilter + afy * (1 - afilter)
	
		
		room1:setPosition(rx+355+afx,ry+300+200+afy)-- перемещаем
	end
	
		-----------АКСЕЛЕРОМЕТР----------------------------
		---------------------------------------------------
		
		
-- відмальовка  лінії від червоної до останньої зірки
	starLINe(dot:getX()-room1:getX(),dot:getY()-room1:getY(),Z[endstar]:getX(),Z[endstar]:getY())
	
	-------------------------
	--  перевірка колізії
	--------------------
	for i=1,#Z do
		if collisionTest2 (dot, Z[i]) == true then 
			
			if dot.col~=i  then -- чи не є червона вже в колізії
				
				if Z[i].col~=1 then   -- чи не під'єднана лінія
					--			print(Z[i].y)
					if validTest(i,endstar)==true then
						connect(i)
					end
					
				elseif i==POS[#POS-1] then  -- прибрати останнє зєднання
					
				--	print("офф")
					endstar=i
					Z[POS[#POS]].col=0
					table.remove(POS, #POS) 
					LIN2()
				end
				
			end
			
			dot.col=i
		end
	
	end




end
stage:addEventListener(Event.ENTER_FRAME, onEnterFrame)
