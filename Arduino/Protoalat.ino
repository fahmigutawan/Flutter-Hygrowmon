#include <DHT.h>
#include <Wire.h>
#include <LiquidCrystal_I2C.h>
#include <PubSubClient.h>
#include <WiFi.h>

#define TAMPIL_SERIAL true

LiquidCrystal_I2C lcd(0x27, 20, 4);
DHT dht(26, DHT22);

// Update these with values suitable for your network.
const char* ssid = "Vigoku";
const char* password = "12345678";
const char* mqtt_server = "103.161.185.118";
// const char* mqtt_username = "agrisolute"; // Ganti dengan username MQTT Anda
// const char* mqtt_password = "garuda"; // Ganti dengan password MQTT Andac

const byte KARAKTER_DERAJAT = 0;
const int ph_Pin = 35;
float Po = 0;
float PH_step;
int nilai_analog_PH;
double TeganganPh;

float PH4 = 24;
float PH7 = 15;

WiFiClient espClient;
PubSubClient client(espClient);
unsigned long lastMsg = 0;

void setup_wifi() {

  delay(10);
  // We start by connecting to a WiFi network
  Serial.println();
  Serial.print("Connecting to ");
  Serial.println(ssid);

  WiFi.mode(WIFI_STA);
  WiFi.begin(ssid, password);

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }

  randomSeed(micros());

  Serial.println("");
  Serial.println("WiFi connected");
  Serial.println("IP address: ");
  Serial.println(WiFi.localIP());
}

void callback(char* topic, byte* payload, unsigned int length) {
  Serial.print("Message arrived [");
  Serial.print(topic);
  Serial.print("] ");
  for (int i = 0; i < length; i++) {
    Serial.print((char)payload[i]);
  }
  Serial.println();
}

void reconnect() {
  // Loop until we're reconnected
  while (!client.connected()) {
    Serial.print("Attempting MQTT connection...");
    // Create a random client ID
    String clientId = "ESP32Client-";
    clientId += String(random(0xffff), HEX);
    
    // Attempt to connect
    if (client.connect(clientId.c_str())) {
      Serial.println("connected");
      client.subscribe("/esp32/mqtt/in");
    } else {
      Serial.print("failed, rc=");
      Serial.print(client.state());
      Serial.println(" try again in 1 seconds");
      // Wait 5 seconds before retrying
      delay(1000);
    }
  }
  // while (!client.connected()) {
  //   Serial.println("Terhubung ke MQTT...");
  //   if (client.connect("ArduinoClient", mqtt_username, mqtt_password)) {
  //     Serial.println("Terhubung ke MQTT Broker");
  //   } else {
  //     Serial.print("Gagal terhubung ke MQTT Broker, rc=");
  //     Serial.print(client.state());
  //     Serial.println(" coba lagi dalam 5 detik");
  //     delay(5000);
  //   }
  // }
}

byte derajat[] = {
  B00111,
  B00101,
  B00111,
  B00000,
  B00000,
  B00000,
  B00000,
  B00000
};

void setup() {
// #if TAMPIL_SERIAL
//   Serial.begin(9600);
//   Serial.println(F("DHT 11 !"));
// #endif
  Serial.begin(115200);
  pinMode(ph_Pin,INPUT);
  setup_wifi();
  lcd.init();
  lcd.createChar(KARAKTER_DERAJAT, derajat);
  lcd.backlight();
  // lcd.setCursor(5, 0);
  // lcd.print("DHT 11");
  lcd.setCursor(0, 0);
  lcd.print("SUHU     :");
  lcd.setCursor(0, 1);
  lcd.print("HUMIDITY :");
  lcd.setCursor(0, 2);
  lcd.print("PH       :");
  lcd.setCursor(0, 3);
  lcd.print("TANAH    :");

  dht.begin();
  client.setServer(mqtt_server, 1883);
  client.setCallback(callback);
}

void loop() {
  delay(2000); 
  if (!client.connected()) {
    reconnect();
  }
  client.loop();

  float suhu = dht.readTemperature();
  float humidity = dht.readHumidity();
  int soilMoistureValue = analogRead(34);
  int soilMoisturePercentage = map(soilMoistureValue, 0, 4095, 100, 0);
  nilai_analog_PH = analogRead(ph_Pin);
  TeganganPh = 3.3 /1024.0 * nilai_analog_PH;
  PH_step = (PH4 - PH7) / 3;
  Po = 7.00 + ((PH7 - TeganganPh) / PH_step);

  long now = millis();
  if (now - lastMsg > 5000) {
    lastMsg = now;
    // char tempString[8];
    // dtostrf(suhu, 1, 2, tempString);
    // client.publish("/esp32-mqtt/temp", tempString);
    // char humString[8];
    // dtostrf(humidity, 1, 2, humString);
    // client.publish("/esp32-mqtt/hum", humString);
    // char PHString[8];
    // dtostrf(Po, 1, 2, PHString);
    // client.publish("/esp32-mqtt/PH", PHString);
    // char tanahString[8];
    // dtostrf(soilMoisturePercentage, 1, 2, tanahString);
    // client.publish("/esp32-mqtt/tanah", tanahString);
    String combinedata = String(suhu) + ":" + String(humidity) + ":" + String(soilMoisturePercentage) + ":" + String(Po);
    client.publish("all-sensor", combinedata.c_str());
  }
  // lcd.print("test");
  // delay(2000);
  // lcd.clear();
  // delay(2000);

//   if (isnan(humidity) || isnan(suhu)) {
// #if TAMPIL_SERIAL
//   Serial.println(F("Failed to read from DHT sensor!"));
// #endif
//     return;
//   }

  lcd.setCursor(10, 0);
  lcd.print(suhu);
  lcd.setCursor(10, 1);
  lcd.print(humidity);
  lcd.setCursor(10, 2);
  lcd.print(Po, 2); 
  lcd.setCursor(10, 3);
  lcd.print(soilMoisturePercentage); 

  if(suhu < 10){
    lcd.setCursor(14, 0);
  }else{
    lcd.setCursor(15, 0);
  }
  lcd.write(KARAKTER_DERAJAT);

  if(suhu < 10){
    lcd.setCursor(15, 0);
  }else{
    lcd.setCursor(16, 0);
  }
  lcd.print("C");

  if(humidity < 10){
    lcd.setCursor(14, 1);
  }else{
    lcd.setCursor(15, 1);
  }
  lcd.print("%");

  if(soilMoisturePercentage < 10){
    lcd.setCursor(14, 3);
  }else{
    lcd.setCursor(15, 3);
  }
  lcd.print("%");

// #if TAMPIL_SERIAL
//   Serial.println("\n================");
//   Serial.print(F("Humidity: ")); Serial.print(hum); Serial.println("%");
//   Serial.print(F("Temperature: ")); Serial.print(temp); Serial.println(F("°C "));
// #endif

}
