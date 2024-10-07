void DisplayNumberOfPlayersSelect() {
  // Display background wood image
  noTint();
  image(woodImage, width/2, height/2);

  // Display title text
  fill(255);
  textSize(50);
  text("Choose number", width/2, 70);
  text("of players", width/2, 130);
  
  // Display a grid of buttons, 
  // each with a different number of players
  strokeWeight(10);
  int s = 50;      // Size of the button
  for (int i=0; i<3; i++) {
    for (int j=0; j<3; j++) {
      // Calculate the number based on the column and row
      int number = i*3 + j + 1;
      
      //Find the x and y position of the button
      float x = 300 + j*150;
      float y = 250 + i*150;
      
      // Display the button
      stroke(200);
      fill(255);
      rect(x, y, 120, 120, 7);
      
      // Display the players inside the button
      switch(number) {
      case 9:
        tint(playerColors[8]);
        image(playerImage, x+20, y+20, s, s);
      case 8:
        tint(playerColors[7]);
        image(playerImage, x-20, y+20, s, s);
      case 7:
        tint(playerColors[6]);
        image(playerImage, x+20, y-20, s, s);
      case 6:
        tint(playerColors[5]);
        image(playerImage, x-20, y-20, s, s);
      case 5:
        tint(playerColors[4]);
        image(playerImage, x, y+20, s, s);
      case 4:
        tint(playerColors[3]);
        image(playerImage, x, y-20, s, s);
      case 3:
        tint(playerColors[2]);
        image(playerImage, x+20, y, s, s);
      case 2:
        tint(playerColors[1]);
        image(playerImage, x-20, y, s, s);
      case 1:
        tint(playerColors[0]);
        image(playerImage, x, y, s, s);
        break;
      }
    }
  }
  
  //Display the tenth button (for ten players)
  stroke(200);
  fill(255);
  rect(width/2, 700, 260, 120, 7);
  
  // Display all the players in the tenth button
  for (int i=0; i<5; i++) {
    for (int j=0; j<2; j++) {
      int index = i + j*5;
      float x = width/2 - 100 + i*50;
      float y = 675 + j*50;
      tint(playerColors[index]);
      image(playerImage, x, y, s, s);
    }
  }
}

void DisplayColorSelect() {
  // Display background wood image
  noTint();
  image(woodImage, width/2, height/2);
  
  // Display title text
  fill(255);
  textSize(60);
  text("Player " + (currentPlayerColorSelect+1) + ",", width/2, 70);
  text("choose your color", width/2, 130);
  
  // Display every color of the players
  // only if it hasn't been selected
  for (int i=0; i<5; i++) {
    for (int j=0; j<2; j++) {
      int index = i + j*5;
      if (!colorExists(playerColors[index])) {
        float x = width/2 - 300 + i*150;
        float y = height/2 - 100 + j*200;
        tint(playerColors[index]);
        image(playerImage, x, y, 150, 150);
      }
    }
  }
}

void DisplayDimensionSelect() {
  // Display background wood image
  noTint();
  image(woodImage, width/2, height/2);
  
  // Display title text
  fill(255);
  textSize(60);
  text("Select the dimension", width/2, 70);
  text("of your grid", width/2, 130);

  // Counter box
  fill(#0072C6);
  stroke(#014476);
  strokeWeight(10);
  rect(width/2, height/2, 200, 100, 10);

  // Dimension size text
  fill(#F0CD02);
  textSize(85);
  text(dimensionSelected, width/2, height/2+30);

  // Dark plus and minus outline
  strokeWeight(25);
  line(width/2-200, height/2, width/2-150, height/2);
  line(width/2+150, height/2, width/2+200, height/2);
  line(width/2+175, height/2 - 25, width/2+175, height/2 + 25);

  // Bright plus and minus filling
  stroke(#037CFA);
  strokeWeight(10);
  line(width/2-200, height/2, width/2-150, height/2);
  line(width/2+150, height/2, width/2+200, height/2);
  line(width/2+175, height/2 - 25, width/2+175, height/2 + 25);

  // "Next" Button
  fill(#00D321);
  stroke(#008B16);
  strokeWeight(10);
  rect(width/2, height-200, 250, 100, 10);

  // "Next" text
  fill(#FCC200);
  textSize(100);
  text("Next", width/2, height-170);
}

void DisplayGame() {
  // Display background garden image
  noTint();
  image(backgroundImage, width/2, height/2);
  
  // Black filling in the board
  fill(0);
  noStroke();
  rect(width/2, height/2, width-300, height-200);
  
  // Case that holds the players
  fill(100);
  stroke(200);
  strokeWeight(7);
  rect(40, 400, 120, 640, 7);

  // Display the board
  for (Tile t : board) {
    t.display();
  }

  // Display the snakes and ladders on the board
  for (Passage p : passages) {
    p.display();
  }

  // Display the players
  for (Player p : players) {
    p.display();
  }

  // Display the outline of the dice (once a roll has been made)
  if (rollCount == -1 && currentRoll > 0) {
    // Red outline when roll is not allowed
    if (rollGoesOver) {
      stroke(255, 0, 0);
    } 
    // Yellow outline when roll is allowed
    else {
      stroke(255, 255, 0, 225);
    }
    strokeWeight(10);
    noFill();
    rect(width-75, 75, 93, 93, 15);
  } else {
    // Display an empty dice slot if there is no roll
    stroke(255, 150);
    strokeWeight(10);
    fill(255, 100);
    rect(width-75, 75, 80, 80, 15);
  }


  // Display the current player's turn in a box at the top of the screen
  // Box
  fill(players[currentTurn].playerColor);
  stroke(#502E0C);
  strokeWeight(10);
  rect(width/2, 40, 290, 50, 10);
  // Text
  fill(darker(players[currentTurn].playerColor));
  textSize(40);
  text("Player " + (currentTurn+1) + "'s Turn", width/2, 50);

  // Display the dice if it's being rolled
  if (currentRoll > 0) {
    DisplayDice(currentRoll);
  }
}

void DisplayEndScreen() {
  // Display background winner image
  noTint();
  image(winnerImage, width/2, height/2);
  
  // Write which player wins on top of the trophy
  fill(darker(players[currentTurn].playerColor));
  textSize(80);
  text("PLAYER " + (currentTurn+1) + " WINS!!!", width/2+5, 185);
  fill(players[currentTurn].playerColor);
  text("PLAYER " + (currentTurn+1) + " WINS!!!", width/2, 180);
  
  // Put the player's piece on the trophy
  tint(players[currentTurn].playerColor);
  image(playerImage, width/2, 310, 80, 80);
  
  // Write the reset and replay text at the bottom
  fill(255);
  textSize(30);
  text("Press 'n' to generate a new board", width/2, height-70);
  text("Press 'r' to rest the game", width/2, height-20);
}


void DisplayDice(int face) {
  // Display a sqaure
  fill(255);
  stroke(0);
  strokeWeight(10);
  rect(width-75, 75, 80, 80, 15);
  
  // Display the dots based on the dice's face
  strokeWeight(19);
  switch(face) {
  case 1:
    point(width-75, 75);
    break;
  case 2:
    point(width-95, 95);
    point(width-55, 55);
    break;
  case 3:
    point(width-75, 75);
    point(width-95, 95);
    point(width-55, 55);
    break;
  case 4:
    point(width-95, 95);
    point(width-55, 55);
    point(width-95, 55);
    point(width-55, 95);
    break;
  case 5:
    point(width-75, 75);
    point(width-95, 95);
    point(width-55, 55);
    point(width-95, 55);
    point(width-55, 95);
    break;
  case 6:
    point(width-95, 75);
    point(width-95, 95);
    point(width-95, 55);
    point(width-55, 75);
    point(width-55, 95);
    point(width-55, 55);
    break;
  }
}
