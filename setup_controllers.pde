// controllers
Textfield[] param_fields = new Textfield[4];
Textlabel log_display_rocket, log_display_filling, log_display_ignition;
Textlabel ack_display;
Textlabel log_stats;
Textlabel history;
ArrayDeque<String> history_deque;
Chart fillingChart, launchChart;
Textlabel pressureLabel, temperatureLabel, weightLabel;
Textlabel altitudeLabel, velocityLabel, accelerationLabel;
Textlabel ematch_label;
Textlabel n2_label, n2o_label, quick_dc_label, uf_label, lf_label, chamber_label;
Toggle n2_fill_toggle, n2_purge_toggle, n2_quick_dc_toggle, n2o_fill_toggle, n2o_purge_toggle, n2o_quick_dc_toggle, pressurizing_toggle, vent_toggle, abort_toggle, main_toggle;
Toggle status_toggle;
Textlabel gps_label, bar_label, imu_label, kalman_label;

// GUI Positions and Sizes
float button_x1 = .8; // * displayWidth
float button_x2 = .89;
float button_height = .04; // * displayHeight
float button_height_big = .07;
float button_width = .13; // * displayWidth
float toggle_height = .04;
float toggle_width = .04;


void setupControllers() {
  manual_setup();
  filling_setup();
  launch_setup();

  cp5.addScrollableList("program")
    .setPosition(displayWidth*.02, displayHeight*.05)
    .setSize((int)(displayWidth*.15), (int)(displayHeight*.46))
    .setBarHeight((int)(displayHeight*.05))
    .setItemHeight((int)(displayHeight*.05))
    .addItems(programs)
    .setFont(font)
    .setColor(defaultColor)
    .moveTo("filling")
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);


  // Textfields for parameters and limits
  param_fields[0] = cp5.addTextfield("Target P")
    .setAutoClear(false)
    .setColor(defaultColor)
    .setPosition(displayWidth*.23, displayHeight*.05)
    .setSize((int)(displayWidth*.09), (int)(displayHeight*.05))
    .setFont(font)
    .setInputFilter(ControlP5.FLOAT)
    .moveTo("filling");

  param_fields[1] = cp5.addTextfield("Trigger P")
    .setAutoClear(false)
    .setColor(defaultColor)
    .setPosition(displayWidth*.33, displayHeight*.05)
    .setSize((int)(displayWidth*.09), (int)(displayHeight*.05))
    .setFont(font)
    .setInputFilter(ControlP5.FLOAT)
    .moveTo("filling");

  param_fields[2] = cp5.addTextfield("Target W")
    .setAutoClear(false)
    .setColor(defaultColor)
    .setPosition(displayWidth*.43, displayHeight*.05)
    .setSize((int)(displayWidth*.09), (int)(displayHeight*.05))
    .setFont(font)
    .setInputFilter(ControlP5.FLOAT)
    .moveTo("filling");
    
  param_fields[3] = cp5.addTextfield("Trigger T")
    .setAutoClear(false)
    .setColor(defaultColor)
    .setPosition(displayWidth*.53, displayHeight*.05)
    .setSize((int)(displayWidth*.09), (int)(displayHeight*.05))
    .setFont(font)
    .setInputFilter(ControlP5.FLOAT)
    .moveTo("filling");

  // Send button
  cp5.addButton("Execute")
    .setPosition(displayWidth*.63, displayHeight*.05)
    .setSize((int)(displayWidth*.1), (int)(displayHeight*.05))
    .moveTo("filling")
    .setColor(defaultColor)
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
    .setFont(font);

  cp5.addButton("Stop")
    .setPosition(displayWidth*button_x1, displayHeight*.13)
    .setSize((int)(displayWidth*button_width), (int)(displayHeight*button_height_big))
    .moveTo("global")
    .setColor(stopColor)
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
    .setFont(font);

  cp5.addButton("Resume")
    .setPosition(displayWidth*button_x1, displayHeight*.35)
    .setSize((int)(displayWidth*button_width), (int)(displayHeight*button_height))
    .moveTo("filling")
    .setColor(defaultColor)
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
    .setFont(font);

  cp5.addButton("Status")
    .setPosition(displayWidth*button_x1, displayHeight*.21)
    .setSize((int)(displayWidth*button_width), (int)(displayHeight*button_height_big))
    .moveTo("global")
    .setColor(defaultColor)
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
    .setFont(font);

  cp5.addButton("Abort")
    .setPosition(displayWidth*button_x1, displayHeight*.05)
    .setSize((int)(displayWidth*button_width), (int)(displayHeight*button_height_big))
    .setColor(abortColor)
    .moveTo("global")
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
    .setFont(font);

  cp5.addButton("Arm")
    .setPosition(displayWidth*button_x1, displayHeight*.3)
    .setSize((int)(displayWidth*button_width), (int)(displayHeight*button_height))
    .moveTo("launch")
    .setColor(defaultColor)
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
    .setFont(font);

  cp5.addButton("Ready")
    .setPosition(displayWidth*button_x1, displayHeight*.35)
    .setSize((int)(displayWidth*button_width), (int)(displayHeight*button_height))
    .moveTo("launch")
    .setColor(defaultColor)
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
    .setFont(font);

  fillingChart = cp5.addChart("Filling Chart")
    .setPosition(displayWidth*.23, displayHeight*.16)
    .setSize((int)(displayWidth*.39), (int)(displayHeight*.15))
    .setRange(0, 1000) // TODO change min and max (maybe dynamic)
    .setView(Chart.LINE) // use Chart.LINE, Chart.PIE, Chart.AREA, Chart.BAR_CENTERED
    .setStrokeWeight(1.5)
    .setColor(defaultColor)
    .setColorCaptionLabel(color(255))
    .moveTo("filling")
    .setFont(font);

  launchChart = cp5.addChart("Launch Chart")
    .setPosition(displayWidth*.23, displayHeight*.16)
    .setSize((int)(displayWidth*.39), (int)(displayHeight*.15))
    .setRange(0, 1000) // TODO change min and max (maybe dynamic)
    .setView(Chart.LINE) // use Chart.LINE, Chart.PIE, Chart.AREA, Chart.BAR_CENTERED
    .setStrokeWeight(1.5)
    .setColor(defaultColor)
    .setColorCaptionLabel(color(255))
    .moveTo("launch")
    .setFont(font);

  cp5.addButton("Reset Chart")
    .setPosition(displayWidth*.49, displayHeight*.32)
    .setSize((int)(displayWidth*button_width), (int)(displayHeight*button_height))
    .moveTo("filling")
    .setColor(defaultColor)
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
    .setFont(font);

  cp5.addButton("Reset")
    .setPosition(displayWidth*.49, displayHeight*.32)
    .setSize((int)(displayWidth*button_width), (int)(displayHeight*button_height))
    .moveTo("launch")
    .setColor(defaultColor)
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
    .setFont(font);

  ematch_label = cp5.addTextlabel("eMatch Value")
    .setText("E-Match value goes here")
    .setColor(labelColor)
    .setPosition(displayWidth*.4, displayHeight*.05)
    .moveTo("global")
    .setFont(font);

  List<String> portNames = Arrays.asList(Serial.list());   // List available serial ports and add them to a new ScrollableList

  cp5.addScrollableList("serialPort")
    .setPosition(displayWidth*.02, displayHeight*.6)
    .setSize((int)(displayWidth*.15), (int)(displayHeight*.12))
    .setBarHeight((int)(displayHeight*.05))
    .setItemHeight((int)(displayHeight*.05))
    .addItems(portNames)
    .setFont(font)
    .setColor(defaultColor)
    .moveTo("global")
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);

  log_display_rocket = cp5.addTextlabel("Rocket Log")
    .setText("Rocket state")
    .setColor(labelColor)
    .setPosition(displayWidth*button_x1, displayHeight*.71)
    .moveTo("global")
    .setFont(font);

  log_display_filling = cp5.addTextlabel("Filling Log")
    .setText("Filling state")
    .setColor(labelColor)
    .setPosition(displayWidth*button_x1, displayHeight*.76)
    .moveTo("global")
    .setFont(font);

  log_display_ignition = cp5.addTextlabel("Ignition Log")
    .setText("Ignition state")
    .setColor(labelColor)
    .setPosition(displayWidth*button_x1, displayHeight*.81)
    .moveTo("global")
    .setFont(font);

  ack_display = cp5.addTextlabel("Ack Display")
    .setText("Acks go here")
    .setColor(labelColor2)
    .setPosition(displayWidth*button_x1, displayHeight*.54)
    .moveTo("global")
    .setFont(font);

  log_stats = cp5.addTextlabel("Log Stats")
    .setText("Log stats go here")
    .setColor(labelColor2)
    .setPosition(displayWidth*button_x1, displayHeight*.6)
    .moveTo("global")
    .setFont(font);

  history = cp5.addTextlabel("Comms history")
    .setText("comms history goes here")
    .setColor(labelColor2)
    .setPosition(displayWidth*.63, displayHeight*.54)
    .moveTo("global")
    .setFont(font);

  status_toggle = cp5.addToggle("Status Toggle")
    .setPosition(width*.02, height*.5)
    .setSize((int)(width*.05), (int)(width*.02))
    .setValue(false)
    .setMode(ControlP5.SWITCH)
    .setLabel("Toggle Status")
    .setFont(font)
    .moveTo("global")
    .setColorForeground(color(100, 0, 0))  // Red when off
    .setColorBackground(color(255, 0, 0))
    .setColorActive(color(100, 0, 0));

  // manual
  cp5.addToggle("Manual Toggle")
    .setPosition(width*button_x1, height*.3)
    .setSize((int)(width*.05), (int)(width*.02))
    .setValue(false)
    .setMode(ControlP5.SWITCH)
    .setLabel("Toggle Manual")
    .setFont(font)
    .moveTo("default")
    .setColorForeground(color(100, 0, 0))  // Red when off
    .setColorBackground(color(255, 0, 0))
    .setColorActive(color(100, 0, 0));

  /*
  cp5.addScrollableList("Select Command")
   .setPosition(width*.02, height*.05)
   .setSize((int)(width*.17), (int)(height*.3))
   .setBarHeight((int)(height*.04))
   .setItemHeight((int)(height*.05))
   .addItems(man_commands)
   .setFont(font)
   .setColor(defaultColor)
   .moveTo("default")
   .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);
   */

  for (ManCommand command : ManCommand.values()) {
    cp5.addButton(command.name())
      .setPosition(displayWidth*.02, displayHeight*(.05 + command.ordinal() * .035))
      .setSize((int)(width*.2), (int)(height*.03))
      .moveTo("default")
      .setColor(defaultColor)
      .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
      .setFont(font);
  }

  cp5.addToggle("Mode Toggle")
    .setPosition(width*.94, height*.01)
    .setSize((int)(width*.05), (int)(width*.02))
    .setValue(false)
    .setMode(ControlP5.SWITCH)
    .setLabel("")
    .setFont(font)
    .setColorForeground(color(0))  // Red when off
    .setColorBackground(color(50))
    .setColorActive(color(0))
    .moveTo("default");

  chamber_label = cp5.addTextlabel("Chamber Threshold Temp")
    .setText("Chamber threshold temp")
    .setColor(labelColor)
    .setPosition(displayWidth*.02, displayHeight*.05)
    .moveTo("global")
    .setFont(font)
    ;
}

void launch_setup() {
  launchTab = cp5.addTab("launch")
    .activateEvent(true)
    .setColorLabel(labelColorDark)
    .setColorActive(red)
    .setColorForeground(blue)
    .setColorBackground(dark_blue)
    .setHeight((int)(displayHeight*.03))
    .setWidth((int)(displayWidth*.055))
    ;

  launchTab.getCaptionLabel()
    .setFont(font);
}

void filling_setup() {
  fillTab = cp5.addTab("filling")
    .activateEvent(true)
    .setColorLabel(labelColorDark)
    .setColorActive(red)
    .setColorForeground(blue)
    .setColorBackground(dark_blue)
    .setHeight((int)(displayHeight*.03))
    .setWidth((int)(displayWidth*.055))
    ;

  fillTab.getCaptionLabel()
    .setFont(font);
}

void manual_setup() {
  cp5.getTab("default")
    .activateEvent(true)
    .setColorLabel(labelColorDark)
    .setColorActive(red)
    .setColorForeground(blue)
    .setColorBackground(dark_blue)
    .setHeight((int)(displayHeight*.03))
    .setWidth((int)(displayWidth*.05))
    .setLabel("debug")
    .getCaptionLabel()
    .setFont(font);

  gps_label = cp5.addTextlabel("GPS")
    .setText("GPS goes here")
    .setColor(labelColor)
    .setPosition(displayWidth*.5, displayHeight*.5)
    .moveTo("global")
    .setFont(font);

  bar_label = cp5.addTextlabel("Barometer")
    .setText("Bar altitude here")
    .setColor(labelColor)
    .setPosition(displayWidth*.5, displayHeight*.5)
    .moveTo("global")
    .setFont(font);

  imu_label = cp5.addTextlabel("IMU")
    .setText("IMU hoes here")
    .setColor(labelColor)
    .setPosition(displayWidth*.5, displayHeight*.5)
    .moveTo("global")
    .setFont(font);

  kalman_label = cp5.addTextlabel("Kalman")
    .setText("Kalman goes here")
    .setColor(labelColor)
    .setPosition(displayWidth*.5, displayHeight*.5)
    .moveTo("global")
    .setFont(font);
}
