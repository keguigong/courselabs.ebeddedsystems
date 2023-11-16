String device_ID = "37";    //modify this value according to your locator device

void setup() {
  size(1063, 845);  //set the size of the window
  mapInit();        //initialize necessary map parameters
  mqttInit();       //initialize MQTT connection
}

void draw() {
  background(map);  //load the map as background
  
  drawGrid();       //draw grid
  drawBeacon();     //draw beacons
  drawLocator();    //draw the locator
}
