
	starline = Shape.new()--динамичная линия
	room1:addChild(starline)
	
	function starLINe(x,y,x1,y1)--малюєм лінії по порядку



		starline:clear()
		starline:setLineStyle(3, 0xFFFF00, 1)
		starline:beginPath()
		starline:moveTo(x,y)
		starline:lineTo(x1,y1) 
		starline:endPath()
		
	


end