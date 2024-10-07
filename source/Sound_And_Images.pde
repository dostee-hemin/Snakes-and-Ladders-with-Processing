PImage backgroundImage;
PImage winnerImage;
PImage playerImage;
PImage woodImage;
PImage tileType1;
PImage tileType2;
PImage tileTypeFinish;

void LoadImages() {
  backgroundImage = loadImage("Images/background.png");
  winnerImage = loadImage("Images/winner.png");
  winnerImage.resize(900, 800);
  playerImage = loadImage("Images/player.png");
  woodImage = loadImage("Images/wood.jpg");
  woodImage.resize(900, 800);
  tileType1 = loadImage("Images/tile1.png");
  tileType2 = loadImage("Images/tile2.png");
  tileTypeFinish = loadImage("Images/tile3.png");
}
