-- A global variable for the Hyper Mode
hyper_mode = hs.hotkey.modal.new({}, "F17")

-- HYPER+CHAR: Act like CMD+ALT+CTRL+CHAR
local all_keys = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ;\',./[]\\`-='
for index = 1, #all_keys do
  local binding_key = all_keys:sub(index, index)
  hyper_mode:bind({}, binding_key, nil, function()
    hs.eventtap.keyStroke({"cmd", "alt", "ctrl"}, binding_key)
    hyper_mode.triggered = true
  end)
end

-- Bind the Hyper key
hyper_hotkey = hs.hotkey.bind({}, 'F18', function()
  -- enter hyper mode
  hyper_mode.triggered = false
  hyper_mode:enter()
end, function()
  -- exit hyper mode, send ESCAPE if no other keys are pressed.
  hyper_mode:exit()
  if not hyper_mode.triggered then
    hs.eventtap.keyStroke({}, 'ESCAPE')
  end
end)


-- Cursor locator

local mouseCircle = nil
local mouseCircleTimer = nil

hyper_mode:bind({}, "D", nil, function ()
  size = 150
    -- Delete an existing highlight if it exists
    if mouseCircle then
        mouseCircle:delete()
        mouseCircle2:delete()
        if mouseCircleTimer then
            mouseCircleTimer:stop()
        end
    end
    -- Get the current co-ordinates of the mouse pointer
    mousepoint = hs.mouse.getAbsolutePosition()
    -- Prepare a big red circle around the mouse pointer
    mouseCircle = hs.drawing.circle(hs.geometry.rect(mousepoint.x-(size/2), mousepoint.y-(size/2), size, size))
    mouseCircle2 = hs.drawing.circle(hs.geometry.rect(mousepoint.x-(size/4), mousepoint.y-(size/4), size/2, size/2))
    mouseCircle:setStrokeColor({["red"]=1,["blue"]=0,["green"]=0,["alpha"]=1})
    mouseCircle2:setStrokeColor({["red"]=1,["blue"]=0,["green"]=0,["alpha"]=1})
    mouseCircle:setFill(false)
    mouseCircle2:setFill(false)
    mouseCircle:setStrokeWidth(3)
    mouseCircle2:setStrokeWidth(5)
    mouseCircle:show()
    mouseCircle2:show()

    -- Set a timer to delete the circle after 3 seconds
    mouseCircleTimer = hs.timer.doAfter(1, function() mouseCircle:delete() mouseCircle2:delete() end)
end)
