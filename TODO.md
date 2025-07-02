### Network States

#### Server
1. Connect
2. Create
3. Simulate
   1. Needs to facilitate live join
   2. Use a smaller state machine instance to track each client through scenes
   3. You can copy the state to a thread using deep(true) and await the function, this can just be done for a client joining
   4. AI should still be controlled by simulation on each client
4. Conclude

I need a smaller state machine scene instance, that gets created to faciliate live join for each client.

#### Client
1. Connect
2. Join
   1. Select your loadout for deployment
   2. Send a compliant loadout to the server
   3. Be assigned to a team
   4. Advance to sync
3. Sync
   1. Receive the full game state snapshot
   2. Receive ticks from full game state tick
   3. Catch up to the current frame
   4. Advance to play
4. Play
   1. Issue group unit orders
   2. Advance to play
5. Result
   1. View result screen
   2. Return to loadout screen