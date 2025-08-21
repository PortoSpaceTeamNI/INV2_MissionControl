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
Textlabel n2_label, n2_p_label, n2o_p_label, n2o_t_label, n2o_w_label, n2o_label, quick_dc_label, n2o_tank_label, chamber_label;
Toggle n2_fill_toggle, n2_purge_toggle, n2_quick_dc_toggle, n2o_fill_toggle, n2o_purge_toggle, n2o_quick_dc_toggle, pressurizing_toggle, vent_toggle, abort_toggle, main_toggle;
Toggle status_toggle;
Textlabel gps_label, bar_label, imu_label, kalman_label;

// GUI Positions and Sizes
float button_x1 = .8; // * width
float button_x2 = .89;
float button_height = .04; // * height
float button_height_big = .07;
float button_width = .13; // * width
float toggle_height = .025;
float toggle_width = .025;


void setupControllers() {
  manual_setup();
  filling_setup();
  launch_setup();

  cp5.addScrollableList("program")
    .setPosition(width*.02, height*.05)
    .setSize((int)(width*.15), (int)(height*.46))
    .setBarHeight((int)(height*.05))
    .setItemHeight((int)(height*.05))
    .addItems(programs)
    .setFont(font)
    .setColor(defaultColor)
    .moveTo("filling")
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);


  // Textfields for parameters and limits
  param_fields[0] = cp5.addTextfield("Target P")
    .setAutoClear(false)
    .setColor(defaultColor)
    .setPosition(width*.23, height*.05)
    .setSize((int)(width*.09), (int)(height*.05))
    .setFont(font)
    .setInputFilter(ControlP5.FLOAT)
    .moveTo("filling");

  param_fields[1] = cp5.addTextfield("Trigger P")
    .setAutoClear(false)
    .setColor(defaultColor)
    .setPosition(width*.33, height*.05)
    .setSize((int)(width*.09), (int)(height*.05))
    .setFont(font)
    .setInputFilter(ControlP5.FLOAT)
    .moveTo("filling");

  param_fields[2] = cp5.addTextfield("Target W")
    .setAutoClear(false)
    .setColor(defaultColor)
    .setPosition(width*.43, height*.05)
    .setSize((int)(width*.09), (int)(height*.05))
    .setFont(font)
    .setInputFilter(ControlP5.FLOAT)
    .moveTo("filling");
    
  param_fields[3] = cp5.addTextfield("Trigger T")
    .setAutoClear(false)
    .setColor(defaultColor)
    .setPosition(width*.53, height*.05)
    .setSize((int)(width*.09), (int)(height*.05))
    .setFont(font)
    .setInputFilter(ControlP5.FLOAT)
    .moveTo("filling");

  // Send button
  cp5.addButton("Execute")
    .setPosition(width*.63, height*.05)
    .setSize((int)(width*.1), (int)(height*.05))
    .moveTo("filling")
    .setColor(defaultColor)
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
    .setFont(font);

  cp5.addButton("Stop")
    .setPosition(width*button_x1, height*.13)
    .setSize((int)(width*button_width), (int)(height*button_height_big))
    .moveTo("global")
    .setColor(stopColor)
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
    .setFont(font);

  cp5.addButton("Resume")
    .setPosition(width*button_x1, height*.35)
    .setSize((int)(width*button_width), (int)(height*button_height))
    .moveTo("filling")
    .setColor(defaultColor)
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
    .setFont(font);

  cp5.addButton("Status")
    .setPosition(width*button_x1, height*.21)
    .setSize((int)(width*button_width), (int)(height*button_height_big))
    .moveTo("global")
    .setColor(defaultColor)
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
    .setFont(font);

  cp5.addButton("Abort")
    .setPosition(width*button_x1, height*.05)
    .setSize((int)(width*button_width), (int)(height*button_height_big))
    .setColor(abortColor)
    .moveTo("global")
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
    .setFont(font);

  cp5.addButton("Arm")
    .setPosition(width*button_x1, height*.3)
    .setSize((int)(width*button_width), (int)(height*button_height))
    .moveTo("launch")
    .setColor(defaultColor)
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
    .setFont(font);

  cp5.addButton("Ready")
    .setPosition(width*button_x1, height*.35)
    .setSize((int)(width*button_width), (int)(height*button_height))
    .moveTo("launch")
    .setColor(defaultColor)
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
    .setFont(font);

  fillingChart = cp5.addChart("Filling Chart")
    .setPosition(width*.23, height*.16)
    .setSize((int)(width*.39), (int)(height*.15))
    .setRange(0, 1000) // TODO change min and max (maybe dynamic)
    .setView(Chart.LINE) // use Chart.LINE, Chart.PIE, Chart.AREA, Chart.BAR_CENTERED
    .setStrokeWeight(1.5)
    .setColor(defaultColor)
    .setColorCaptionLabel(color(255))
    .moveTo("filling")
    .setFont(font);

  launchChart = cp5.addChart("Launch Chart")
    .setPosition(width*.23, height*.16)
    .setSize((int)(width*.39), (int)(height*.15))
    .setRange(0, 1000) // TODO change min and max (maybe dynamic)
    .setView(Chart.LINE) // use Chart.LINE, Chart.PIE, Chart.AREA, Chart.BAR_CENTERED
    .setStrokeWeight(1.5)
    .setColor(defaultColor)
    .setColorCaptionLabel(color(255))
    .moveTo("launch")
    .setFont(font);

  cp5.addButton("Reset Chart")
    .setPosition(width*.49, height*.32)
    .setSize((int)(width*button_width), (int)(height*button_height))
    .moveTo("filling")
    .setColor(defaultColor)
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
    .setFont(font);

  cp5.addButton("Reset")
    .setPosition(width*.49, height*.32)
    .setSize((int)(width*button_width), (int)(height*button_height))
    .moveTo("launch")
    .setColor(defaultColor)
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
    .setFont(font);

  ematch_label = cp5.addTextlabel("eMatch Value")
    .setText("E-Match value goes here")
    .setColor(labelColor)
    .setPosition(width*.4, height*.05)
    .moveTo("global")
    .setFont(font);

  List<String> portNames = Arrays.asList(Serial.list());   // List available serial ports and add them to a new ScrollableList

  cp5.addScrollableList("serialPort")
    .setPosition(width*.02, height*.6)
    .setSize((int)(width*.15), (int)(height*.12))
    .setBarHeight((int)(height*.05))
    .setItemHeight((int)(height*.05))
    .addItems(portNames)
    .setFont(font)
    .setColor(defaultColor)
    .moveTo("global")
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER);

  log_display_rocket = cp5.addTextlabel("Rocket Log")
    .setText("Rocket state")
    .setColor(labelColor)
    .setPosition(width*button_x1, height*.71)
    .moveTo("global")
    .setFont(font);

  ack_display = cp5.addTextlabel("Ack Display")
    .setText("Acks go here")
    .setColor(labelColor2)
    .setPosition(width*button_x1, height*.54)
    .moveTo("global")
    .setFont(font);

  log_stats = cp5.addTextlabel("Log Stats")
    .setText("Log stats go here")
    .setColor(labelColor2)
    .setPosition(width*button_x1, height*.6)
    .moveTo("global")
    .setFont(font);

  history = cp5.addTextlabel("Comms history")
    .setText("comms history goes here")
    .setColor(labelColor2)
    .setPosition(width*.63, height*.54)
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
      .setPosition(width*.02, height*(.05 + command.ordinal() * .035))
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
    .setPosition(width*.02, height*.05)
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
    .setHeight((int)(height*.03))
    .setWidth((int)(width*.055))
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
    .setHeight((int)(height*.03))
    .setWidth((int)(width*.055))
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
    .setHeight((int)(height*.03))
    .setWidth((int)(width*.05))
    .setLabel("debug")
    .getCaptionLabel()
    .setFont(font);

  gps_label = cp5.addTextlabel("GPS")
    .setText("GPS goes here")
    .setColor(labelColor)
    .setPosition(width*.5, height*.5)
    .moveTo("global")
    .setFont(font);

  bar_label = cp5.addTextlabel("Barometer")
    .setText("Bar altitude here")
    .setColor(labelColor)
    .setPosition(width*.5, height*.5)
    .moveTo("global")
    .setFont(font);

  imu_label = cp5.addTextlabel("IMU")
    .setText("IMU hoes here")
    .setColor(labelColor)
    .setPosition(width*.5, height*.5)
    .moveTo("global")
    .setFont(font);

  kalman_label = cp5.addTextlabel("Kalman")
    .setText("Kalman goes here")
    .setColor(labelColor)
    .setPosition(width*.5, height*.5)
    .moveTo("global")
    .setFont(font);
}
