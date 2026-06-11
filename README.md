# BaboViolent 2 Dedicated Server Docker

A Docker container for running a BaboViolent 2 dedicated server.

## Server Requirements

| | Minimum | Recommended |
|---|---|---|
| CPU | 1 core | 2 cores |
| RAM | 512 MB | 1 GB |
| Storage | 1 GB | 1 GB |

## How to use

Copy the `.env.example` file to `.env`, fill in your values, then use either `docker compose` or `docker run`.

### Docker Compose

```yaml
services:
  baboviolent2:
    image: ghcr.io/thnaylor/baboviolent2:edge
    restart: unless-stopped
    container_name: baboviolent2
    stop_grace_period: 30s
    ports:
      - '3333:3333/tcp'
      - '3333:3333/udp'
    environment:
      PUID: 1000
      PGID: 1000
    env_file:
      - .env
    volumes:
      - ./server-files:/home/babo/server-files
```

```bash
docker compose up -d
```

### Docker Run

```bash
docker run -d \
    --restart unless-stopped \
    --name baboviolent2 \
    --stop-timeout 30 \
    --env-file .env \
    -e PUID=1000 \
    -e PGID=1000 \
    -p 3333:3333/tcp \
    -p 3333:3333/udp \
    -v ./server-files:/home/babo/server-files \
    ghcr.io/thnaylor/baboviolent2:edge
```

## Environment Variables

### Server Identity

| Variable | Default | Description |
|---|---|---|
| PUID | 1000 | User ID to run the server process as |
| PGID | 1000 | Group ID to run the server process as |
| GAME_MODE | FFA | Game mode: FFA, CTF, TDM, or Champion |
| GAMETYPE_ROTATION | | Space-separated gametype IDs to rotate (e.g. `0 1 2`). Empty = fixed GAME_MODE |
| SERVER_NAME | BaboViolent 2 Server | Display name for your server |
| MAX_PLAYERS | 16 | Maximum number of simultaneous players |
| MAX_PLAYERS_IN_GAME | 0 | Max players in-game (0 = no spectator limit) |
| PORT | 3333 | Server port (TCP and UDP) |
| PASSWORD | | Server password (empty = no password) |
| GAME_PUBLIC | false | Register on master server (true/false) |
| ADMIN_USER | | Admin username |
| ADMIN_PASS | | Admin password |

### Gameplay

| Variable | Default | Description |
|---|---|---|
| FRIENDLY_FIRE | false | Enable friendly fire |
| REFLECTED_DAMAGE | false | Reflect damage to attacker on friendly fire |
| RESPAWN_TIME | 5 | Seconds before respawn |
| FORCE_RESPAWN | false | Force automatic respawn |
| ROUND_TIME_LIMIT | 360 | Round time limit in seconds |
| GAME_TIME_LIMIT | 900 | Game time limit in seconds |
| SCORE_LIMIT | 50 | Score needed to win |
| WIN_LIMIT | 7 | Rounds needed to win |
| BOMB_TIME | 60 | Bomb timer in seconds (CTF/bomb mode) |
| SLIDE_ON_ICE | false | Enable ice sliding physics |
| SHOW_ENEMY_TAG | false | Show enemy nametags |
| AUTO_BALANCE | false | Auto-balance teams (recommended for CTF/TDM) |
| AUTO_BALANCE_TIME | 4 | Seconds before teams are rebalanced |
| ENABLE_VOTE | true | Allow voting |
| SPAWN_IMMUNITY_TIME | 2 | Invincibility seconds after spawn |
| MIN_TILES_PER_BABO | 55 | Minimum map size filter (tiles per player) |
| MAX_TILES_PER_BABO | 80 | Maximum map size filter (tiles per player) |

### Server UX

| Variable | Default | Description |
|---|---|---|
| SEND_JOIN_MESSAGE | true | Show a message when players join |
| JOIN_MESSAGE | Welcome to the server! | Message shown on join |
| MAX_PING | 1000 | Kick players above this ping (1000 = disabled) |
| SHOW_KILLS | false | Show kill messages |
| MAX_UPLOAD_RATE | 8 | KB/s upload cap per client |

### Weapon Enables

| Variable | Default | Description |
|---|---|---|
| ENABLE_SMG | true | Enable SMG |
| ENABLE_SHOTGUN | true | Enable Shotgun |
| ENABLE_SNIPER | true | Enable Sniper |
| ENABLE_DUAL_MG | true | Enable Dual Machine Guns |
| ENABLE_CHAIN_GUN | true | Enable Chain Gun |
| ENABLE_BAZOOKA | true | Enable Bazooka |
| ENABLE_SHOTGUN_RELOAD | true | Enable Shotgun Reload variant |
| ENABLE_FLAMETHROWER | true | Enable Flamethrower |
| ENABLE_PHOTON_RIFLE | true | Enable Photon Rifle |
| ENABLE_SECONDARY | true | Enable secondary weapons |
| ENABLE_KNIVES | true | Enable Knives |
| ENABLE_MOLOTOV | true | Enable Molotov |
| ENABLE_SHIELD | true | Enable Shield |
| ENABLE_MINIBOT | false | Enable Minibot |
| ENABLE_NUCLEAR | false | Enable Nuclear weapon |
| EXPLODING_FT | false | Flamethrower projectiles explode on impact |

### Weapon Stats

| Variable | Default | Description |
|---|---|---|
| ZOOKA_REMOTE_DET | true | Bazooka remote detonation |
| SMG_DAMAGE | 0.1 | SMG damage per hit |
| DMG_DAMAGE | 0.14 | Dual MG damage per hit |
| CG_DAMAGE | 0.16 | Chain Gun damage per hit |
| SNIPER_DAMAGE | 0.34 | Sniper damage per hit |
| SHOTTY_DAMAGE | 0.21 | Shotgun damage per pellet |
| SHOTTY_DROP_RADIUS | 0.35 | Shotgun spread drop-off radius |
| SHOTTY_RANGE | 6.75 | Shotgun effective range |
| ZOOKA_DAMAGE | 0.85 | Bazooka damage |
| ZOOKA_RADIUS | 2 | Bazooka explosion radius |
| NUKE_RADIUS | 6 | Nuclear explosion radius |
| NUKE_TIMER | 3 | Nuclear detonation timer |
| NUKE_RELOAD | 12 | Nuclear reload time |
| FT_DAMAGE | 0.065 | Flamethrower damage per tick |
| FT_MAX_RANGE | 8 | Flamethrower maximum range |
| FT_MIN_RANGE | 1 | Flamethrower minimum range |
| FT_EXPIRATION_TIMER | 1.5 | Flamethrower flame duration |
| PHOTON_DAMAGE_COEFF | 0.65 | Photon Rifle damage coefficient |
| PHOTON_DIST_MULT | 0.65 | Photon Rifle distance multiplier |
| PHOTON_VERTICAL_SHIFT | 0.5 | Photon Rifle vertical shift |
| PHOTON_HORIZONTAL_SHIFT | 2 | Photon Rifle horizontal shift |
| PHOTON_TYPE | 1 | Photon Rifle type |

## Volumes

| Path | Description |
|---|---|
| /home/babo/server-files | Server files and configuration |
