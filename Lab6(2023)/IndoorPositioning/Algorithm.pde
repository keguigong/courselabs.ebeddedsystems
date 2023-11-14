class Beacon
{
  int id;      //beacon's unique ID
  int rssi;    //RSSI value from the beacon
  Beacon (int i, int r)
  {
    id = i;
    rssi = r;
  }
}

float rssiToDistance(int rssi)
{//Modify your code here
  int rssi_at_1m = -10;                                    //wrong value
  return rssi / rssi_at_1m * 0.5;                          //wrong model
  //Modify your code here
}

void calcPosition(Beacon[] received_beacon, int received_beacon_num)
{
  if (received_beacon_num > 0)    //check if there are beacon signals received
  {
    int max_rssi = -128;          //-128 dBm is the minimun value of RSSI
    int best_beacon_id = -1;
    Position locator_position = new Position(0, 0);
    float range = 0.0;

    //find the best beacon with best signal strength
    for (int i = 0; i < received_beacon.length; i++)
    {
      if (max_rssi < received_beacon[i].rssi)
      {
        max_rssi = received_beacon[i].rssi;
        best_beacon_id = received_beacon[i].id;
      }
    }

    //if a best signl signal beacon is found, update the locator's position
    if (best_beacon_id != -1)
    {
      locator_position = get_beacon_position(best_beacon_id);  //find the beacon's location based on its ID
      range = rssiToDistance(max_rssi);                        //calculate the range based on the rssi value using free-space path loss model
    }

    updateLocator(locator_position.x, locator_position.y, range);    //outputs the position of the locator on the map
  }
}
