void keyPressed() {
  switch(key) {
  case 'r':
    Reset();
    break;
  case 'n':
    if (GameState > -1) {
      SetupBoard();
    }
    break;
  case ' ':
    if (canRoll) {
      canRoll = false;
      rollGoesOver = false;
      rollCount = 10;
    }
    break;
  }
}

void mousePressed() {
  switch(GameState) {
  case -3:
    for (int i=0; i<3; i++) {
      for (int j=0; j<3; j++) {
        int index = i*3 + j;
        float x = 300 + j*150;
        float y = 250 + i*150;
        if (mouseX > x-60 && 
          mouseX < x+60 && 
          mouseY > y-60 && 
          mouseY < y+60) {
          GameState = -2;
          numberOfPlayers = index+1;
          chosenColors = new color[numberOfPlayers];
          for (int k=0; k<numberOfPlayers; k++) {
            chosenColors[k] = color(0);
          }
        }
      }
    }

    if (mouseX > width/2-130 && 
      mouseX < width/2+130 && 
      mouseY > 680 && 
      mouseY < 720) {
      GameState = -2;
      numberOfPlayers = 10;
      chosenColors = new color[numberOfPlayers];
      for (int i=0; i<numberOfPlayers; i++) {
        chosenColors[i] = color(0);
      }
    }
    break;
  case -2:
    for (int i=0; i<5; i++) {
      for (int j=0; j<2; j++) {
        int index = i + j*5;
        if (!colorExists(playerColors[index])) {
          float x = width/2 - 300 + i*150;
          float y = height/2 - 100 + j*200;
          if (dist(x, y, mouseX, mouseY) < 50) {
            chosenColors[currentPlayerColorSelect] = playerColors[index];
            currentPlayerColorSelect++;
            if (currentPlayerColorSelect == numberOfPlayers) {
              GameState = -1;
            }
          }
        }
      }
    }
    break;
  case -1:
    if (dist(mouseX, mouseY, width/2-175, height/2) < 50) {
      dimensionSelected --;
      if (dimensionSelected < 3) {
        dimensionSelected = 3;
      }
    } else if (dist(mouseX, mouseY, width/2+175, height/2) < 50) {
      dimensionSelected ++;
      if (dimensionSelected > 30) {
        dimensionSelected = 30;
      }
    } else if (mouseX > width/2-125 &&
      mouseX < width/2+125 &&
      mouseY > height-250 &&
      mouseY < height+250) {
      GameState = 0;
      dimension = dimensionSelected;
      SetupBoard();
    }
    break;
  }
}
