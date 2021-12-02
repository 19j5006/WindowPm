import TUIO.*;
import processing.video.*;

Movie[] movies;
PImage[] images;
int movieIndex = -1;
int frame = 60;
float x;
float y;
color c1 = color(255, 255, 255);
TuioProcessing tuioClient;

float markarX=0;
float markarY=0;

float r=300;
float centerX=300;
float centerY=300;
float radius=150;

float cursor_size = 15;
float object_size = 60;
float table_size = 760;
float scale_factor = 1;
PFont font;

boolean verbose = false;
boolean callback = true;

float pb = 0.0;
float reacTRota;


void setup()
{
  noCursor();
  size(displayWidth, displayHeight);
  noStroke();
  fill(0);

  frameRate(frame);
  images = new PImage[6];
  images[0] = loadImage("georgia-map.jpeg");
  images[1] = loadImage("red_wine.png");
  images[2] = loadImage("wine-red-white.png");
  images[3] = loadImage("carrycase_man.png");
  images[4] = loadImage("travel_woman.png");
  images[5] = loadImage("carrycase_obaasan.png");
  movies = new Movie[4];
  movies[0] = new Movie(this, "Boardwalk - 63740 (2).mp4");
  movies[1] = new Movie(this, "Vines - 31527 (1).mp4");
  movies[2] = new Movie(this, "istockphoto-1331432006-640_adpp_is_SparkVideo.mp4");
  movies[3] = new Movie(this, "Seoul - 21116.mp4");

  if (!callback) {
    //frameRate(60);
    loop();
  } else noLoop();

  font = createFont("Arial", 18);
  scale_factor = height/table_size;

  tuioClient  = new TuioProcessing(this);
}


void draw()
{
  image(images[0], 0, 0, 1900, 1100);
  textFont(font, 18*scale_factor);
  float obj_size = object_size*scale_factor;
  float cur_size = cursor_size*scale_factor;


  ArrayList<TuioObject> tuioObjectList = tuioClient.getTuioObjectList();
  for (int i=0; i<tuioObjectList.size(); i++) {
    TuioObject tobj = tuioObjectList.get(i);
    stroke(0);
    fill(0, 0, 0);
    pushMatrix();
    markarX= map(tobj.getScreenX(width), 0, width, width, 0);
    markarY=tobj.getScreenY(height);
    translate(markarX, tobj.getScreenY(height));
    //rotate(tobj.getAngle());
    reacTRota = radians(tobj.getAngleDegrees());
    float b = map(reacTRota, 0, 6.2832, 0, 360);
    if (0 < b &&  b < 120 ) {
      image(images[3], obj_size/2, -obj_size/2, obj_size, obj_size);
    } else if (120 < b && b < 240) {
      image(images[4], obj_size/2, -obj_size/2, obj_size, obj_size);
    } else if (240 < b && b < 360) {
      image(images[5], obj_size/2, -obj_size/2, obj_size, obj_size);
    }
    popMatrix();
    fill(255);
  }
  douga();
  syoki();
}

// called at the end of each TUIO frame
void refresh(TuioTime frameTime) {
  if (verbose) println("frame #"+frameTime.getFrameID()+" ("+frameTime.getTotalMilliseconds()+")");
  if (callback) redraw();
}
void douga() {
  float distance_b=dist(markarX, markarY, 300, 300);
  float distance_r=dist(markarX, markarY, 800, 300);
  float distance_g=dist(markarX, markarY, 600, 700);
  //float distance_y=dist(mouseX,mouseY,750,150);
  float distance_w=dist(markarX, markarY, 1000, 650);

  if (distance_b<100) {
    if (movieIndex != 0) {
      movieIndex = 0;
      movies[movieIndex].loop();
    }
  } else if (distance_w<100) {
    if (movieIndex != 1) {
      movieIndex = 1;
      movies[movieIndex].loop();
    }
  } else if (distance_r<100) {
    if (movieIndex != 2) {
      movieIndex = 2;
      movies[movieIndex].loop();
    }
  } else if (distance_g<100) {
    if (movieIndex != 3) {
      movieIndex = 3;
      movies[movieIndex].loop();
    }
  } else {
    if (movieIndex != -1) {
      movies[movieIndex].pause();
      movieIndex = -1;
    }
  }

    if (movieIndex != -1) {
      image(movies[movieIndex], 0, 0);
    }

  }

  void syoki() {
    if (movieIndex == -1) {
      fill(0);
      image(images[1], 270, 270, 100, 100);
      image(images[2], 1000, 650, 100, 100);
      rect(800, 300, 100, 100);
      rect(600, 700, 100, 100);
    }
  }
  void movieEvent(Movie m) {
    m.read();
  }
