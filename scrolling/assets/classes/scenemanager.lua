--[[
Room v1
   (c)Oleg Simonenko
www.facebook.com/SimArt.info
simartinfo.blogspot.com
github.com/razorback456/gideros_tools

--Моя переробка класу SceneManager
(C) 2019

Room(start) -- старт з рамдомним переходом

Room(start,21,31) -- старт з встановеним переходом
Room(start,21,31,true) -старт  в тестовому режимі
]]

SceneManager = gideros.class(Sprite)

function Room(scene,t,e,inf)
	--local test=true
	if not sceneManager then
		sceneManager = SceneManager.new()
		stage:addChild(sceneManager)
		
		if  test  then
		sceneManager:addEventListener("transitionBegin", function() print("manager - transition begin") end)
		sceneManager:addEventListener("transitionEnd", function() print("manager - transition end") end)
		end
	end
		 
	
		
		if not t then  t = math.random(1, 21) end-- рндомний спеефект
		if not e then  e = math.random(1, 31) end
		
		if  test  then 
			print("transitions: "..t.." easing: "..e) 
			 
		end
	
		sceneManager:changeScene(scene, 1, transitions[t], eas[e])
	
end

local function getContentWidth()
	local orientation = stage:getOrientation() 	
	if orientation == Stage.LANDSCAPE_LEFT or orientation == Stage.LANDSCAPE_RIGHT then
		return application:getLogicalHeight()
	else
		return application:getLogicalWidth()
	end
end

local function getContentHeight()
	local orientation = stage:getOrientation() 	
	if orientation == Stage.LANDSCAPE_LEFT or orientation == Stage.LANDSCAPE_RIGHT then
		return application:getLogicalWidth()
	else
		return application:getLogicalHeight()
	end
end

function SceneManager.moveFromRight(scene1, scene2, t)
	local width = getContentWidth()

	scene1:setX(-t * width)
	scene2:setX((1 - t) * width)
end

function SceneManager.moveFromLeft(scene1, scene2, t)
	local width = getContentWidth()

	scene1:setX(t * width)
	scene2:setX((t - 1) * width)
end

function SceneManager.overFromRight(scene1, scene2, t)
	local width = getContentWidth()

	scene2:setX((1 - t) * width)
end

function SceneManager.overFromLeft(scene1, scene2, t)
	local width = getContentWidth()

	scene2:setX((t - 1) * width)
end

function SceneManager.moveFromRightWithFade(scene1, scene2, t)
	local width = getContentWidth()

	scene1:setAlpha(1 - t)
	scene1:setX(-t * width)
	scene2:setX((1 - t) * width)
end

function SceneManager.moveFromLeftWithFade(scene1, scene2, t)
	local width = getContentWidth()

	scene1:setAlpha(1 - t)
	scene1:setX(t * width)
	scene2:setX((t - 1) * width)
end

function SceneManager.overFromRightWithFade(scene1, scene2, t)
	local width = getContentWidth()

	scene1:setAlpha(1 - t)
	scene2:setX((1 - t) * width)
end

function SceneManager.overFromLeftWithFade(scene1, scene2, t)
	local width = getContentWidth()

	scene1:setAlpha(1 - t)
	scene2:setX((t - 1) * width)
end

function SceneManager.moveFromBottom(scene1, scene2, t)
	local height = getContentHeight()

	scene1:setY(-t * height)
	scene2:setY((1 - t) * height)
end

function SceneManager.moveFromTop(scene1, scene2, t)
	local height = getContentHeight()

	scene1:setY(t * height)
	scene2:setY((t - 1) * height)
end

function SceneManager.overFromBottom(scene1, scene2, t)
	local height = getContentHeight()

	scene2:setY((1 - t) * height)
end

function SceneManager.overFromTop(scene1, scene2, t)
	local height = getContentHeight()

	scene2:setY((t - 1) * height)
end

function SceneManager.moveFromBottomWithFade(scene1, scene2, t)
	local height = getContentHeight()

	scene1:setAlpha(1 - t)
	scene1:setY(-t * height)
	scene2:setY((1 - t) * height)
end

function SceneManager.moveFromTopWithFade(scene1, scene2, t)
	local height = getContentHeight()

	scene1:setAlpha(1 - t)
	scene1:setY(t * height)
	scene2:setY((t - 1) * height)
end


function SceneManager.overFromBottomWithFade(scene1, scene2, t)
	local height = getContentHeight()

	scene1:setAlpha(1 - t)
	scene2:setY((1 - t) * height)
end

function SceneManager.overFromTopWithFade(scene1, scene2, t)
	local height = getContentHeight()

	scene1:setAlpha(1 - t)
	scene2:setY((t - 1) * height)
end

function SceneManager.fade(scene1, scene2, t)
	if t < 0.5 then
		scene1:setAlpha((0.5 - t) * 2)
	else
		scene1:setAlpha(0)
	end

	if t < 0.5 then
		scene2:setAlpha(0)
	else
		scene2:setAlpha((t - 0.5) * 2)
	end
end

function SceneManager.crossfade(scene1, scene2, t)
	scene1:setAlpha(1 - t)
	scene2:setAlpha(t)
end

function SceneManager.flip(scene1, scene2, t)
	local width = getContentWidth()

	if t < 0.5 then
		local s = (0.5 - t) * 2
		scene1:setScaleX(s)
		scene1:setX((1 - s) * width * 0.5)
	else
		scene1:setScaleX(0)
		scene1:setX(width * 0.5)
	end

	if t < 0.5 then
		scene2:setScaleX(0)
		scene2:setX(width * 0.5)
	else
		local s = (t - 0.5) * 2
		scene2:setScaleX(s)
		scene2:setX((1 - s) * width * 0.5)
	end
end

function SceneManager.flipWithFade(scene1, scene2, t)
	local width = getContentWidth()

	if t < 0.5 then
		local s = (0.5 - t) * 2
		scene1:setScaleX(s)
		scene1:setX((1 - s) * width * 0.5)
		scene1:setAlpha(s)
	else
		scene1:setScaleX(0)
		scene1:setX(width * 0.5)
		scene1:setAlpha(0)
	end

	if t < 0.5 then
		scene2:setScaleX(0)
		scene2:setX(width * 0.5)
		scene2:setAlpha(0)
	else
		local s = (t - 0.5) * 2
		scene2:setScaleX(s)
		scene2:setX((1 - s) * width * 0.5)
		scene2:setAlpha(s)
	end
end

function SceneManager.flipWithShade(scene1, scene2, t)
	local width = getContentWidth()

	if t < 0.5 then
		local s = (0.5 - t) * 2
		scene1:setScaleX(s)
		scene1:setX((1 - s) * width * 0.5)
		scene1:setColorTransform(1 - t, 1 - t, 1 - t, 1)
	else
		scene1:setScaleX(0)
		scene1:setX(width * 0.5)
		scene1:setColorTransform(0.5, 0.5, 0.5, 1)
	end

	if t < 0.5 then
		scene2:setScaleX(0)
		scene2:setX(width * 0.5)
		scene2:setColorTransform(0.5, 0.5, 0.5, 1)
	else
		local s = (t - 0.5) * 2
		scene2:setScaleX(s)
		scene2:setX((1 - s) * width * 0.5)
		scene2:setColorTransform(t, t, t, 1)
	end
end

local function dispatchEvent(dispatcher, name)
	if dispatcher:hasEventListener(name) then
		dispatcher:dispatchEvent(Event.new(name))
	end
end

local function defaultEase(ratio)
	return ratio
end
--********************INIT********************************
function SceneManager:init()
	self.tweening = false
	self:addEventListener(Event.ENTER_FRAME, self.onEnterFrame, self)
	
	
	
 transitions = {
	SceneManager.moveFromLeft,
	SceneManager.moveFromRight,
	SceneManager.moveFromBottom,
	SceneManager.moveFromTop,
	SceneManager.moveFromLeftWithFade,
	SceneManager.moveFromRightWithFade,
	SceneManager.moveFromBottomWithFade,
	SceneManager.moveFromTopWithFade,
	SceneManager.overFromLeft,
	SceneManager.overFromRight,
	SceneManager.overFromBottom,
	SceneManager.overFromTop,
	SceneManager.overFromLeftWithFade,
	SceneManager.overFromRightWithFade,
	SceneManager.overFromBottomWithFade,
	SceneManager.overFromTopWithFade,
	SceneManager.fade,
	SceneManager.crossFade,
	SceneManager.flip,
	SceneManager.flipWithFade,
	SceneManager.flipWithShade
	}--21
	 eas={
	easing.inBack, 
	easing.inBack,
	easing.outBack,
	easing.inOutBack,
	easing.inBounce,
	easing.outBounce,
	easing.inOutBounce,
	easing.inCircular,
	easing.outCircular,
	easing.inOutCircular,
	easing.inCubic,
	easing.outCubic,
	easing.inOutCubic,
	easing.inElastic,
	easing.outElastic,
	easing.inOutElastic,
	easing.inExponential,
	easing.outExponential,
	easing.inOutExponential,
	easing.noneLinear,
	easing.inQuadratic,
	easing.outQuadratic,
	easing.inOutQuadratic,
	easing.inQuartic,
	easing.outQuartic,
	easing.inOutQuartic,
	easing.inQuintic,
	easing.outQuintic,
	easing.inOutQuintic,
	easing.inSine,
	easing.outSine,
	easing.inOutSine,


	}--32

end
--******OPEN ROOM****************************************************************************
function SceneManager:changeScene(scene, duration, transition, ease)
	if self.tweening then
		return
	end

	if self.scene1 == nil then
		self.scene1 = scene.new()
		
		self:addChild(self.scene1)
		dispatchEvent(self, "transitionBegin")
		dispatchEvent(self.scene1, "enterBegin")
		dispatchEvent(self, "transitionEnd")
		dispatchEvent(self.scene1, "enterEnd")
		return
	end

	self.duration = duration
	self.transition = transition
	self.ease = ease or defaultEase

	self.scene2 = scene.new()
	self.scene2:setVisible(false)
	self:addChild(self.scene2)

	self.time = 0
	self.currentTimer = os.timer()
	self.tweening = true
end
--***********************************************************************************
function SceneManager:onEnterFrame(event)
	if not self.tweening then
		return
	end

	if self.time == 0 then
		self.scene2:setVisible(true)
		dispatchEvent(self, "transitionBegin")
		dispatchEvent(self.scene1, "exitBegin")
		dispatchEvent(self.scene2, "enterBegin")
	end

	local timer = os.timer()
	local deltaTime = timer - self.currentTimer
	self.currentTimer = timer

	self.time = self.time + deltaTime

	if self.time > self.duration then
		self.time = self.duration
	end

	local t = (self.duration == 0) and 1 or (self.time / self.duration)
	if self.transition then  --fix bug: attempt to call field 'transition' (a nil value)
		self.transition(self.scene1, self.scene2, self.ease(t))
	end

	if self.time == self.duration then
		dispatchEvent(self, "transitionEnd")
		dispatchEvent(self.scene1, "exitEnd")
		dispatchEvent(self.scene2, "enterEnd")

		self:removeChild(self.scene1)
		self.scene1 = self.scene2
		self.scene2 = nil
		self.tweening = false

		collectgarbage()
	end
end