PImage fill_diagram;
PImage map_image;
Icon testIcon;

void setupDiagrams() {
  fill_diagram = loadImage(fill_img);
  setupGPSMap();
  setup3D();
  n2_label = cp5.addLabel("N2\nP : ####")
    .setColor(labelColor)
    .setFont(font)
    .moveTo("global")
    .setPosition(displayWidth*.5, displayHeight*.47)
    .setSize((int)(displayWidth*.1), (int)(displayHeight*.1))
    .setLock(true)
    ;

  n2_toggle = cp5.addToggle("N2")
    .setPosition(width*.495, height*.553)
    .setSize((int)(width*toggle_width), (int)(height*toggle_height))
    .setValue(false)
    .setMode(ControlP5.SWITCH)
    .setLabel("")
    .setFont(font)
    .setColorForeground(color(100, 0, 0))  // Red when off
    .setColorBackground(color(255, 0, 0))
    .setColorActive(color(100, 0, 0))
    .moveTo("global")
    ;

  n2o_label = cp5.addLabel("N2O\nT : ####\nP : ####\nW : ####")
    .setColor(labelColor)
    .setFont(font)
    .moveTo("global")
    .setPosition(displayWidth*.5, displayHeight*.69)
    .setSize((int)(displayWidth*.1), (int)(displayHeight*.1))
    .setLock(true)
    ;
  n2o_toggle = cp5.addToggle("N2O")
    .setPosition(width*.495, height*.65)
    .setSize((int)(width*toggle_width), (int)(height*toggle_height))
    .setValue(false)
    .setMode(ControlP5.SWITCH)
    .setLabel("")
    .setFont(font)
    .setColorForeground(color(100, 0, 0))  // Red when off
    .setColorBackground(color(255, 0, 0))
    .setColorActive(color(100, 0, 0))
    .moveTo("global");

  line_label = cp5.addLabel("Line Purge\nT : ####\nP : ####")
    .setColor(labelColor)
    .setFont(font)
    .moveTo("global")
    .setPosition(displayWidth*.4, displayHeight*.48)
    .setSize((int)(displayWidth*.1), (int)(displayHeight*.1))
    .setLock(true)
    ;
  line_toggle = cp5.addToggle("LINE_PURGE")
    .setPosition(width*.394, height*.566)
    .setSize((int)(width*toggle_width), (int)(height*toggle_height))
    .setValue(false)
    .setMode(ControlP5.SWITCH)
    .setLabel("")
    .setFont(font)
    .setColorForeground(color(100, 0, 0))  // Red when off
    .setColorBackground(color(255, 0, 0))
    .setColorActive(color(100, 0, 0))
    .moveTo("global");

  tt_label = cp5.addLabel("Tank Top\nT : ####\nP : ####")
    .setColor(labelColor)
    .setFont(font)
    .moveTo("global")
    .setPosition(displayWidth*.31, displayHeight*.35)
    .setSize((int)(displayWidth*.1), (int)(displayHeight*.1))
    .setLock(true)
    ;
  tt_toggle = cp5.addToggle("TANK_TOP")
    .setPosition(width*.275, height*.405)
    .setSize((int)(width*toggle_width), (int)(height*toggle_height))
    .setValue(false)
    .setMode(ControlP5.SWITCH)
    .setLabel("")
    .setFont(font)
    .setColorForeground(color(100, 0, 0))  // Red when off
    .setColorBackground(color(255, 0, 0))
    .setColorActive(color(100, 0, 0))
    .moveTo("global");

  tb_label = cp5.addLabel("Tank Bottom\nT : ####\nP : ####")
    .setColor(labelColor)
    .setFont(font)
    .moveTo("global")
    .setPosition(displayWidth*.25, displayHeight*.89)
    .setSize((int)(displayWidth*.1), (int)(displayHeight*.1))
    .setLock(true)
    ;
  tb_toggle = cp5.addToggle("TANK_BOTTOM")
    .setPosition(width*.275, height*.83)
    .setSize((int)(width*toggle_width), (int)(height*toggle_height))
    .setValue(false)
    .setMode(ControlP5.SWITCH)
    .setLabel("")
    .setFont(font)
    .setColorForeground(color(100, 0, 0))  // Red when off
    .setColorBackground(color(255, 0, 0))
    .setColorActive(color(100, 0, 0))
    .moveTo("global");

  chamber_toggle = cp5.addToggle("Chamber Toggle")
    .setPosition(width*.345, height*.85)
    .setSize((int)(width*toggle_width), (int)(height*toggle_height))
    .setValue(false)
    .setMode(ControlP5.SWITCH)
    .setLabel("")
    .setFont(font)
    .setColorForeground(color(100, 0, 0))  // Red when off
    .setColorBackground(color(255, 0, 0))
    .setColorActive(color(100, 0, 0))
    .moveTo("global");


  diagram_labels = Arrays.asList(n2_label, n2o_label, line_label, tt_label, tb_label);
  valve_toggles = Arrays.asList(tt_toggle, tb_toggle, chamber_toggle, n2_toggle, n2o_toggle, line_toggle);
}

void updateDiagrams() {
  background(bgColor);
  updateGPSMap();
  if (cp5.getTab("launch").isActive()) {
    update3D();
  }
  if (cp5.getTab("filling").isActive()) {
    image(fill_diagram, width*.23, height*.38, fill_diagram.width* 1.2 * width/1920, fill_diagram.height * 1.2 * height/1080); // scale image with display size
  }
  for ( Toggle toggle : valve_toggles) {
    toggle.setBroadcast(false);
  }

  // he valve
  if (filling_data.he.valve) {
    fill(0, 255, 0);
    n2_toggle.setState(true);
  } else {
    fill(255, 0, 0);
    n2_toggle.setState(false);
  }
  //circle(width*.56, height*.633, height*.018);

  // n2o valve
  if (filling_data.n2o.valve) {
    fill(0, 255, 0);
    n2o_toggle.setState(true);
  } else {
    fill(255, 0, 0);
    n2o_toggle.setState(false);
  }
  //circle(width*.56, height*.73, height*.018);

  // line valve
  if (filling_data.line.valve) {
    fill(0, 255, 0);
    line_toggle.setState(true);
  } else {
    fill(255, 0, 0);
    line_toggle.setState(false);
  }
  //circle(width*.423, height*.698, height*.018);

  // tt valve
  if (rocket_data.valves.purge_top) {
    fill(0, 255, 0);
    tt_toggle.setState(true);
  } else {
    fill(255, 0, 0);
    tt_toggle.setState(false);
  }
  //circle(width*.304, height*.46, height*.018);

  // tb valve
  if (rocket_data.valves.purge_bot) {
    fill(0, 255, 0);
    tb_toggle.setState(true);
  } else {
    fill(255, 0, 0);
    tb_toggle.setState(false);
  }
  //circle(width*.304, height*.935, height*.018);

  if (rocket_data.valves.chamber) {
    fill(0, 255, 0);
    chamber_toggle.setState(true);
  } else {
    fill(255, 0, 0);
    chamber_toggle.setState(false);
  }
  //circle(width*.304, height*.935, height*.018);

  for (Toggle toggle : valve_toggles) {
    boolean v_state = toggle.getState();
    if (v_state == true) {
      toggle.setColorForeground(color(0, 100, 0))
        .setColorBackground(color(0, 255, 0))
        .setColorActive(color(0, 100, 0));     // Green when on
    } else if (v_state == false) {
      toggle.setColorForeground(color(100, 0, 0))// Red when off
        .setColorActive(color(100, 0, 0))    // Red when off
        .setColorBackground(color(255, 0, 0));
    }
    toggle.setBroadcast(true);
  }
}

void multi_tab_controllers(String tab) {
  if (tab == "default") {
    ematch_label.show();
    gps_label.show();
    bar_label.show();
    imu_label.show();
    kalman_label.show();
    pressureLabel.hide();
  } else if (tab == "launch") {
    gps_label.show();
    pressureLabel.show();
    ematch_label.show();
    imu_label.hide();
    bar_label.hide();
    kalman_label.hide();
  } else {
    pressureLabel.show();
    ematch_label.hide();
    gps_label.hide();
    bar_label.hide();
    imu_label.hide();
    kalman_label.hide();
  }

  if (tab == "launch") {
    for (Textlabel label : diagram_labels) {
      label.hide();
    }
    line_toggle.hide();
    n2_toggle.hide();
    n2o_toggle.hide();
  } else {
    for (Textlabel label : diagram_labels) {
      label.show();
    }
    line_toggle.show();
    n2_toggle.show();
    n2o_toggle.show();
  }
}
