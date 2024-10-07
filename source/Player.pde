class Player {
  PVector location;
  PVector target;
  color playerColor;
  int currentTile = -1;
  int movesLeft = 0;
  boolean isOverlapped;
  Passage passageTaken = null;
  boolean canBeDisplayed = true;

  Player(float y, color playerColor) {
    location  = new PVector(40, y);
    target = location;
    this.playerColor = playerColor;
  }

  void display() {
    if (canBeDisplayed) {
      tint(playerColor);
      image(playerImage, location.x,location.y, tileSize/1.5, tileSize/1.5);
    }
  }

  void update() {
    if (passageTaken != null) {
      if (!passageTaken.movePlayer(this)) {
        target = passageTaken.endLocation.copy();
        currentTile = passageTaken.endTile;
        passageTaken = null;
      }
      return;
    }
    location.lerp(target, playerMovementSpeed);
    if (PVector.dist(location, target) < 5) {
      if (movesLeft > 0) {
        currentTile++;
        Tile t = board[currentTile];
        target = t.location.copy();
        movesLeft--;
        CheckForOverlap();
      } else if (movesLeft == 0) {
        if (currentTile == board.length-1) {
          GameState = 1;
          return;
        }
        for (Passage p : passages) {
          if (currentTile == p.startTile) {
            passageTaken = p;
            location = p.startLocation.copy();
            return;
          }
        }
        CheckForOverlap();
        movesLeft--;
        nextTurn();
      }
    }
  }

  void move(int amount) {
    if (currentTile + amount >= board.length) {
      rollGoesOver = true;
      nextTurn();
      return;
    }
    movesLeft = amount;
    Tile t = board[currentTile+1];
    target = t.location.copy();
  }
}
