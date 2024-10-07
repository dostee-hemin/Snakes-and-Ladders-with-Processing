class Tile {
  PVector location;
  int tileNumber;

  Tile(float x, float y, int tileNumber) {
    location = new PVector(x, y);
    this.tileNumber = tileNumber;
  }

  void display() {
    noTint();
    if(tileNumber == board.length) {
      image(tileTypeFinish, location.x,location.y);
    } else if (tileNumber % 2 == 0) {
      image(tileType1, location.x,location.y);
    } else {
      image(tileType2, location.x,location.y);
    }
    fill(150);
    textSize(tileSize/2.2);
    text(tileNumber, location.x+tileSize*0.05, location.y + tileSize*0.11);
    fill(255);
    textSize(tileSize/2.3);
    text(tileNumber, location.x, location.y + tileSize*0.1);
  }
}
