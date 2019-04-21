function collisionTest2(spriteA, sprite2)
--print("КОЛІЗІЯ")
		--self bottom < other sprite top
        if spriteA:getY()-room1:getY()  < sprite2:getY()-5 then
                return false
        end
        -- self top > other sprite bottom
        if spriteA:getY()-room1:getY() > sprite2:getY()+5  then
                return false
        end
        --self left > other sprite right
        if spriteA:getX()-room1:getX() > sprite2:getX()+5  then
                return false
        end
        -- self right < other sprite left
        if spriteA:getX()-room1:getX()  < sprite2:getX()-5 then
                return false
        end
	
			return true
		
end

function validTest(Znew,Zold)
o_y=Z[Zold].y
o_x=Z[Zold].x
n_x=Z[Znew].x
n_y=Z[Znew].y
	if n_y==o_y then
		if o_x<n_x then  --  O -> N
			for r=o_x,n_x-1 do
				if P[n_y][r][2]==1 then   --якшо справа стіна фальс
				print("стіна справа")
					return false  
					
				end
			end

		elseif o_x>n_x then -- 	N <- O
			for r=n_x,o_x-1 do
				if P[n_y][r][2]==1 then   --якшо справа стіна фальс
				print("стіна зліва")
					return false  
					
				end
			end
		end
		return true
	elseif o_x==n_x then
	
		if o_y<n_y then
			--  O
			--  |
			--	V
			--  N
			for r=o_y+1,n_y do
				if P[r][n_x][1]==1 then   --якшо справа стіна фальс
				print("стіна низ")
						return false  
						
				end
			end
		
		elseif o_y>n_y then
			--	N
			--	^
			--	|
			--	O
			for r=n_y+1,o_y do
				if P[r][n_x][1]==1 then   --якшо справа стіна фальс
					print("стіна верх")	
						return false  
				
				end
			end
		end
		return true
	end

--Z[#Z].x=ii
--Z[#Z].y=i
--P[y][x][1]
	
	
	return false

end


function LIN2()--малюєм лінії по послідовності
	--POS  -- послідовність
	--POS={1}
	if line3 then	line3:clear() end
	
		line3 = Shape.new()
		line3:setLineStyle(3, 0xFFFF00, 1)
		line3:beginPath()
		
		line3:moveTo(Z[POS[1]]:getPosition())
	
	for i=2,#POS do
		line3:lineTo(Z[POS[i]]:getPosition())
	end
	
		line3:endPath()
		room1:addChild(line3)
end