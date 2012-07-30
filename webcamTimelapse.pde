/*
got this script from http://processing.org/discourse/yabb2/YaBB.pl?num=1221681465
 thanks to http://psysoul.hu for sharing code on the forums! 
 
 
 */

import processing.video.*;

Capture cam;
MovieMaker mm;

String[] timecode = new String[7];
String fullTime;
int i = 1;
int framerate = 30;
int interval = 60 * 1000; // Here "1" is our desired interval time in ms * 1000 = seconds.
// default interval is a photo every minute
float m = millis();

int STOPDAY = 32; //this sets the day of the month at which we stop, 32 means we'll never stop.
int STOPHOUR = 23;  //change this to be the time at which you want to stop the recording. You can edit the code to stop at whatever time you like.
int STOPMINUTE = 0;  //change this to set the minutes at which recording will stop

int STARTDAY = 0; //this sets the day of the month at which we start
int STARTHOUR = 8; //this sets the hour at which we start
int STARTMINUTE = 0;//this sets the minute at which we start
boolean startToggle = false; //set this to false if you want a remote start

void setup() {
  size(640, 480);
  String[] devices = Capture.list();
  println(devices);
  // If no device is specified, will just use the default.
  cam = new Capture(this, 640, 480, devices[devices.length-1]);
  //cam.settings();

  background(0, 0, 0);
  frameRate(30);
}
void keyPressed() {
  if (key == ' ') {
    println("Stopped recording");
    mm.finish();  // Finish the movie if space bar is pressed!
    exit();
  }
}

void draw() {
  if (cam.available() == true) {
    if( timeToStart() ) { //see if we should begin taking images
      cam.read();
      image(cam, 0, 0);
      // The following does the same, and is faster when just drawing the image
      // without any additional resizing, transformations, or tint.
      //set(160, 100, cam);

      if (i==interval*framerate/1000) {
        /* deprecated this example code that showed exactly when the frame was taken
         //if you think that's useful (for forensic or research applications),
         // you can log it to a file or post it (w/ other data) to pachube
         */
         float m = millis();
         println("took frame @"+m);
        mm.addFrame();
        i = 0;
      }
      //do anything else you like with the camera and/or the image just taken
      //then increment the counter
      i++;
    }
  }

  //check to see if we should stop recording.
  if(day()==STOPDAY) {
    if(hour()==STOPHOUR) {
      if(minute()==STOPMINUTE) {
        mm.finish();  // Finish the movie if it's time to finish the movie!
        println("Finished movie "+fullTime);
        startToggle = false; // reset toggle so filming starts again next day
        //exit(); // comment this out to run prepetually
      }
    }
  }
}

boolean timeToStart() {
  if(day()>=STARTDAY && hour()>=STARTHOUR && minute()>=STARTMINUTE) {
    if(!startToggle) {
      println("Started timelapse");
      startToggle = !startToggle;
        //set up date and time string
      timecode[0] = String.valueOf(year());
      timecode[1] = String.valueOf(month());
      timecode[2] = String.valueOf(day());
      timecode[3] = String.valueOf(hour());
      timecode[4] = String.valueOf(minute());
      timecode[5] = String.valueOf(second());
      timecode[6] = ".mov";
      fullTime = join(timecode, "-");
      //fullTime = "garden-lapse-"+timecode+".mov";
      println(fullTime);
      //now create file with format "YEAR-MONTH-DAY-HOUR-MINUTE-SECOND.mov
      mm = new MovieMaker(this, width, height, fullTime, 30, MovieMaker.JPEG, MovieMaker.BEST);
    }
  }
  return startToggle;
}

// void makeAnimation(String folderPath) {
// mm = new MovieMaker(this, width, height, fullTime, 30, 
//   MovieMaker.ANIMATION, MovieMaker.LOSSLESS);
//   //get number of image files in directory
//   //get array of all image file names
//   //cycle through array names (in date order?)
//   for(int i=0; i < images.length; i++) {
//     PImage currentFrame;
//    currentFrame = loadImage(sketchPath+"/"+images[i]); 
//     image(currentFrame,0,0);
//     mm.addFrame();
//   }
// println("done");
//   mm.finish();
// }
