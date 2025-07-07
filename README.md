# mmortt
Godot MMORTT

### Network States
#### Server
1. [x] Connect
   1. [x] Connect to Nakama service
   2. [x] Advance to create
2. [x] Create
   1. [x] Add a camera to client scene
   2. [x] Load the map
      1. [x] Basic floor
      2. [x] Basic obstacles
      3. [x] Ignore editor tab error regarding instance bindings for TileMapLayer
   3. [x] Add AStarGrid2D to Map scene, load the TileMapLayer into it
      1. [x] Automatically load and parse the TileGridLayer map data into Astar
      2. [x] Render a test path using draw functionality
   4. [x] Create the match in Nakama
   5. [x] Advance to simulate
3. [ ] Simulate
   1. [ ] Start the simulation tick
      1. [ ] Simulation Nodes must be assigned int ID's and all logic evaluated in order
      2. [ ] Order's must also be processed in exactly the same order
   2. [ ] Needs to facilitate live join
      1. [ ] Simulation must have a means of creating full state from deterministic structs
      2. [ ] This can run on a modulo, or every single tick
   3. Use a smaller state machine instance to track each client through the remote state and control the remote state machine
   4. You can copy the state to a thread using deep(true) and await the function, this can just be done for a client joining
   5. Advance to conclude after game timer expires
4. Conclude

#### Client
1. [ ] Connect [connect]
   1. [ ] Connect to Nakama service [connect]
   2. [ ] Advance to join_server
2. [ ] Join [join_server]
   1. [ ] Select your loadout for deployment [select_loadout]
      1. [ ] Create a generic unit out of Node2D
   2. Send a compliant loadout to the server [select_loadout]
   3. [ ] Join the match in Nakama [join_match]
   4. [ ] Be informed of the map [load_map]
   5. [ ] Load the map [load_map]
   6. [ ] Be assigned to a team [join_team]
   7. [ ] Advance to sync
3. Sync
   1. Receive the full game state snapshot
      1. Units must cache state for special ticks
   2. Receive ticks from full game state tick
   3. Catch up to the current frame
   4. Advance to play
4. Play
   1. Issue group unit orders
   2. Advance to result
5. Result
   1. View result screen
   2. Return to loadout screen

### Lockstep Simulation
1. Client will send input
2. Server will send input
3. Game logic and processing will be deterministic
4. Simulation will not run physics
5. Presentation may run physics for simulated collision avoidance
6. Server will stream input to all clients
7. Server will will run the simulation to support live-join
8. Server will stream state checksum to clients for comparison
9. Client will send group orders to the server
10. Server will send authoritative group path using fixed vectors back to clients
11. Server and Client will use AStarGrid2D for pathing
12. Clients will deterministically identify individual unit destinations, from group order
   1. Group order will be sent with fixed vector 2i, using grid coordinates
   2. Translation from FixedVector to Fixed (Byte/Byte) will be used to save bandwidth
   3. This can be done per destination or along waypoints
13. All units will use a state machine, based on orders and simulation position
14. Processing of all unit logic will take place deterministically (ordered)
15. A hard line of separation will exist between simulation and presentation

### Live Join
1. Server will mintain a stateful dictionary of structs
2. When a client joins, server will start a thread to live-join the client, copying the stateful dictionary of structs
3. Server ill annotate what tick the client joined and stream all ticks from that frame
4. Client will speed up the simulation to join in progress
5. Use Opcodes with RTAPI, channels for for chat or other handling

### Rendering
1. Units will use an off-set tether to simulate collision avoidance, there will be no actual collision avoidance
2. If units end up occupying the same position, determine if this is acceptable or implement deterministic logic to resolve
3. 2D Art Created 100% By me. Top Down, No humanoids.

### Tech Stack:
---
- GODOT
- Nakama
- SGPhysics2D
- FSM Plugin
- Inkscape Vector Art

### Game Features:
- MMORTT
- Compelling Squad Loadout customization
- Compelling Unit Loadout customzation (Unit Augments)
- Ability Augments for Units
- Growing and Growing list of units
- Commanders with Passives
- RTS Micro-like gameplay
- POI Control, Base Destruction, and CTF Modes