import java.util.Collections;
 
File dir;
String[] imageFileList;
ArrayList<PImage> images = new ArrayList<PImage>();
float brushRadius = 100.0;
float opacity = 255.0;

boolean shouldClearScreen = false;


//----------------------------
void setup(){
  //size(800,600);
  fullScreen();
  frameRate(60);
  noStroke();
  //noCursor();
  
  dir = new File(dataPath(""));
  imageFileList = dir.list();
  
  background(255,255,255);
  
  for(String s: imageFileList){

    println(s);
    images.add(loadImage(s));
  }
}

//----------------------------
void draw(){
  if(shouldClearScreen){
   shouldClearScreen = false;
   background(255,255,255);
  }
  if(mousePressed){
    int numberImages = images.size();
    Collections.shuffle(images);
    imageMode(CENTER);
    for(int i = 0; i < numberImages; i++){
      int xPos = mouseX + (int)(random(brushRadius*2) - brushRadius);
      int yPos = mouseY + (int)(random(brushRadius*2) - brushRadius);
      int imgWidth = (int)(random(brushRadius)+brushRadius/10.0);
      int imgHeight = (int)(random(brushRadius)+brushRadius/10.0);
      tint(255,opacity);
      image(images.get(i),xPos,yPos,imgWidth,imgHeight);
    }
  }
}

//----------------------------
void mouseWheel(MouseEvent event){
  float e = event.getCount();
  if(e>0){
    brushRadius = (brushRadius*e*1.1);
  }else{
    brushRadius = (brushRadius*e*-0.9);
  }
  if(brushRadius<1){
    brushRadius = 1;
  }
}

//----------------------------
void keyPressed(){
 
  if(key == CODED){
    println(keyCode);
    //for UP, DOWN, LEFT, RIGHT, ALT, CONTROL, SHIFT
    if(keyCode == DOWN){
      opacity = opacity*0.9;
      if (opacity < 1.0){
        opacity = 1.0;
      }
    }else if (keyCode == UP){
      opacity = opacity*1.1;
      if (opacity > 255.0){
        opacity = 255.0;
      }
    }
    
  }else{
    //ASCII spec includes BACKSPACE, TAB, ENTER, RETURN, ESC, DELETE
    if(key == DELETE){
      saveFrame("scene-#####.png");
    }else if(key == ENTER || key == RETURN){
      shouldClearScreen = true;
    }
  }
}