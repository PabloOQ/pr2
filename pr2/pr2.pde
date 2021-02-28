Figure figure;
PShape shape;
int state = 0;
ArrayList<PVector> points;
int strips;
Palette palette;
int indexPalette;

void setup(){
  palette = new Palette(color(43,48,58),
                        color(230,57,70),
                        color(11,0,51),
                        color(73,109,219),   //121,29,61
                        color(177,78,237),   // 170 171 186
                        color(193,202,214)); //bad 143,126,79
  strips = 10;
  points = new ArrayList<PVector>();
  figure = null;
  size(1000,1000,P3D);
  
  frameRate(70);
  state = 1;
}

void draw(){
  logic();
  show();
}

void logic(){
  switch(state){
    case 0:    //Nothing
      break;
    case 1:    //Intro screen

      break;
    case 2:    //Figure input screen

      break;
    case 3:    //Figure screen

      break;
    default:
      print("ERROR IN LOGIC");
   }
}

void keyReleased(){
  switch(state){
    case 0:    //Nothing
      break;
    case 1:    //Intro screen
      keyIntroScreen();
      break;
    case 2:    //Figure input screen
      keyFigureInputScreen();
      break;
    case 3:   //Figure screen
      keyFigureScreen();
      break;
    default:
      print("ERROR IN KEYLISTENER");
   }
  keyAllScreens();
}

void mouseClicked(){
  switch(state){
    case 0:    //Nothing
      break;
    case 1:    //Intro screen
      break;
    case 2:    //Figure input screen
      clickFigureInputScreen();
      break;
    case 3:    //Figure screen
      break;
    default:
      print("ERROR IN CLICKLISTENER");
   }  
}

void mouseDragged(){
  switch(state){
    case 0:    //Nothing
      break;
    case 1:    //Intro screen
      break;
    case 2:    //Figure input screen
      break;
    case 3:    //Figure screen
      dragFigureScreen();
      break;
    default:
      print("ERROR IN DRAGLISTENER");
   }  
}

void mouseWheel(MouseEvent event){
  switch(state){
    case 0:  //Nothing
      break;
    case 1:  //Intro screen
      break;
    case 2:  //Figure input screen
      break;
    case 3:  //Figure screen
      wheelFigureScreen(event);
      break;
    default:
      print("ERROR IN KEYLISTENER");
   }  
}

void show(){
  switch(state){
    case 0:  //Nothing
      break;
    case 1:  //Intro screen
      showIntroScreen();
      break;
    case 2:  //Figure input screen
      showFigureInputScreen();
      break;
    case 3:  //Figure screen
      showFigureScreen();
      break;
    default:
      print("ERROR IN VIEW");
   }  
}

//KeyScreens
void keyIntroScreen(){
  if (key == ' '){
   state = 2;
  }
}

void keyFigureInputScreen(){
  switch(key){
    case ' ':
      if (3 <= points.size()){
        figure = new Figure(points, new PVector(width/2, height/2, 0) , strips);
        startShape();
        state = 3;
      }
      break;
    case 'U':
    case 'u':
      if (1 <= points.size()){
        points.remove(points.size()-1);
        break;
      }
    case 'r':
    case 'R':
      points = new ArrayList<PVector>();
      break;
  }
}

void keyFigureScreen(){
  if (key == CODED){
    boolean changeFigure = false;
    switch(keyCode){
      case UP:
        if (strips < 30){
          strips++;
          changeFigure = true;
        }
        break;
      case DOWN:
        if (3 < strips){
          strips--;
          changeFigure = true;
        }
        break;
      default:
        break;
    }
    if (changeFigure){
      figure = new Figure(points, new PVector(width/2, height/2, 0), strips);
      startShape();
      shape.rotateX(radians(-60));
    }
  }else{
    switch(key){
      case 'r':
      case 'R':
        points = new ArrayList<PVector>();
        state = 2;
        break;
      default:
        break;
    }
  }  
}

void keyAllScreens(){
  Palette[] colors= { new Palette(color(43,48,58),
                                  color(230,57,70),
                                  color(11,0,51),
                                  color(73,109,219),   //121,29,61
                                  color(177,78,237),   // 170 171 186
                                  color(193,202,214)),
                      new Palette(color(255,255,255),
                                  color(80,81,79),
                                  color(72,172,240),
                                  color(10,1,79),
                                  color(3,208,164),
                                  color(139,104,127))};
  if (key == CODED){
    boolean changePalette = false;
    switch(keyCode){
      case LEFT:
        indexPalette--;
        changePalette = true;
        break;
      case RIGHT:
        indexPalette++;
        changePalette = true;
        break;
    }
    if (changePalette){
      if (indexPalette < 0){
        indexPalette = colors.length - 1;
      }else if (colors.length <= indexPalette){
        indexPalette = 0;
      }
      palette = colors[indexPalette];
      if (state == 3){
        startShape();
      }
    }
  }
}

//Click screens
void clickFigureInputScreen(){
  if (mouseButton == LEFT){
    float x = mouseX;
    if (mouseX < width/2){
      x = width/2;
    }
    points.add(new PVector(x, mouseY));
  }
}

//Drag screens
void dragFigureScreen(){
  float v = 0.5;
  float addXRot = (mouseX - pmouseX)*v;
  float addYRot = (mouseY - pmouseY)*v*(-1);
  shape.rotateY(radians(addXRot));
  shape.rotateX(radians(addYRot));
}

//Wheel screens
void wheelFigureScreen(MouseEvent wheel){
  float scale = 1;
  if (wheel.getCount() < 0){
    scale = 1.1;
  }else if (0 < wheel.getCount()){
    scale = 0.9;
  }
  shape.scale(scale, scale, scale);
}

void printPoints(){
  stroke(palette.getExtraAlt());
  fill(255);
  if (1 <= points.size()){
    PVector previousPoint = points.get(0);
    for (PVector nextPoint : points){
      line(previousPoint.x, previousPoint.y, nextPoint.x, nextPoint.y);
      circle(previousPoint.x, previousPoint.y, 5);

      previousPoint = nextPoint;
    }
    circle(previousPoint.x, previousPoint.y, 5);
  }
}

void showIntroScreen(){
  background(palette.getBackground());
  String[] text = { "Solid of revolution - Lab 2",
                    "",
                    "Press space to continue",
                    "",
                    "",
                    "Press LEFT or RIGHT to change the palette"};
  printText(text);
}

void showFigureInputScreen(){
  background(palette.getBackground());
  stroke(palette.getExtra());
  line(width/2,0,width/2,height);
  printPoints();
  instructions2D();
}

void instructions2D(){
  String[] text = { "Press SPACE to transform the points to a solid of revolution",
                    "Press R to delete all points",
                    "Click to put a new point",
                    "Press U to undo",
                    "",
                    "Press LEFT or RIGHT to change the palette"};

  printText(text);  
}

void showFigureScreen(){
  background(palette.getBackground());
  shape.translate(width/2, height/2);
  shape(shape);
  shape.translate(-width/2, -height/2);
  instructions3D();
}

void instructions3D(){
  String[] text = { "Press UP or DOWN to change the number of meridians",
                    "Press R to create a new shape",
                    "Use the wheel to zoom",
                    "Drag to rotate",
                    "",
                    "Press LEFT or RIGHT to change the palette"};

  printText(text);
}

void printText(String[] text){
  camera();
  hint(DISABLE_DEPTH_TEST);
  noLights();
  textMode(MODEL);
  textSize(20);
  fill(palette.getTextAlt());
  for (int i = 0; i < text.length; i++){
    text(text[i], 10, 25*(i+1));
  }
  hint(ENABLE_DEPTH_TEST);
}

void startShape(){
  shape = createShape();
  shape.beginShape(TRIANGLE_STRIP);
  shape.fill(palette.getBackgroundAlt());
  shape.stroke(palette.getExtraAlt());
  shape.strokeWeight(2);
  ArrayList<PVector> previousMeridian = figure.meridians.get(0);  //Retrieve the first meridian
  ArrayList<PVector> currentMeridian;
  for (int i = 1; i < figure.meridians.size(); i++){
    currentMeridian = figure.meridians.get(i);  //Retrieve meridians [1-size]
    for (int j = 0; j < previousMeridian.size(); j++){
      shape.vertex(previousMeridian.get(j).x,previousMeridian.get(j).y,previousMeridian.get(j).z);
      shape.vertex(currentMeridian.get(j).x,currentMeridian.get(j).y,currentMeridian.get(j).z);
    }
    shape.vertex(previousMeridian.get(0).x,previousMeridian.get(0).y,previousMeridian.get(0).z);
    shape.vertex(currentMeridian.get(0).x,currentMeridian.get(0).y,currentMeridian.get(0).z);
    
    previousMeridian = currentMeridian;
  }
  shape.endShape();
}

 
