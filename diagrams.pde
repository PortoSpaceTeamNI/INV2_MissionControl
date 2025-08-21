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

  n2_fill_toggle = cp5.addToggle("N2 Fill")
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
  
  n2_purge_toggle = cp5.addToggle("N2 Purge")
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
  n2o_fill_toggle = cp5.addToggle("N2O fill toggle")
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
    
  n2o_purge_toggle = cp5.addToggle("N2O purge toggle")
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

  quick_dc_label = cp5.addLabel("Quick Connects\nP : ####")
    .setColor(labelColor)
    .setFont(font)
    .moveTo("global")
    .setPosition(displayWidth*.4, displayHeight*.48)
    .setSize((int)(displayWidth*.1), (int)(displayHeight*.1))
    .setLock(true)
    ;
  n2o_quick_dc_toggle = cp5.addToggle("N2O quick dc toggle")
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
    
  n2_quick_dc_toggle = cp5.addToggle("N2 quick dc toggle")
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

  uf_label = cp5.addLabel("Upper Feed\nT1 : ####\nT2 : ####\n")
    .setColor(labelColor)
    .setFont(font)
    .moveTo("global")
    .setPosition(displayWidth*.31, displayHeight*.35)
    .setSize((int)(displayWidth*.1), (int)(displayHeight*.1))
    .setLock(true)
    ;
  vent_toggle = cp5.addToggle("Vent Toggle")
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
    
  pressurizing_toggle = cp5.addToggle("Pressurizing Toggle")
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

  lf_label = cp5.addLabel("Lower Feed\nT1 : ####\nT2 : ####\nT3 : ####\nP : ####")
    .setColor(labelColor)
    .setFont(font)
    .moveTo("global")
    .setPosition(displayWidth*.25, displayHeight*.89)
    .setSize((int)(displayWidth*.1), (int)(displayHeight*.1))
    .setLock(true)
    ;
  abort_toggle = cp5.addToggle("Abort Toggle")
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

  main_toggle = cp5.addToggle("Main Toggle")
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


  diagram_labels = Arrays.asList(n2o_label, n2_label, quick_dc_label, uf_label, lf_label, chamber_label);
  valve_toggles = Arrays.asList(pressurizing_toggle, vent_toggle, abort_toggle, main_toggle, n2_purge_toggle, n2o_purge_toggle, n2_fill_toggle, n2o_fill_toggle, n2_quick_dc_toggle, n2o_quick_dc_toggle);
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
  if (hydra_fs.n2.fill_valve) {
    fill(0, 255, 0);
    n2_fill_toggle.setState(true);
  } else {
    fill(255, 0, 0);
    n2_fill_toggle.setState(false);
  }
  //circle(width*.56, height*.633, height*.018);

  // he valve
  if (hydra_fs.n2.purge_valve) {
    fill(0, 255, 0);
    n2_purge_toggle.setState(true);
  } else {
    fill(255, 0, 0);
    n2_purge_toggle.setState(false);
  }
  //circle(width*.56, height*.633, height*.018);
  
  // n2o valve
  if (hydra_fs.n2o.fill_valve) {
    fill(0, 255, 0);
    n2o_fill_toggle.setState(true);
  } else {
    fill(255, 0, 0);
    n2o_fill_toggle.setState(false);
  }
  //circle(width*.56, height*.73, height*.018);
  
  // n2o valve
  if (hydra_fs.n2o.purge_valve) {
    fill(0, 255, 0);
    n2o_purge_toggle.setState(true);
  } else {
    fill(255, 0, 0);
    n2o_purge_toggle.setState(false);
  }
  //circle(width*.56, height*.73, height*.018);

  // line valve
  if (hydra_fs.quick_dc.n2o_valve) {
    fill(0, 255, 0);
    n2o_quick_dc_toggle.setState(true);
  } else {
    fill(255, 0, 0);
    n2o_quick_dc_toggle.setState(false);
  }
  //circle(width*.423, height*.698, height*.018);
  
  // line valve
  if (hydra_fs.quick_dc.n2_valve) {
    fill(0, 255, 0);
    n2_quick_dc_toggle.setState(true);
  } else {
    fill(255, 0, 0);
    n2_quick_dc_toggle.setState(false);
  }
  //circle(width*.423, height*.698, height*.018);

  // tt valve
  if (hydra_uf.vent_valve) {
    fill(0, 255, 0);
    vent_toggle.setState(true);
  } else {
    fill(255, 0, 0);
    vent_toggle.setState(false);
  }
  //circle(width*.304, height*.46, height*.018);
  
  // tt valve
  if (hydra_uf.pressurizing_valve) {
    fill(0, 255, 0);
    pressurizing_toggle.setState(true);
  } else {
    fill(255, 0, 0);
    pressurizing_toggle.setState(false);
  }
  //circle(width*.304, height*.46, height*.018);

  // tb valve
  if (hydra_lf.abort_valve) {
    fill(0, 255, 0);
    abort_toggle.setState(true);
  } else {
    fill(255, 0, 0);
    abort_toggle.setState(false);
  }
  //circle(width*.304, height*.935, height*.018);

  if (hydra_lf.main_valve) {
    fill(0, 255, 0);
    main_toggle.setState(true);
  } else {
    fill(255, 0, 0);
    main_toggle.setState(false);
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
    n2o_purge_toggle.hide();
    n2_purge_toggle.hide();
    n2_fill_toggle.hide();
    n2o_fill_toggle.hide();
  } else {
    for (Textlabel label : diagram_labels) {
      label.show();
    }
    n2_purge_toggle.show();
    n2o_purge_toggle.show();
    n2_fill_toggle.show();
    n2o_fill_toggle.show();
  }
}
