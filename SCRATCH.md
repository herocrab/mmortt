### Scratch
---
    - [ ] Client
      - [ ] Connect
      - [ ] Select
      - [ ] Join
    - [ ] The server will need a callback to tell the hosts that it is the host after they join.
    - [ ] The client will then need to cache the host and aknowledge it.
    - [ ] The server needs to send the map and meta data to the client
  - [ ] Client
    - [ ] Cache server so that the client is sending to a specific host (the server) and not broadcasting
  - [x] Created automatically refreshing token
---
- [ ] Client connects to Nakama, joins server by default (via param in init file)
- [ ] Client specifies it's unit selection and loadout on join, in lobby phase
- [ ] Server validates client join message is within rule limits (this can later be token auth)
- [ ] Before simulation the map is loaded on both sides, may need to use a "start message" with op codes.
---

At this point the client and server should have bi-directional communication using opcodes

---
- [ ] Server loads map
  - [ ] Map name includes a scene which auto populates objstructions or blocks
  - [ ] Map terrain/background is simple gray
  - [ ] Obstructions or blocks are black
  - [ ] Use NavigationServer2D on the server to identify a path
    - [ ] Convert this path to Grid coordinates (cast to grid), as small as you can go
    - [ ] Find a solution for deterministic group navigation based on this
      - [ ] Use a walkable not-walkable grid map, to resolve destinations
      - [ ] You will need to re-parse the group nav order into inividual unit orders
      - [ ] and the source and destination accordingly all based on Simulation position
      - [ ] You should never reference the units world or float-based position
    - [ ] The server specifies all pathing, nothing is required on the client
  - [ ] Use Simulated Collision Avoidance with units on a tether/pushing/lerping

- [ ] Client can join in-progress, receiving a full state transfer and delta of input tickets
  - [ ] Full state capture will be done on server every N time
  - [ ] Live joining will send the last X number of ticks from full-state to current
  - [ ] Client tick number will be stored on the server, it will be set artificially behind, perhaps this could be negotiated or acked
  - [ ] Use a separate thread to accomodate joining

- [ ] Client speeds-up to be in lockstep with server simulation
- [ ] Client sends input only, validated by server and replicated to other clients
- [ ] Prodution ready RTS boxing and clicking selection system
- [ ] Client can send unit movement input, server receives and places into a tick for streaming
- [ ] Client issues orders, once client receives orders back it uses NavigationServer2D with quantized input
  - [x] Added SGPhysics2D GDExtension for Fixed Math library

- [ ] Client can issue group formation movements
- [ ] Client and Server have collisions turned off
- [ ] Implement unit rendering offset rubber band on a swivel approach for rendering
- [ ] Initial loadout is just square units
- [ ] Collision data for map is read from simple bit-map file, each pixel representing a tile blocking state
- [ ] Client and Server exchange tick hashing to determine if the state is sychronized lockstep simulation
---
- [ ] Start designing the actual core gameplay loop (based on EON and Shattered Galaxy)
- [ ] The unit selection/build client can be separate from the game client, their can be a secure exchange between the two using token auth on the server

### Tech Stack:
---
- GODOT
- SGPhysics2D
- Nakama
- FSM Plugin

### Technical Design Constraints:
---
- 2D
- Engine Native (logging, debug, etc)
- No UI
- No Unit design, top-down or isometric, just block

### Future Graphic Design
- Simple Block Bench models/ Units
- Simple terrain
- 3D to Isometric 2D Pipeline