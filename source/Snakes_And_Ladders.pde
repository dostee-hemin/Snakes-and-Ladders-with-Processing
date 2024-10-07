// Dimension must be no less than 3 (board size = dimension * dimension)
int dimension;
// Number of players must be no more than 10
int numberOfPlayers;
Tile[] board;
Player[] players;
Passage[] passages;

float angleOffset;
float spacing;
int currentTurn;
int currentRoll;
boolean canRoll;
boolean rollGoesOver;
int rollCount;
float tileSize;

float playerMovementSpeed = 0.2;
int dimensionSelected = 10;
int GameState = -3;
int currentPlayerColorSelect = 0;

color[] chosenColors;
color[] playerColors = {
  color(0, 150, 255), 
  color(255, 255, 0), 
  color(0, 255, 0), 
  color(255, 50, 50), 
  color(255, 126, 249), 
  color(255, 145, 0), 
  color(242), 
  color(136, 100, 255), 
  color(3, 244, 255), 
  color(50, 160, 0)
};

void setup() {
  size(900, 800);

  LoadImages();
  textFont(createFont("BalooChettan2-Bold.ttf", 100));
  
  rectMode(CENTER);
  imageMode(CENTER);
  textAlign(CENTER);
}

void draw() {
  switch(GameState) {
  case -3:
    DisplayNumberOfPlayersSelect();
    break;
  case -2:
    DisplayColorSelect();
    break;
  case -1:
    DisplayDimensionSelect();
    break;
  case 0:
    DisplayGame();

    for (Player p : players) {
      p.update();
    }

    if (rollCount > 0) {
      if (frameCount % 5 == 0) {
        rollCount--;
        currentRoll = floor(random(1, 7));
      }
    } else if (rollCount == 0) {
      players[currentTurn].move(currentRoll);
      rollCount--;
    }
    break;
  case 1:
    DisplayEndScreen();
    break;
  }
}
