function interpolateBetween(start_x, start_y, start_z, end_x, end_y, end_z, seconds)
  global.player = game.player
  x_diff = end_x - start_x
  y_diff = end_y - start_y
  z_diff = end_z - start_z
  global.max_ticks = seconds * 60
  global.x_change_per_tick = x_diff / global.max_ticks
  global.y_change_per_tick = y_diff / global.max_ticks
  global.z_change_per_tick = z_diff / global.max_ticks

  global.ticker = 0
  global.start_y = start_y
  global.start_x = start_x
  global.start_z = start_z
  script.on_event(defines.events.on_tick, function()
    global.ticker = global.ticker + 1
    if global.ticker < global.max_ticks then
      new_x = global.start_x + global.x_change_per_tick * global.ticker
      new_y = global.start_y + global.y_change_per_tick * global.ticker
      new_z = global.start_z + global.z_change_per_tick * global.ticker
      global.player.zoom_to_world({new_x, new_y}, new_z) 
    end
  end)
end

function interpolateTo(end_x, end_y, end_z, seconds)
  if (global.last_x == nil) then
    global.last_x = 0
    global.last_y = 0
    global.last_z = 1
    game.player.zoom_to_world({global.last_x, global.last_y}, global.last_z) 
  end
  interpolateBetween(global.last_x, global.last_y, global.last_z, end_x, end_y, end_z, seconds)
  global.last_x = end_x
  global.last_y = end_y
  global.last_z = end_z
end
global.last_x = nil
interpolateTo(100, 100, 2, 0.01)
