void Reset() {
  GameState = -3;
  currentPlayerColorSelect = 0;
  dimensionSelected = 10;
  if (GameState < 0) {
    return;
  }
  SetupBoard();
}

void SetupBoard() {
  board = new Tile[dimension*dimension];
  players = new Player[numberOfPlayers];
  passages  = new Passage[dimension];

  GameState = 0;
  currentTurn = 0;
  currentRoll = 0;
  canRoll = true;
  rollGoesOver = false;
  rollCount = -1;
  angleOffset = PI/numberOfPlayers;
  spacing = angleOffset * 2;


  tileSize = 600.0/float(dimension);
  float offset = tileSize * 0.5;
  for (int i=0; i<dimension; i++) {
    float y = height-100-i*tileSize - offset;
    for (int j=0; j<dimension; j++) {
      float x = width-150 - j*tileSize - offset;
      if (i%2 == 0) {
        x = 150+j*tileSize + offset;
      }
      board[(i*dimension)+j] = new Tile(x, y, (i*dimension)+j+1);
    }
  }

  for (int i=0; i<players.length; i++) {
    players[i] = new Player(120 + i*60, chosenColors[i]);
  }

  for (int i=0; i<passages.length; i++) {
    if (i % 2 == 0) {
      passages[i] = new Snake();
    } else {
      passages[i] = new Ladder();
    }
  }

  for (Passage p : passages) {
    p.FindStartTile();
  }

  int t = int(tileSize);
  tileType1.resize(t, t);
  tileType2.resize(t, t);
  tileTypeFinish.resize(t, t);
}

color darker(color original) {
  return color(red(original) * 0.6, green(original) * 0.6, blue(original) * 0.6);
}

boolean colorExists(color c) {
  for (color current : chosenColors) {
    if (current == c) {
      return true;
    }
  }
  return false;
}

void CheckForOverlap() {
  for (int i=0; i<players.length; i++) {
    Player p = players[i];
    boolean result = false;
    for (int j=0; j<players.length; j++) {
      if (i == j) {
        continue;
      }
      Player other = players[j];
      if (other.currentTile == p.currentTile) {
        other.isOverlapped = true;
        result = true;
      }
    }
    p.isOverlapped = result;
  }

  for (int i=0; i<players.length; i++) {
    Player p = players[i];
    if (p.currentTile == -1) {
      continue;
    }
    if (p.isOverlapped && p.movesLeft < 1) {
      Tile t = board[p.currentTile];
      PVector dir = PVector.fromAngle(TWO_PI - angleOffset - spacing*i).setMag(tileSize/4.44);
      p.target = t.location.copy().add(dir);
      p.isOverlapped = false;
    } else {
      Tile t = board[p.currentTile];
      p.target = t.location.copy();
    }
  }
}

void nextTurn() {
  currentTurn++;
  if (currentTurn > players.length-1) {
    currentTurn = 0;
  }
  if (!rollGoesOver) {
    currentRoll = 0;
  }
  canRoll = true;
}
