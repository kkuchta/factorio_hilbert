function zoomTo(pos)
  global.pos = pos
  global.player.zoom_to_world({pos.x, pos.y}, pos.z)
end

function pushMove(pos, ticks)
  if (global.pos == nil) then
    zoomTo(pos)
  else
    table.insert(global.moves, 1, {pos=pos, ticks=ticks})
  end
end

function startTicker()
  global.moves = {}
  global.remaining_ticks = 0
  script.on_event(defines.events.on_tick, function(event)
    if (not global.remaining_ticks or global.remaining_ticks == 0) then
      move = table.remove(global.moves)
      if (not move) then
        return
      end
      global.remaining_ticks = move.ticks
      global.x_change = (move.pos.x - global.pos.x) / move.ticks
      global.y_change = (move.pos.y - global.pos.y) / move.ticks
      global.z_change = (move.pos.z / global.pos.z) ^ (1/move.ticks)
    end
    global.remaining_ticks = global.remaining_ticks - 1
    zoomTo({x=(global.pos.x + global.x_change), y=(global.pos.y + global.y_change), z=(global.pos.z * global.z_change)})
  end)
end

function stopTicker()
  script.on_event(defines.events.on_tick, function() end)
end

function myVid()
  game.player.spectator = true
  global.pos = nil
  global.player = game.player

  script.on_event(defines.events.on_tick, function()
    belt = game.get_surface('nauvis').find_entities({{-66,-65}, {-62,-64}})[1]
    items = belt.get_transport_line(1).get_item_count()
    if (items > 0) then
      stopTicker()
      startTicker()
      x = -63
      y = -63
      z = 14
      t = 0.4
      dist = 1
      t_percent = 0.25
      pushMove({x=x,y=y,z=z}, 1)
      iterations = 7
      for i=1,iterations do
        pushMove({x=x,y=y,z=z}, math.floor(60*t*(1-t_percent)))
        x = x + dist
        y = y + dist
        z = z / 2
        if i < iterations then
          pushMove({x=x,y=y,z=z}, math.floor(60*t*t_percent))
      
          t = t * 4
          dist = dist * 2
        end
      end
    end
  end)
end
myVid()