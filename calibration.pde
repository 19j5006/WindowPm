float minX = 1;
float minY = 1;
float maxX = 2;
float maxY = 2;

void initCameraMinPosition() {
  ArrayList<TuioObject> tuioObjectList = tuioClient.getTuioObjectList();
  if (tuioObjectList.size() != 1) {
    return;
  }
  TuioObject tobj = tuioObjectList.get(0);
  minX = tobj.getScreenX(width);
  minY = tobj.getScreenY(height);
}

void initCameraMaxPosition() {
  ArrayList<TuioObject> tuioObjectList = tuioClient.getTuioObjectList();
  if (tuioObjectList.size() != 1) {
    return;
  }
  TuioObject tobj = tuioObjectList.get(0);
  maxX = tobj.getScreenX(width);
  maxY = tobj.getScreenY(height);
}

void keyPressed() {
  if (key == 'n') {
    initCameraMinPosition();
  }
  if (key == 'x') {
    initCameraMaxPosition();
  }

  println("min: " + minX + ", " + minY);
  println("max: " + maxX + ", " + maxY);
}
