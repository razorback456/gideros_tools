level_1 = gideros.class(Sprite)



function level_1:init()

	--print("level 1")
	local logo=Bitmap.new(Texture.new("images/gideros_mobile.png"))
		self:addChild(logo)		
		logo:setScale(0.5)
		logo:setAnchorPoint(0.5,0.5)
		logo:setPosition(centrX,centrY)
		----------------------------------------
		back_btn = Button.new(Bitmap.new(Texture.new("images/back_up.png")))
				back_btn:addEventListener("clickUP", function(e)
					e:stopPropagation()
					
					 Room(level_select)
					  
				end)
				back_btn:setScale(0.5,0.5)
		self:addChild(back_btn,21,31)
end
