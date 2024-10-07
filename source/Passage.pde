class Passage {
  int startTile;
  int endTile;
  PVector startLocation;
  PVector endLocation;

  Passage() {
  }

  void display() {
    println("ERROR! Displaying in Parent Class");
  }

  void FindStartTile() {
    println("ERROR! Finding start tile in Parent Class");
  }

  boolean movePlayer(Player p) {
    println("ERROR! Moving player in Parent Class");
    return false;
  }
}

class Ladder extends Passage {
  float startupX;
  PVector dir;
  float ladderLength;
  Ladder() {
  }

  void display() {
    drawLadder(#834001, 50/dimension);
    drawLadder(#E87000, 0);
  }

  void drawLadder(color strokeColor, int offset) {
    pushMatrix();
    translate(startLocation.x + offset, startLocation.y + offset);
    rotate(dir.heading());
    stroke(strokeColor);
    strokeWeight(70.0/dimension);
    int sizeVal = int(110.0/dimension);
    line(0, -sizeVal, startupX, -sizeVal);
    line(0, sizeVal, startupX, sizeVal);
    for (int x=sizeVal*2; x<startupX; x+=sizeVal*2) {
      line(x, -sizeVal, x, sizeVal);
    }
    if (startupX < ladderLength) {
      startupX += ladderLength / 55;
    } else {
      startupX = ladderLength;
    }
    popMatrix();
  }

  void FindStartTile() {
    boolean startExists = true;
    while (startExists) {
      startExists = false;
      startTile = floor(random(board.length-dimension));
      for (Passage other : passages) {
        if (other != this) {
          if (this.startTile == other.startTile || this.startTile == other.endTile) {
            startExists = true;
          }
        }
      }
    }
    boolean endExists = true;
    while (endExists) {
      endExists = false;
      endTile = floor(random(startTile+1, board.length));
      if (floor(endTile/dimension) == floor(startTile/dimension)) {
        endExists = true;
        continue;
      }
      for (Passage other : passages) {
        if (other != this) {
          if (this.endTile == other.startTile || this.endTile == other.endTile) {
            endExists = true;
          }
        }
      }
    }

    startLocation = board[startTile].location;
    endLocation = board[endTile].location;

    dir = PVector.sub(endLocation, startLocation);
    ladderLength = dir.mag();
  }

  boolean movePlayer(Player p) {
    if (PVector.dist(p.location, endLocation) < 5) {
      return false;
    }
    PVector movement = dir.copy().setMag(tileSize/16);
    p.location.add(movement);
    return true;
  }
}

class Snake extends Passage {
  PVector[] points;
  color c1;
  color c2;
  int startupI;
  int eatenIndex;
  PVector dir;
  int barLength = 90/dimension;
  float baseSize = 170.0/dimension;

  Snake() {
    c1 = color(random(100, 255), random(100, 255), random(100, 255));
    c2 = color(red(c1) - random(20, 50), green(c1) - random(20, 50), blue(c1) - random(20, 50));
  }

  void GeneratePoints() {
    int lengthInPixels = int(dir.mag());
    int halfCycles = int(lengthInPixels/tileSize);
    float lengthInRadians = halfCycles * PI;
    points = new PVector[int(dir.mag())];
    for (int i=0; i<points.length; i++) {
      float x = i;
      int amplitude = int(sin((x/lengthInPixels) * PI) * tileSize);
      float y = amplitude * sin((x/lengthInPixels) * lengthInRadians);
      points[i] = new PVector(x, y);
      points[i].rotate(dir.heading());
      points[i].add(startLocation);
    }
    startupI = points.length-1;
  }

  void display() {
    noStroke();
    for (int i=startupI; i<points.length; i++) {
      PVector p = points[i];
      if (int(i/barLength) % 2 == 0) {
        fill(c1);
      } else {
        fill(c2);
      }
      if (eatenIndex == i && eatenIndex != 0) {
        ellipse(p.x, p.y, tileSize/2, tileSize/2);
      } else {
        ellipse(p.x, p.y, baseSize, baseSize);
      }
    }
    if (startupI > 0) {
      startupI -= points.length/30;
      if (startupI < 0) {
        startupI = 0;
      }
    } else {
      pushMatrix();
      translate(startLocation.x, startLocation.y);
      rotate(dir.heading());
      fill(c1);
      ellipse(0, 0, baseSize*1.5, baseSize*1.5);
      ellipse(-baseSize*0.5, 0, baseSize, baseSize);
      fill(c2);
      ellipse(0, -baseSize*0.4, baseSize*0.5, baseSize*0.5);
      ellipse(0, baseSize*0.4, baseSize*0.5, baseSize*0.5);
      popMatrix();
    }
  }

  void FindStartTile() {
    boolean startExists = true;
    while (startExists) {
      startExists = false;
      startTile = floor(random(dimension, board.length-1));
      for (Passage other : passages) {
        if (other != this) {
          if (this.startTile == other.startTile || this.startTile == other.endTile) {
            startExists = true;
          }
        }
      }
    }
    boolean endExists = true;
    while (endExists) {
      endExists = false;
      endTile = floor(random(startTile-1));
      if (floor(endTile/dimension) == floor(startTile/dimension)) {
        endExists = true;
        continue;
      }
      for (Passage other : passages) {
        if (other != this) {
          if (this.endTile == other.startTile || this.endTile == other.endTile) {
            endExists = true;
          }
        }
      }
    }

    startLocation = board[startTile].location;
    endLocation = board[endTile].location;

    dir = PVector.sub(endLocation, startLocation);

    GeneratePoints();
  }

  boolean movePlayer(Player p) {
    if (eatenIndex > points.length-1) {
      eatenIndex = 0;
      p.canBeDisplayed = true;
      return false;
    }
    p.location = points[eatenIndex].copy();
    eatenIndex += 5;
    p.canBeDisplayed = false;
    return true;
  }
}
