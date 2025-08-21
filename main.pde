import controlP5.*;
import processing.serial.*;
import java.util.*;
import java.util.concurrent.LinkedBlockingQueue;
import java.nio.*;
import java.text.DecimalFormat;

ControlP5 cp5;
PFont font;

Serial myPort; // For serial communication
dataPacket tx_packet;
String selectedPort;
dataPacket rx_packet;
boolean port_selected = false;

int last_read_time = 0;

int last_r_log_time = 0;
float r_log_rate = 0;
int last_f_log_time = 0;
float f_log_rate = 0;

int last_received_log_id = 0;
int log_packet_loss = 0;
int ack_packet_loss = 0;
byte last_cmd_sent = (byte) 0xff;
int last_cmd_sent_time = 0;
int last_chart_time = 0;
int last_status_time = 0;
int last_r_ping = 0, last_f_ping = 0, last_i_ping = 0;
float map_width, map_height, map_x1, map_y1;

byte targetID;

LinkedBlockingQueue<dataPacket> tx_queue = new LinkedBlockingQueue<dataPacket>();

DecimalFormat df = new DecimalFormat("0.00");

final byte My_ID = 0;
byte[] rx_payload;
ParseState currentParseState = ParseState.VERSION;
int rx_payload_index = 0;
byte[] empty_payload = {};

// status toggle
int status_toggle_state = 0;
int last_status_request = 0;
int last_status_id = 1;

float max_f = .01, max_l = .01, min_l = -.01;
int max_size = 100000;
int[] prog_inputs = new int[4];
int selected_index = -1;

Tab fillTab;
Tab launchTab;

// manual stuff
Toggle valve_toggle;
int valve_toggle_state = 0;
int last_open_valve = -1;

Textfield valve_ms;

List<Toggle> valve_toggles;
HashMap<Toggle, Byte> valve_toggle_map = new HashMap<Toggle, Byte>();

List<Textlabel> diagram_labels;
int valve_selected = -1;

void setup() {
  frameRate(60);
  fullScreen(P3D);
  background(bgColor);

  logDir = sketchPath() + "/logs/";
  String logFolder = "logs";
  String currentDirectory = sketchPath();
  String directoryPath = currentDirectory + File.separator + logFolder;
  File directory = new File(directoryPath);
  boolean directoryCreated = directory.mkdir();

  history_deque = new ArrayDeque<>(history_capacity);

  if (directoryCreated) {
    println("Directory created successfully at: " + directoryPath);
  } else {
    println("Failed to create directory. It may already exist at: " + directoryPath);
  }
  logDir = directoryPath + File.separator;
  file = new File(logDir+"log_"+day()+"_"+month()+"_"+year()+"_"+hour()+minute()+second()+".bin");
  PFont.list();
  font = createFont("arial", width*.013);
  cp5 = new ControlP5(this);

  init_data_objects(); // in data models tab
  setupColors(); // in global configs tab
  setupControllers(); // in setup controllers tab
  setupCharts(); // in chart functions tab
  init_log(); // log initialization
  setupDiagrams(); // in diagrams tab
  maps(); // in maps tab
  updateControllersPos("default");
}

void draw() {
  updateDiagrams(); // diagrams tab
  updateControllersData(); // update controllers tab

  if (millis() - last_chart_time > chart_interval) {
    updateCharts();
    last_chart_time = millis();
  }
  auto_status(); // comms tab
  if (last_cmd_sent != (byte)0xff) {
    if (millis() - last_cmd_sent_time > packet_loss_timeout) {
      ack_packet_loss++;
      last_cmd_sent = (byte)0xff;
      updateLogStats();
      ack_display.setText("Last Ack Received:\nFAIL");
    }
  }

  if (obc.sd_logging == true) {
    fill(0, 255, 0);
  } else {
    fill(255, 0, 0);
  }
  circle(width*.79, height*.724, height*.018);
}

// This method ensures the serial port is closed properly when the program is exited
void stop() {
  try {
    logStream.close();
  }
  catch (IOException e) {
    println(e);
  }
  if (myPort != null) {
    myPort.stop();
  }
  super.stop();
}
