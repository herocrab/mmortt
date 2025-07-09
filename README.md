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
3. [x] Simulate
   1. [x] Simulation Tick
      1. [x] SimulationNode
      2. [x] SimulationNode Dictionary with Add/Remove API
      3. [x] Simulation Nodes must be assigned int ID's and all logic evaluated in order
         1. [x] _simulation_update
      5. [x] Make the update tick also deterministic
         1. [x] _presentation_update
      6. [x] Create the server player, this will be needed to sync the state of all existing AI controlled units.
   2. [ ] <mark>Client joining up to the point it needs a remote-client state machine</mark>
      1. [ ] <mark>This should happen upon joining a match</mark>
   3. [ ] Remote-client State machine
      1. [ ] Server tracks the state of each remote client to faciliate live join
   6. [ ] Advance to conclude after game timer expires
4. [ ] Conclude

### Client (local) vs client (remote)
join -> remote_join
load -> remote_load
sync -> remote_sync
play -> remote_play
result -> remote_result

#### Client
1. [x] Connect
   1. [x] Connect to Nakama service
   2. [x] Advance to join
2. [ ] <mark>Join</mark>
   1. [ ] <mark>Select your loadout for deployment</mark>
      1. [x] Create a square unit in inkscape
      2. [x] Create a basic Square unit
      3. [x] Create a UnitDb to house the Units by byte enum ID
      4. [x] Add units for a basic loadout in join class, for ease
   2. [ ] Join a match in Nakama
      1. [ ] First match with a spot available, server checks player count
      2. [ ] Server sends disconnect request to clients if there are no slots available
      3. [ ] Server callback for match player joined
      4. [ ] Send loadout to the server and receive acknowledgement before loading
         1. [ ] Server assigns a location (server side)
         2. [ ] Server adds a "create" message to the game tick (first input message)
         3. [ ] Server creates the units
3. [ ] Load
   1. [ ] Load the map
   3. [ ] Advance to sync
4. Sync
   1. Receive the full game state snapshot at the most recent state tick
      1. Units must cache state for special ticks
      2. Copy the state into a thread using deep(true) and await, to free the main thread
   2. Receive ticks from full game state tick
   3. Catch up to the current frame
   4. Advance to play
5. Play
   1. Issue group unit orders
      1. Selection will use bitmasks, or bit shifting for up to 16 units, this will be consistent 2byte bandwidth
   2. Advance to result
6. Result
   1. View result screen
   2. Return to loadout screen

### Lockstep Simulation
1. Client will send input
2. Game logic will be deterministic
3. Simulation will not run physics
4. Presentation may run physics for simulated collision avoidance
5. Server will stream input to all clients
6. Server will will run the simulation to support live-join
7. Server will stream state checksum to clients for comparison
8. Client will send group orders to the server
9. Server and Client will use AStarGrid2D for pathing
10. Clients will deterministically identify individual unit destinations, from group order
   1. Group order will be sent with fixed vector 2i, using grid coordinates
   2. Translation from FixedVector to Fixed (Byte/Byte) will be used to save bandwidth
   3. This can be done per destination or along waypoints
11. All units will use a state machine, based on orders and simulation position
12. A hard line of separation will exist between simulation and presentation layers

### Live Join
1. Server will mintain a stateful dictionary of structs
2. When a client joins, server will start a thread to live-join the client, copying the stateful dictionary of structs
3. Server will annotate what tick the client joined and stream all ticks from that frame to current
4. Client will speed up the simulation to join in progress
5. Use Opcodes with RTAPI for game state and input, use channels for for chat or other generic handling

### Command Processing
Commands Received --> Assigned Player ID (byte) --> Assigned to Command Processing Queue for Next Tick --> Processed on the Following Tick --> Uses Bitmask (4 bytes), for a total of 32 units plus abilities.

### Rendering
1. Units will use an off-set tether to simulate collision avoidance, there will be no actual collision avoidance
   1. Implement Rapier 2D Physics, to maintain close to deterministic rendering
2. If units end up occupying the same position, determine if this is acceptable or implement deterministic logic to resolve
3. 2D Art Created 100% By me. Top Down, No humanoids.

### Unit Design
Turret Types:
- RotatingTurret
- FixedTurret
- NoTurret

Unit Types:
- Ground
- Air

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