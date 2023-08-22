-----------------------------------------------------------------------------------------
--
-- claer2.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	local sound_dart =  audio.loadSound("sound/게임 시스템/암전 될 때 소리.mp3")

-- ↓ 시작화면 배치 -----------------------=----------------------------------------------------------------------
	local background = display.newRect(display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
	background:setFillColor(0.1, 1) -- 전체 화면

	local room = display.newImage( "image/배경/배경_2층_거짓말쟁이.png", display.contentWidth*0.5, display.contentHeight*0.5)
	room:setFillColor(0.4, 0.4) -- 게임 방
	room:scale(0.9, 0.9)

	local explanation = display.newImage("image/UI/물음표.png")
	explanation.x, explanation.y = 100, 80

	local inventory = display.newImage("image/UI/인벤토리.png")
	inventory.x, inventory.y = 240, 80

	local back = display.newImage("image/UI/세모.png")
	back.x, back.y = 1820, 80

	local item_Change = display.newImage("image/UI/Item_Change.png")
	item_Change.x, item_Change.y = 1740, 680

	-- ↓ 방향키 --------------------------------------

	local up = display.newImage("image/UI/콘솔(상).png")
	up.x, up.y = 330, 696
	up.name  = "up"
	up.alpha = 0.5

	local right = display.newImage("image/UI/콘솔(우).png")
	right.x, right.y = 443, 810
	right.name = "right"
	right.alpha = 0.5

	local left = display.newImage("image/UI/콘솔(좌).png")
	left.x, left.y = 217, 810
	left.name = "left"
	left.alpha = 0.5

	local down = display.newImage("image/UI/콘솔(하).png")
	down.x, down.y = 330, 924
	down.name = "down"
	down.alpha = 0.5

	--  -----------
	local stopUp = display.newImage("image/UI/상_스트로크.png")
	stopUp.x, stopUp.y = 330, 697

	local stopRight = display.newImage("image/UI/우_스트로크.png")
	stopRight.x, stopRight.y = 442, 810

	local stopLeft = display.newImage("image/UI/좌_스트로크.png")
	stopLeft.x, stopLeft.y = 218, 810

	local stopDown = display.newImage("image/UI/하_스트로크.png")
	stopDown.x, stopDown.y = 330, 923

	local character = display.newImageRect("image/캐릭터/pixil(앞)-0.png", 120, 120)
	character.x, character.y = display.contentWidth*0.5, display.contentHeight*0.5   -- 주인공

	local talk1 = display.newImage("image/대화창/대화창1.png")
	talk1.x, talk1.y = display.contentWidth*0.5, display.contentHeight*0.7 
	talk1:scale(0.63, 0.78) -- 대화창

	local interact_button = display.newImage("image/상호작용버튼/interact_button-1.png")
	interact_button.x, interact_button.y = 1560, 810
	interact_button.alpha = 0.5
	
	local personGroup = composer.getVariable( "personGroup" )  

	-- 레이어 정리
	sceneGroup:insert(background)
	sceneGroup:insert(room)
	sceneGroup:insert(explanation)
	sceneGroup:insert(inventory)
	sceneGroup:insert(back)
	sceneGroup:insert(item_Change)
	sceneGroup:insert(stopRight)
	sceneGroup:insert(character)
	sceneGroup:insert(talk1)
	sceneGroup:insert(up)
	sceneGroup:insert(down)
	sceneGroup:insert(left)
	sceneGroup:insert(right)
	sceneGroup:insert(stopUp)
	sceneGroup:insert(stopDown)
	sceneGroup:insert(stopLeft)
	sceneGroup:insert(stopRight)
	sceneGroup:insert(interact_button)
	sceneGroup:insert(personGroup)

-- ↑ 시작화면 배치 ---------------------------------------------------------------------------------------
-- ↓ json ----------------------------------------------------------------------------------
	local Data = jsonParse( "2층/거짓말쟁이방/json/열쇠획득.json" )

	local dialog = display.newGroup()

	local content = display.newText(dialog, Data[1].content, display.contentWidth*0.63, display.contentHeight*0.78, display.contentWidth*0.5, display.contentHeight*0.2, font_Speaker)
	content:setFillColor(0)
	content.size = 45

	if Data then
		print(Data[1].content)
	end
	local index = 0

	local function nextScript( event )
		index = index + 1
		if(index > #Data) then 
			display.remove(dialog)
			composer.gotoScene("2층.2층로비")  -- 2층 로비로 이동
			return
		end

		content.text = Data[index].content
	end

	talk1:addEventListener("tap", nextScript)
	dialog:toFront()

-- ↑ json ----------------------------------------------------------------------------------
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
		composer.removeScene('2층.거짓말쟁이방.clear2') -- 추가
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------
composer.recycleOnSceneChange = true
return scene