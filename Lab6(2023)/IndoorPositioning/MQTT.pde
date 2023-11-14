import mqtt.*;

MQTTClient client;
JSONArray MQTT_beacon;
int[][] received_beacon_raw;

void mqttInit() {
  client = new MQTTClient(this);
  client.connect("mqtt://broker.emqx.io", "processing");
}

void clientConnected() {
  println("client connected");

  client.subscribe("eesm5060_locator/"+device_ID);
}

void messageReceived(String topic, byte[] payload) {
  //println("new message: " + topic + " - " + new String(payload));
  JSONObject MQTT_raw = parseJSONObject(new String(payload));
  if (MQTT_raw != null)
  {
    if (MQTT_raw.getString("M").equals(device_ID))
    {
      JSONArray MQTT_beacon = MQTT_raw.getJSONArray("B");
      if (MQTT_beacon.size() > 0) {
        received_beacon_raw = new int[MQTT_beacon.size()][2];

        for (int i = 0; i < MQTT_beacon.size(); i++)
        {
          JSONObject beacon = MQTT_beacon.getJSONObject(i);
          received_beacon_raw[i][0] = beacon.getInt("m");
          received_beacon_raw[i][1] = beacon.getInt("R");
        }

        int received_beacon_num = received_beacon_raw.length;
        Beacon[] received_beacon = new Beacon[received_beacon_num];
        for (int i = 0; i < received_beacon_num; i++)
        {
          received_beacon[i] = new Beacon(received_beacon_raw[i][0], received_beacon_raw[i][1]);
        }
        calcPosition(received_beacon, received_beacon_num);
      }
    }
  }
}

void connectionLost() {
  println("connection lost");
}
