PImage map;

int beacon_icon_size = 20;
int locator_icon_size = 20;

float start_fraction_x = 0.0;
float end_fraction_x = 1.0;
float start_fraction_y = 0.0;
float end_fraction_y = 1.0;

int grid_num_x = 10;
int grid_num_y = 6;

int start_x, start_y, end_x, end_y, map_width, map_height;

int[][] beacon_info = {
  {3, 0, 100},
  {3, 3, 101},
  {6, 0, 102},
  //{1, 0, 103},
  //{1, 1, 104},
  //{1, 2, 105},
  //{2, 0, 106},
  //{2, 1, 107},
  //{2, 2, 108},
  {9, 5, 109},
  {0, 5, 110},
  {6, 3, 111}
};

int[] locator_info = {0, 0, 0};

class Position
{
  int x;
  int y;
  Position(int a, int b)
  {
    x = a;
    y = b;
  }
}

Position grid2Pixel(int x, int y, int offset_x, int offset_y) {
  Position pixel = new Position(0, 0);
  int grid_w = (map_width / grid_num_x);
  int grid_h = (map_height / grid_num_y);
  float px = (x + 0.5) * grid_w + start_x;
  float py = (y + 0.5) * grid_h + start_y;
  pixel.x = (int)(px + offset_x);
  pixel.y = (int)(py + offset_y);
  return pixel;
}

int meter2Pixel(float meter) {
  return (int)(meter / 15.0 * map_width * 0.5 + meter / 10.0 * map_height * 0.5);
}

void drawGrid() {
  textSize(24);
  stroke(200, 200, 200);
  for (var i = 0; i <= grid_num_x; i++) {
    line(i * (map_width / grid_num_x) + start_x, start_y, i * (map_width / grid_num_x) + start_x, end_y);
  }
  for (var i = 0; i <= grid_num_y; i++) {
    line(start_x, i * (map_height / grid_num_y) + start_y, end_x, i * (map_height / grid_num_y) + start_y);
  }
  fill(0, 0, 255);
  for (var i = 0; i < grid_num_x; i++) {
    text(str(i), (i + 0.5) * (map_width / grid_num_x) + start_x, start_y+24);
  }
  for (var i = 0; i < grid_num_y; i++) {
    text(str(i), start_x, (i + 0.5) * (map_height / grid_num_y) + start_y);
  }
}

void drawBeacon() {
  for (int i = 0; i < beacon_info.length; i++) {
    Position pixel = new Position(0, 0);
    pixel = grid2Pixel(beacon_info[i][0], beacon_info[i][1], 0, 0);
    stroke(0, 0, 0);
    fill(0, 255, 0);
    circle(pixel.x, pixel.y, beacon_icon_size);
    stroke(0, 0, 0);
    fill(0, 0, 0);
    text(str(beacon_info[i][2]), pixel.x, pixel.y);
  }
  drawRange();
}

int findBeaconIndex(int id) {
  int index = -1;
  for (int i = 0; i < beacon_info.length; i++) {
    if (beacon_info[i][2] == id) {
      index = i;
      break;
    }
  }
  return index;
}

void drawRange() {
  if (received_beacon_raw != null)
  {
    if (received_beacon_raw.length > 0) {
      for (int i = 0; i < received_beacon_raw.length; i++) {
        int rssi = received_beacon_raw[i][1];
        float distance = rssiToDistance(rssi);
        int id = received_beacon_raw[i][0];
        int index = findBeaconIndex(id);
        if (index != -1)
        {
          Position pixel = new Position(0, 0);
          fill(0, 0, 0, 0);
          stroke(0, 0, 255);
          pixel = grid2Pixel(beacon_info[index][0], beacon_info[index][1], 0, 0);
          circle(pixel.x, pixel.y, meter2Pixel(distance));
        }
      }
    }
  }
}

void drawLocator() {
  fill(255, 0, 0);
  stroke(0, 0, 0);
  Position pixel = new Position(0, 0);
  pixel = grid2Pixel(locator_info[0], locator_info[1], 0, 0);
  rect(pixel.x-locator_icon_size/2, pixel.y-locator_icon_size/2, locator_icon_size, locator_icon_size);
  stroke(0, 0, 0);
  fill(255, 0, 0, 50);
  circle(pixel.x, pixel.y, locator_info[2]);
}

void mapInit() {
  map = loadImage("lab_floor.jpg");  //load map file
  start_x = (int)(start_fraction_x * width);
  start_y = (int)(start_fraction_y * height);
  end_x = (int)(end_fraction_x * width);
  end_y = (int)(end_fraction_y * height);
  map_width = end_x - start_x;
  map_height = end_y - start_y;
}

void updateLocator(int x, int y, float range) {
  locator_info[0] = x;
  locator_info[1] = y;
  locator_info[2] = meter2Pixel(range);
}

Position get_beacon_position(int id)
{
  Position pos = new Position(0, 0);
  for (int i = 0; i < beacon_info.length; i++)
  {
    if (beacon_info[i][2] == id)
    {
      pos.x = beacon_info[i][0];
      pos.y = beacon_info[i][1];
    }
  }
  return pos;
}
