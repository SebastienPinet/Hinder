window.Resource =
  images: {
            wall_1: {path: "/assets/textures/wall_1.jpg", loaded: "false"}, 
            wall_2: {path: "/assets/textures/wall_2.jpg", loaded: "false"}, 
            wall_3: {path: "/assets/textures/wall_3.jpg", loaded: "false"},
            door: {path: "/assets/textures/door.png", loaded: "false"},
            player: {path: "/assets/textures/player_low.png", loaded: "false"},
            player_low: {path: "/assets/textures/player_low_low.png", loaded: "false"},
            enemy: {path: "/assets/textures/monster.png", loaded: "false"},
            enemy_active: {path: "/assets/textures/monster_active_low.png", loaded: "false"},
            enemy_passive: {path: "/assets/textures/monster_passive.png", loaded: "false"},
            rescue: {path: "/assets/textures/rescue.png", loaded: "false"},  
            block: {path: "/assets/textures/box.jpg", loaded: "false"},
            block_active: {path: "/assets/textures/box_active.jpg", loaded: "false"},
            crate: {path: "/assets/textures/crate.jpg", loaded: "false"},
            wall_shadow: {path: "/assets/textures/wall_shadow.png", loaded: "false"},
            door_shadow: {path: "/assets/textures/door_shadow.png", loaded: "false"},
            block_shadow: {path: "/assets/textures/box_shadow.png", loaded: "false"},
            block_shadow_active: {path: "/assets/textures/box_shadow_active.png", loaded: "false"},
            crate_shadow: {path: "/assets/textures/crate_shadow.png", loaded: "false"},
            shadow_map: {path: "/assets/textures/shadow_map.png", loaded: "false"},
            marker: {path: "/assets/textures/marker.jpg", loaded: "false"},
            crack: {path: "/assets/textures/crack_tile_2.png", loaded: "false"},
            hole: {path: "/assets/textures/hole_tile.png", loaded: "false"},
            darkness: {path: "/assets/textures/darkness.png", loaded: "false"},
            shadow_overlay: {path: "/assets/textures/shadow_overlay.png", loaded: "false"}
          }

  preload: (@callback) ->
    if Map.floor
      @images.shadow_map = {path: "/assets/textures/#{Map.floor}", loaded: "nocache"}
    else if @images.shadow_map.loaded == "nocache"
      @images.shadow_map = {path: "/assets/textures/shadow_map.png", loaded: "false"}
    if Map.overlay
      @images.shadow_overlay = {path: "/assets/textures/#{Map.overlay}", loaded: "nocache"}
    else if @images.shadow_overlay.loaded == "nocache"
      @images.shadow_overlay = {path: "/assets/textures/shadow_overlay.png", loaded: "false"}

    @halt = false
    @unloaded = 0
	
    for own name, image of @images
      if image.loaded == "false" || image.loaded == "nocache"
        @halt = true
        @unloaded++
        obj = $("<img src=\"#{image.path}\">")
        @images[name].obj = obj.get(0)
        @images[name].loaded = true
        obj.load => @loaded()
    if @unloaded == 0 && @halt == false
      @loaded()

  loaded: () ->
    @unloaded--
    if @unloaded <= 0 
      @callback()