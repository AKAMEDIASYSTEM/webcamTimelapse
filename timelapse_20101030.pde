/*
got this script from http://processing.org/discourse/yabb2/YaBB.pl?num=1221681465
 thanks to http://psysoul.hu for sharing code on the forums! 
 
 
 */

import processing.video.*;

Capture cam;
MovieMaker mm;

String[] timecode = new String[7];
int i = 1;
int framerate = 30;
int diff = 1 * 1000; // Here "1" is our desired interval time in ms.
//1000msec = 1sec.
//I separated the "*1000" just to make it easier for myself...
float m = millis();
int STOPHOUR = 18;  //change this to be the time at which you want to stop the recording. You can edit the code to stop at whatever time you like.
int STOPMINUTE = 0;  //change this to set the minutes at which recording will stop


void setup() {
  size(640, 480);

  // If no device is specified, will just use the default.
  cam = new Capture(this, 640, 480);

  //set up date and time string
  timecode[0] = String.valueOf(year());
  timecode[1] = String.valueOf(month());
  timecode[2] = String.valueOf(day());
  timecode[3] = String.valueOf(hour());
  timecode[4] = String.valueOf(minute());
  timecode[5] = String.valueOf(second());
  timecode[6] = ".mov";
  String fullTime = join(timecode, "-");
  //fullTime = "garden-lapse-"+timecode+".mov";
  println(fullTime);
  //now create file with format "garden-lapse-YEAR-MONTH-DAY-HOUR-MINUTE-SECOND.mov
  mm = new MovieMaker(this, width, height, fullTime, 30, MovieMaker.JPEG, MovieMaker.BEST);
  background(0, 0, 0);
  frameRate(30);
}
void keyPressed() {
  if (key == ' ') {
    mm.finish();  // Finish the movie if space bar is pressed!
    exit();
  }
}

void draw() {
  if (cam.available() == true) {
    cam.read();
    image(cam, 0, 0);
    // The following does the same, and is faster when just drawing the image
    // without any additional resizing, transformations, or tint.
    //set(160, 100, cam);

    if (i==diff*framerate/1000) {
      /* deprecated this example code that showed exactly when the frame was taken
       //if you think that's useful (for forensic or research applications),
       // you can log it to a file or post it (w/ other data) to pachube
       */
      // float m = millis();
      // println(m);
      mm.addFrame();
      i = 0;
    }
    //do anything else you like with the camera and/or the image just taken
    //then increment the counter
    i++;
  }

  //check to see if we should stop recording.
  if(hour()==STOPHOUR) {
    if(minute()==STOPMINUTE) {
      mm.finish();  // Finish the movie if it's time to finish the movie!
      exit();
    }
  }
}

