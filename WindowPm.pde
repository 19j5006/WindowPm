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
float object_size = 70;
float point_size = 100;
float table_size = 760;
float scale_factor = 1;
PFont font;

boolean verbose = false;
boolean callback = true;

float pb = 0.0;
float reacTRota;

////////////////////////
float x_1 = 125;
float y_1 = 240;
float x_2 = 125;
float y_2 = 395;
float x_3 = 125;
float y_3 = 540;
float x_4 = 125;
float y_4 = 685;
float x_5 = 635;
float y_5 = 330;
float x_6 = 830;
float y_6 = 680;
float x_tuto = 1015;
float y_tuto = 120;

float marker_range = 50;
/////////////////////////


void setup()
{
  noCursor();
  size(displayWidth, displayHeight);
  //size(1900,1000);
  noStroke();
  fill(0);



  frameRate(frame);
  images = new PImage[3];
  images[0] = loadImage("Tbilisi_map (2).jpeg");

  images[1] = loadImage("funa.png");
  images[2] = loadImage("rabbit_icon.png");

  movies = new Movie[7];
  movies[0] = new Movie(this, "grape1.mp4");
  movies[1] = new Movie(this, "Seoul - 21116.mp4");
  movies[2] = new Movie(this, "Seoul - 21116.mp4");
  movies[3] = new Movie(this, "city.mp4");
  movies[4] = new Movie(this, "restaurant.mp4");
  movies[5] = new Movie(this, "Seoul - 21116.mp4");
  movies[6] = new Movie(this, "Seoul - 21116.mp4");

  if (!callback) {
    //frameRate(60);
    loop();
  } else noLoop();

  font = createFont("Arial", 18);
  scale_factor = height/table_size;

  tuioClient  = new TuioProcessing(this);
}

////////////////////////
void draw()
{
  image(images[0], 0, 0, width, height);
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
    if (0 < b &&  b < 180 ) {
      image(images[1], obj_size/2, -obj_size/2, obj_size, obj_size);
    } else if ( 180< b && b < 360) {
      image(images[2], obj_size/2, -obj_size/2, obj_size, obj_size);
    } 
    popMatrix();
    fill(255);
  }

  douga();
  syoki();
}

///////////////////////
// called at the end of each TUIO frame
void refresh(TuioTime frameTime) {
  if (verbose) println("frame #"+frameTime.getFrameID()+" ("+frameTime.getTotalMilliseconds()+")");
  if (callback) redraw();
}


///////////////////////
void douga() {

  float distance_1=dist(markarX, markarY, x_1, y_1);
  float distance_2=dist(markarX, markarY, x_2, y_2);
  float distance_3=dist(markarX, markarY, x_3, y_3);
  float distance_4=dist(markarX, markarY, x_4, y_4);
  float distance_5=dist(markarX, markarY, x_5, y_5);
  float distance_6=dist(markarX, markarY, x_6, y_6);
  float distance_tuto=dist(markarX, markarY, x_tuto, y_tuto);

  if (distance_1<marker_range) {
    if (movieIndex != 0) {
      movieIndex = 0;
     
      movies[movieIndex].loop();
    }
  } else if (distance_2<marker_range) {
    if (movieIndex != 1) {
      movieIndex = 1;
      movies[movieIndex].loop();
    }
  } else if (distance_3<marker_range) {
    if (movieIndex != 2) {
      movieIndex = 2;
      movies[movieIndex].loop();
    }
  } else if (distance_4<marker_range) {
    if (movieIndex != 3) {
      movieIndex = 3;
      movies[movieIndex].loop();
    }
  } else if (distance_5<marker_range) {
    if (movieIndex != 4) {
      movieIndex = 4;
      movies[movieIndex].loop();
    }
  } else if (distance_6<marker_range) {
    if (movieIndex != 5) {
      movieIndex = 5;
      movies[movieIndex].loop();
    }
  } else if (distance_tuto<marker_range) {
    if (movieIndex != 6) {
      movieIndex = 6;
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

//////////////////////
void syoki() {
  if (movieIndex == -1) {
    fill(0, 0, 0, 100);
    //rectMode(CENTER);
    //rect(x_1, y_1-marker_range, point_size, point_size);
    //rect(x_2, y_2-marker_range, point_size, point_size);
    //rect(x_3, y_3-marker_range, point_size, point_size);
    //rect(x_4, y_4-marker_range, point_size, point_size);
    //rect(x_5, y_5-marker_range, point_size, point_size);
    //rect(x_6, y_6-marker_range, point_size, point_size);
    //rect(x_tuto, y_tuto-marker_range, point_size, point_size);
    //image(images[1], x_1, y_1, point_size, point_size);
    //image(images[2], x_2, y_2, point_size, point_size);
    //image(images[3], x_3, y_3, point_size, point_size);
    //image(images[4], x_4, y_4-marker_range, point_size, point_size);
    //image(images[5], x_5, y_5-marker_range, point_size, point_size);
    //image(images[6], x_6, y_6-marker_range, point_size, point_size);
    //image(images[7], x_tuto, y_tuto, point_size+15, point_size);
  }
}
/////////////////////
void movieEvent(Movie m) {
  m.read();
}
