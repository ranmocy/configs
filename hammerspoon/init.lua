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
