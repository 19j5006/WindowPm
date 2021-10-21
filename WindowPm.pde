import TUIO.*;
import processing.video.*;
Movie myMovie;
Movie myMovie2;
PImage img,img2;
int frame = 60;
float x;
float y;
color c1 = color(255,255,255);
float distance_b=dist(mouseX,mouseY,x,y);  
float distance_r=dist(mouseX,mouseY,x,y);  
float distance_g=dist(mouseX,mouseY,550,150);  
float distance_y=dist(mouseX,mouseY,750,150);  
float distance_w=dist(mouseX,mouseY,750,550);  
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

int c=0;
float pb = 0.0;
float reacTRota;

void setup()
{
  noCursor();
  size(displayWidth,displayHeight);
  noStroke();
  fill(0);
  
  frameRate(frame);
  img = loadImage("georgia-map.jpeg");
  myMovie = new Movie(this, "Boardwalk - 63740 (2).mp4");
  myMovie2 = new Movie(this, "Vines - 31527 (1).mp4");
  if (!callback) {
    frameRate(60);
    loop();
  } else noLoop(); 
  
  font = createFont("Arial", 18);
  scale_factor = height/table_size;
  
  
  tuioClient  = new TuioProcessing(this);
}


void draw()
{
  image(img, 0, 0, 1900, 1100);
  textFont(font,18*scale_factor);
  float obj_size = object_size*scale_factor; 
  float cur_size = cursor_size*scale_factor; 
   
  ArrayList<TuioObject> tuioObjectList = tuioClient.getTuioObjectList();
  for (int i=0;i<tuioObjectList.size();i++) {
     TuioObject tobj = tuioObjectList.get(i);
     stroke(0);
     fill(0,0,0);
     pushMatrix();
     markarX= map(tobj.getScreenX(width),0,  width, width, 0);
     markarY=tobj.getScreenY(height);
     translate(markarX,tobj.getScreenY(height));
     println(tobj.getScreenX(width),tobj.getScreenY(height));
     rotate(tobj.getAngle());
     reacTRota = radians(tobj.getAngleDegrees());
     ellipse(obj_size/2,-obj_size/2,obj_size,obj_size);
     popMatrix();
     fill(255);
     //text(""+tobj.getSymbolID(), tobj.getScreenX(width), tobj.getScreenY(height));
   }
   douga();
   syoki();

}

// --------------------------------------------------------------
// these callback methods are called whenever a TUIO event occurs
// there are three callbacks for add/set/del events for each object/cursor/blob type
// the final refresh callback marks the end of each TUIO frame

// called when an object is added to the scene
void addTuioObject(TuioObject tobj) {
  if (verbose) println("add obj "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" "+tobj.getAngle());
}

// called when an object is moved
void updateTuioObject (TuioObject tobj) {
  if (verbose) println("set obj "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" "+tobj.getAngle()
          +" "+tobj.getMotionSpeed()+" "+tobj.getRotationSpeed()+" "+tobj.getMotionAccel()+" "+tobj.getRotationAccel());
}

// called when an object is removed from the scene
void removeTuioObject(TuioObject tobj) {
  if (verbose) println("del obj "+tobj.getSymbolID()+" ("+tobj.getSessionID()+")");
}

// --------------------------------------------------------------
// called when a cursor is added to the scene
void addTuioCursor(TuioCursor tcur) {
  if (verbose) println("add cur "+tcur.getCursorID()+" ("+tcur.getSessionID()+ ") " +tcur.getX()+" "+tcur.getY());
  //redraw();
}

// called when a cursor is moved
void updateTuioCursor (TuioCursor tcur) {
  if (verbose) println("set cur "+tcur.getCursorID()+" ("+tcur.getSessionID()+ ") " +tcur.getX()+" "+tcur.getY()
          +" "+tcur.getMotionSpeed()+" "+tcur.getMotionAccel());
  //redraw();
}

// called when a cursor is removed from the scene
void removeTuioCursor(TuioCursor tcur) {
  if (verbose) println("del cur "+tcur.getCursorID()+" ("+tcur.getSessionID()+")");
  //redraw()
}

// --------------------------------------------------------------
// called when a blob is added to the scene
void addTuioBlob(TuioBlob tblb) {
  if (verbose) println("add blb "+tblb.getBlobID()+" ("+tblb.getSessionID()+") "+tblb.getX()+" "+tblb.getY()+" "+tblb.getAngle()+" "+tblb.getWidth()+" "+tblb.getHeight()+" "+tblb.getArea());
  //redraw();
}

// called when a blob is moved
void updateTuioBlob (TuioBlob tblb) {
  if (verbose) println("set blb "+tblb.getBlobID()+" ("+tblb.getSessionID()+") "+tblb.getX()+" "+tblb.getY()+" "+tblb.getAngle()+" "+tblb.getWidth()+" "+tblb.getHeight()+" "+tblb.getArea()
          +" "+tblb.getMotionSpeed()+" "+tblb.getRotationSpeed()+" "+tblb.getMotionAccel()+" "+tblb.getRotationAccel());
  //redraw()
}

// called when a blob is removed from the scene
void removeTuioBlob(TuioBlob tblb) {
  if (verbose) println("del blb "+tblb.getBlobID()+" ("+tblb.getSessionID()+")");
  //redraw()
}

// --------------------------------------------------------------
// called at the end of each TUIO frame
void refresh(TuioTime frameTime) {
  if (verbose) println("frame #"+frameTime.getFrameID()+" ("+frameTime.getTotalMilliseconds()+")");
  if (callback) redraw();
}
void douga(){
  float distance_b=dist(markarX,markarY,300,300);  
  //float distance_r=dist(mouseX,mouseY,300,100);  
  //float distance_g=dist(markarX,markarY,550,150);  
  //float distance_y=dist(mouseX,mouseY,750,150);  
  float distance_w=dist(markarX,markarY,1000,650);  
  
  float a=atan2(mouseY-centerY,mouseX-centerX);
   float theta=degrees(a)/(18*PI);
   
  float move = 1.0;
  
  //float b=theta*(18*PI);
  float b = map(reacTRota, 0, 6.2832, 0, 360);
if( pb < 72 && 288 < b ){
    c-=1;
  }else if(b < 72 && 288 < pb ){
    c+=1;
  }
  println("b="+b, "c="+c);
  if(0 < b &&  b < 72 ){
    move=c*5+1;
  }else if(72 < b && b < 144){
    move=c*5+2;
  }else if(144 < b && b < 216){
    move=c*5+3;
  }else if(216 < b &&  b <288){
    move=c*5+4;
  }else if(288 < b && b < 360){
    move=c*5+5;
  }
  if(move==0){
    myMovie.stop();
  }else{
    myMovie.speed(move);
  }
  text(move,centerX+100,centerY+100);
  pb=b;

  
 
  if(distance_b<200){
    image(myMovie, 0,0);
    myMovie.play();
    myMovie.loop();
  }
  
  //if(distance_r<50){
    //image(img2, 0, 0, 900, 700);
  //}
  //if(distance_g<150){
  //  image(img, 0, 0, 900, 600);
  //}
  if(distance_w<50){
    image(myMovie2, 0,0);
    myMovie2.play();
    myMovie2.loop();
    
  }
}
void syoki(){
  
  
  fill(0,0,255);                      
  fill(0);                  
  rect(300,300,50,50);
  
  
  //fill(255,0,0);
  //fill(0);
  //rect(100,100,50,50);
  
  
  //fill(0,255,0);
  //fill(0);
  //rect(500,100,50,50);
  
  //fill(255,255,0);
  //fill(0);
  //rect(700,100,50,50);
  
  
  fill(255,255,255);
  fill(0);
  rect(1000,650,50,50);
}
void movieEvent(Movie m) {
  m.read();
}
