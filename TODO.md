### Successful MVP
---

- [ ] Setup Godot 4.4 and VSCODE Integration
- [ ] Ability to launch multiple scenes indepedently
  - [ ] Support debugging of multiple apps running at the same time
    - [ ] (1) server
    - [ ] (2) clients
- [ ] Server init from data file with params needed for Nakama
- [ ] Server registers game with Nakama, as authoritative server host
- [ ] Client init from data file
- [ ] Client connects to Nakama, joins server by default (via param in init file)
- [ ] Client specifies it's unit selection and loadout on join
- [ ] Server validates client join message is within rule limits (this can later be token auth)
- [ ] Client can join in-progress, receiving a full state transfer and delta of input tickets
- [ ] Client speeds-up to be in lockstep with server simulation
- [ ] Client sends input only, validated by server and replicated to other clients
- [ ] Prodution ready RTS boxing and clicking selection system
- [ ] Client can send unit movement input, server receives and places into a tick for streaming
- [ ] Client movement utilizes deterministic A* integry based Grid
- [ ] Client can issue group formation movements
- [ ] Client uses collision avoidance using tile blocked checking
- [ ] Initial loadout is just square units
- [ ] Collision data for map is read from simple bit-map file, each pixel representing a tile blocking state
- [ ] Client and Server exchange tick hashing to determine if the state is sychronized lockstep simulation
---
- [ ] Start designing the actual core gameplay loop (based on EON and Shattered Galaxy)
- [ ] The unit selection/build client can be separate from the game client, their can be a secure exchange between the two using token auth on teh server

Tech Stack:
---
- GODOT
- Nakama

Technical Design Constraints:
---
- 2D
- GDScript

