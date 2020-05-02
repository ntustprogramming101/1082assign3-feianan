final int GAME_START = 0, GAME_RUN = 1, GAME_OVER = 2;
final int GRID = 80;
final int LIFE_W = 50, LIFE_H = 51;
final int GROUNDHOG_W = 80;
final int GROUNDHOG_H = 80;
final int GROUNDHOG_X = GRID*4;
final int GROUNDHOG_Y = GRID;
final int PLAYERHEALTH_T = 2;

int gameState = 0;
float groundhogX1, groundhogY1, groundhogX0, groundhogY0;
int move1 = 0; //last move
int move2 = 0; //every keypressed
int moveframe = 0;

final int GRASS_HEIGHT = 15;
final int START_BUTTON_W = 144;
final int START_BUTTON_H = 60;
final int START_BUTTON_X = 248;
final int START_BUTTON_Y = 360;

PImage title, gameover, startNormal, startHovered, restartNormal, restartHovered;
PImage bg, soil0, soil1, soil2, soil3, soil4, soil5, life;
PImage stone1, stone2;
PImage groundhogIdle, groundhogDown, groundhogRight, groundhogLeft;

//boolean
boolean right = false ;
boolean left = false ;
boolean down = false;

// For debug function; DO NOT edit or remove this!
int playerHealth = 0;
float cameraOffsetY = 0;
boolean debugMode = false;

void setup() {
  size(640, 480, P2D);
  // Enter your setup code here (please put loadImage() here or your game will lag like crazy)
  bg = loadImage("img/bg.jpg");
  title = loadImage("img/title.jpg");
  gameover = loadImage("img/gameover.jpg");
  startNormal = loadImage("img/startNormal.png");
  startHovered = loadImage("img/startHovered.png");
  restartNormal = loadImage("img/restartNormal.png");
  restartHovered = loadImage("img/restartHovered.png");
  soil0 = loadImage("img/soil0.png");
  soil1 = loadImage("img/soil1.png");
  soil2 = loadImage("img/soil2.png");
  soil3 = loadImage("img/soil3.png");
  soil4 = loadImage("img/soil4.png");
  soil5 = loadImage("img/soil5.png");
  life = loadImage("img/life.png");
  stone1 = loadImage("img/stone1.png");
  stone2 = loadImage("img/stone2.png");
  groundhogIdle = loadImage("img/groundhogIdle.png");
  groundhogDown = loadImage("img/groundhogDown.png");
  groundhogRight = loadImage("img/groundhogRight.png");
  groundhogLeft = loadImage("img/groundhogLeft.png");
  
  groundhogX1 = GROUNDHOG_X;
  groundhogY1 = GROUNDHOG_Y;
  playerHealth = PLAYERHEALTH_T;
  frameRate(60);
}

void draw() {
  /* ------ Debug Function ------ 
   
   Please DO NOT edit the code here.
   It's for reviewing other requirements when you fail to complete the camera moving requirement.
   
   */
  if (debugMode) {
    pushMatrix();
    translate(0, cameraOffsetY);
  }
  /* ------ End of Debug Function ------ */


  switch (gameState) {

  case GAME_START: // Start Screen
    image(title, 0, 0);

    if (START_BUTTON_X + START_BUTTON_W > mouseX
      && START_BUTTON_X < mouseX
      && START_BUTTON_Y + START_BUTTON_H > mouseY
      && START_BUTTON_Y < mouseY) {

      image(startHovered, START_BUTTON_X, START_BUTTON_Y);
      if (mousePressed) {
        gameState = GAME_RUN;
        mousePressed = false;
      }
    } else {

      image(startNormal, START_BUTTON_X, START_BUTTON_Y);
    }
    break;

  case GAME_RUN: // In-Game

    // Background
    image(bg, 0, 0);

    // Sun
    stroke(255, 255, 0);
    strokeWeight(5);
    fill(253, 184, 19);
    ellipse(590, 50, 120, 120);
    
    //**********************move canvas*************************
    pushMatrix();
    if(groundhogY1 < GRID*21){
      translate(0,-(groundhogY1-GRID));
    }else{
      translate(0,-(GRID*20));
    }
    
      // Grass
      fill(124, 204, 25);
      noStroke();
      rect(0, 160 - GRASS_HEIGHT, width, GRASS_HEIGHT);
  
      // Soil - REPLACE THIS PART WITH YOUR LOOP CODE!
      for (int i = 0; i < 24; i++) {
        for (int j = 0; j < 8; j++) {
          if(i < 4){
            image(soil0, GRID*j, GRID*(2+i), GRID, GRID);
          }else if( i > 3 && i < 8){
            image(soil1, GRID*j, GRID*(2+i), GRID, GRID);
          }else if( i > 7 && i < 12){
            image(soil2, GRID*j, GRID*(2+i), GRID, GRID);
          }else if( i > 11 && i < 16){
            image(soil3, GRID*j, GRID*(2+i), GRID, GRID);
          }else if( i > 15 && i < 20){
            image(soil4, GRID*j, GRID*(2+i), GRID, GRID);
          }else if( i > 19 && i < 24){
            image(soil5, GRID*j, GRID*(2+i), GRID, GRID);
      }}}
      
      //stone1
      for(int i= 0; i < 8; i ++){
        image(stone1, GRID*i, GRID*(2+i), GRID, GRID);
      }
      
      //stone2
      for(int i= 8; i < 16; i ++){
        for (int j = 0; j < 8; j++) {
          if(i == 8 || i == 11 || i == 12 || i == 15){
            if (j == 1 || j == 2 || j == 5 || j == 6){
              image(stone1, GRID*j, GRID*(2+i), GRID, GRID);
            }
          }else{
            if (j == 0 || j == 3 || j == 4 || j == 7){
              image(stone1, GRID*j, GRID*(2+i), GRID, GRID);
            }
          }}}
          
      //stone3
      for(int i= 16; i < 24; i ++){
        for (int j = 0; j < 8; j++) {
          for (int k = 0; k < 8; k++) {
            
            if (i%3 == 1){
              if (j == 1 || j == 2 || j == 4 || j == 5 || j == 7){
                image(stone1, GRID*j, GRID*(2+i), GRID, GRID);
              }
              if (k == 2 || k == 5){
                image(stone2, GRID*k, GRID*(2+i), GRID, GRID);
              }
              
            }else if (i%3 == 2){
              if (j == 0 || j == 1 || j == 3 || j == 4 || j == 6 || j == 7){
                image(stone1, GRID*j, GRID*(2+i), GRID, GRID);
              }
              if (k == 1 || k == 4 || k == 7){
                image(stone2, GRID*k, GRID*(2+i), GRID, GRID);
              }
  
            }else{
              if (j == 0 || j == 2 || j == 3 || j == 5 || j == 6){
                image(stone1, GRID*j, GRID*(2+i), GRID, GRID);
              }
              if (k == 0 || k == 3 || k == 6){
                image(stone2, GRID*k, GRID*(2+i), GRID, GRID);
              }
      }}}}
      popMatrix();
      
    

    // Player
    move2 ++;
    
    if (down == false && left == false && right == false){
      if(groundhogY1 < GRID*21){
        image(groundhogIdle, groundhogX1, GROUNDHOG_Y, GROUNDHOG_W, GROUNDHOG_H);
        groundhogX0 = groundhogX1;
        groundhogY0 = groundhogY1;
      }
      else{
        image(groundhogIdle, groundhogX1, groundhogY1 - GRID*20, GROUNDHOG_W, GROUNDHOG_H);
        groundhogX0 = groundhogX1;
        groundhogY0 = groundhogY1;
    }}
    
    if (down) {
      if(groundhogY1 < GRID*21){
        moveframe ++;
        if(moveframe < 15){
          groundhogY1 += GRID / 15.0;
          image(groundhogDown, groundhogX1, GROUNDHOG_Y, GROUNDHOG_W, GROUNDHOG_H);
        }else{
          groundhogY1 = groundhogY0;
          groundhogY1 += GRID;
          down = false;
          moveframe = 0;
      }}
      else{
        moveframe ++;
        if(moveframe < 15){
          groundhogY1 += GRID / 15.0;
          image(groundhogDown, groundhogX1, groundhogY1 - GRID*20, GROUNDHOG_W, GROUNDHOG_H);
        }else{
          groundhogY1 = groundhogY0;
          groundhogY1 += GRID;
          down = false;
          moveframe = 0;
      }}}
      
      
    if (right) {
      if(groundhogY1 < GRID*21){
        moveframe ++;
        if(moveframe < 15){
          groundhogX1 += GRID / 15.0;
          image(groundhogRight, groundhogX1, GROUNDHOG_Y, GROUNDHOG_W, GROUNDHOG_H);
        }else{
          groundhogX1 = groundhogX0;
          groundhogX1 += GRID;
          right = false;
          moveframe = 0;
      }}
      else{
        moveframe ++;
        if(moveframe < 15){
          groundhogX1 += GRID / 15.0;
          image(groundhogRight, groundhogX1, groundhogY1 - GRID*20, GROUNDHOG_W, GROUNDHOG_H);
        }else{
          groundhogX1 = groundhogX0;
          groundhogX1 += GRID;
          right = false;
          moveframe = 0;
    }}}
        
    if (left) {
      if(groundhogY1 < GRID*21){
        moveframe ++;
        if(moveframe < 15){
          groundhogX1 -= GRID / 15.0;
          image(groundhogLeft, groundhogX1, GROUNDHOG_Y, GROUNDHOG_W, GROUNDHOG_H);
        }else{
          groundhogX1 = groundhogX0;
          groundhogX1 -= GRID;
          left = false;
          moveframe = 0;
      }}
      else{
        moveframe ++;
        if(moveframe < 15){
          groundhogX1 -= GRID / 15.0;
          image(groundhogLeft, groundhogX1, groundhogY1 - GRID*20, GROUNDHOG_W, GROUNDHOG_H);
        }else{
          groundhogX1 = groundhogX0;
          groundhogX1 -= GRID;
          left = false;
          moveframe = 0;
      }}}
      


    // Health UI
    
    for (int i = 0; i < playerHealth; i++){
      image(life, 10 + (LIFE_W + 20)*i, 10, LIFE_W, LIFE_H);
    }
    
    //boundaries
    if (groundhogX1 >= width - GRID) {
      groundhogX1 = width - GRID;
    }
    if (groundhogX1 <= 0) {
      groundhogX1 = 0;
    }
    if (groundhogY1 >= GRID*25) {
      groundhogY1 = GRID*25;
    }
    if (groundhogY1 <= 0) {
      groundhogY1 = 0;
    }

    
    if (playerHealth <= 0) {
      gameState = GAME_OVER;
    }
    break;

  case GAME_OVER: // Gameover Screen
    image(gameover, 0, 0);

    if (START_BUTTON_X + START_BUTTON_W > mouseX
      && START_BUTTON_X < mouseX
      && START_BUTTON_Y + START_BUTTON_H > mouseY
      && START_BUTTON_Y < mouseY) {

      image(restartHovered, START_BUTTON_X, START_BUTTON_Y);
      if (mousePressed) {
        down = false;
        right = false;
        left = false;
        gameState = GAME_RUN;
        mousePressed = false;
        playerHealth = PLAYERHEALTH_T;
        groundhogX1 = GROUNDHOG_X;
        groundhogY1 = GROUNDHOG_Y;
      }
    } else {

      image(restartNormal, START_BUTTON_X, START_BUTTON_Y);
    }
    break;
  }

  // DO NOT REMOVE OR EDIT THE FOLLOWING 3 LINES
  if (debugMode) {
    popMatrix();
  }
}

void keyPressed() {
  
  // Add your moving input code here
  if (key == CODED) {
    switch (keyCode) {
      
      case DOWN:
        if(move2 - move1 > 15){
          down = true;
          move1 = move2;
        }
        break;
        
      case RIGHT:
        if(move2 - move1 > 15){
          right = true;
          move1 = move2;
        }
        break;
        
      case LEFT:
        if(move2 - move1 > 15){
          left = true;
          move1 = move2;
        }
        break;
   }}

      
  // DO NOT REMOVE OR EDIT THE FOLLOWING SWITCH/CASES
  switch(key) {
  case 'w':
    debugMode = true;
    cameraOffsetY += 25;
    break;

  case 's':
    debugMode = true;
    cameraOffsetY -= 25;
    break;

  case 'a':
    if (playerHealth > 0) playerHealth --;
    break;

  case 'd':
    if (playerHealth < 5) playerHealth ++;
    break;
  }
}
