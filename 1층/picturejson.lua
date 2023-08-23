-----------------------------------------------------------------------------------------
--
-- view2.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	-- ↓ 배경 ----------------------------------------------------------------------------------------------------
	local backgroundY = composer.getVariable("backgroundY")

	local background = display.newImageRect("image/배경/배경_저택_1층.png", 2000, 2000)
	background.x, background.y = display.contentWidth/2, backgroundY
	sceneGroup:insert(background)

	-- ↓ ui정리 ------------------------------------------------------------------------------------------------------------
	
	local restart = display.newImage("image/UI/세모.png")
	restart.x, restart.y = 1820, 80

	local inventory = display.newImage("image/UI/인벤토리.png")
	inventory.x, inventory.y = 240, 80

	local question = display.newImage("image/UI/물음표.png")
	question.x, question.y = 100, 80

	local chatBox = display.newImage("image/UI/대화창 ui.png")
	chatBox.x, chatBox.y = display.contentWidth/2, display.contentHeight * 0.76

	local quest = display.newImageRect("image/UI/퀘스트창.png", 1400, 400)
	quest.x, quest.y = display.contentWidth/2, display.contentHeight * 0.76
	quest.alpha = 0

	sceneGroup:insert(restart)
	sceneGroup:insert(inventory)
	sceneGroup:insert(question)

	-- ↑ ui정리 -------------------------------------------------------------------------------------------------

	local dialog = display.newGroup()

	local image_pi = display.newImage("image/캐릭터/파이 기본.png")
	image_pi.x, image_pi.y = display.contentWidth*0.2, display.contentHeight*0.5

	local speaker = display.newText(dialog, "파이", display.contentWidth*0.25, display.contentHeight*0.73, display.contentWidth*0.2, display.contentHeight*0.1, font_Speaker)
	speaker:setFillColor(0)
	speaker.size = 50
	
	local content = display.newText(dialog, "그림이... 오래된 게임이라지만 참 볼품없네.", display.contentWidth*0.5, display.contentHeight*0.88, display.contentWidth*0.7, display.contentHeight*0.2, font_Content)
	content:setFillColor(0)
	content.size = 40

	sceneGroup:insert(dialog)
	sceneGroup:insert(image_pi)
	sceneGroup:insert(chatBox)
	sceneGroup:insert(quest)
	sceneGroup:insert(speaker)
	sceneGroup:insert(content)


	-- json에서 정보 읽기
	local Data = jsonParse("1층/json/picture.json")

	-- json에서 읽은 정보 적용하기
	local index = 0

	local function nextScript( event )
		index = index + 1
		if(index > #Data) then 
			composer.hideOverlay("1층.picturejson")
			composer.gotoScene( "1층.game_lobby" ) 
			return
		end
		
		speaker.text = Data[index].speaker
		content.text = Data[index].content

		if index == 3 then
			image_pi.alpha = 0
			chatBox.alpha = 0
			quest.alpha = 1
			content.x, content.y = display.contentWidth*0.55, display.contentHeight*0.88
			content.size = 50
		end
	end
	chatBox:addEventListener("tap", nextScript)
	quest:addEventListener("tap", nextScript)
	-- image_cherry::addEventListener("tap", nextScript)
	-- image_pi::addEventListener("tap", nextScript)

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
		composer.removeScene( "1층.picturejson" )
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

return scene
