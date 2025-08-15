public void controlEvent(ControlEvent event) {
  if (event.isFrom("serialPort")) {
    port_selected = false;
    int index = (int)event.getValue();
    selectedPort = Serial.list()[index];
    println("Selected serial port: " + selectedPort);
    // Open the selected serial port here. Close any previously opened port first.
    if (myPort != null) {
      myPort.stop();
    }
    thread("serialThread");
  } else if (event.isFrom("Execute")) {
    for (int i = 0; i < 3; i++) {
      String input = textfields[i].getText();
      try {
        prog_inputs[i] = Integer.parseInt(input);
      }
      catch (NumberFormatException e) {
        prog_inputs[i] = -1;
        println("invalid input");
      }
    }
    if (selected_index >= 0) {
      byte[] payload = {prog_cmds[selected_index],
        (byte) ((prog_inputs[0] >> 8) & 0xff),
        (byte)(prog_inputs[0] & 0xff),
        (byte)((prog_inputs[1] >> 8) & 0xff),
        (byte) (prog_inputs[1] & 0xff),
        (byte)((prog_inputs[2] >> 8) & 0xff),
        (byte) (prog_inputs[2] & 0xff),
        (byte)((prog_inputs[3] >> 8) & 0xff),
        (byte) (prog_inputs[3] & 0xff),
      };
      send((byte)Command.FILL_EXEC.ordinal(), payload);
    } else {
      println("No program selected");
    }
  } else if (event.isFrom("program")) {
    selected_index = (int) event.getValue();
    String program = programs.get(selected_index);
    for (int i = 0; i < 5; i++) {
      String arg = vars.get(i);
      if (prog_args.get(program)[i]) {
        cp5.getController(arg).setColor(defaultColor);
      } else {
        cp5.getController(arg).setColor(unactiveColor);
      }
    }
    println(program);
  } else if (event.isFrom("Stop")) {
    send((byte)Command.STOP.ordinal(), empty_payload);
  } else if (event.isFrom("Resume")) {
    send((byte)Command.FILL_RESUME.ordinal(), empty_payload);
  } else if (event.isFrom("Status")) {
    request_status();
  } else if (event.isFrom("Select ID")) {
    targetID = (byte) (event.getValue() + 1);
  } else if (event.isFrom("Abort")) {
    byte lastID = targetID;
    targetID = 4;
    send((byte)Command.ABORT.ordinal(), empty_payload);
    targetID = lastID;
  } else if (event.isFrom("Arm")) {
    send((byte)Command.ARM.ordinal(), empty_payload);
  } else if (event.isFrom("Ready")) {
    send((byte)Command.READY.ordinal(), empty_payload);
    status_toggle.setState(true);
  } else if (event.isFrom(status_toggle)) {
    status_toggle_state = (int) event.getController().getValue();
    if (status_toggle_state == 1) {
      status_toggle.setColorForeground(color(0, 100, 0))
        .setColorBackground(color(0, 255, 0))
        .setColorActive(color(0, 100, 0));     // Green when on
    } else if (status_toggle_state == 0) {
      status_toggle.setColorForeground(color(100, 0, 0))// Red when off
        .setColorActive(color(100, 0, 0))    // Red when off
        .setColorBackground(color(255, 0, 0));
    }
  } else if (event.isFrom(valve_toggle)) {
    valve_toggle_state = (int) event.getController().getValue();
    if (valve_toggle_state == 1) {
      valve_toggle.setColorForeground(color(0, 100, 0))
        .setColorBackground(color(0, 255, 0))
        .setColorActive(color(0, 100, 0));     // Green when on
    } else if (valve_toggle_state == 0) {
      valve_toggle.setColorForeground(color(100, 0, 0))// Red when off
        .setColorActive(color(100, 0, 0))    // Red when off
        .setColorBackground(color(255, 0, 0));
    }
  } else if (event.isFrom("Manual Toggle")) {
    int allow_manual = (int) event.getController().getValue();
    byte[] payload = {(byte)allow_manual};
    send((byte)Command.MANUAL_ENABLE.ordinal(), payload);
  }
  if (valve_toggles != null) {
    for (Toggle toggle : valve_toggles) {
      if (event.isFrom(toggle.getName())) {
        int state = (int) event.getController().getValue();
        if (state == 1) {
          toggle.setColorForeground(color(0, 100, 0))
            .setColorBackground(color(0, 255, 0))
            .setColorActive(color(0, 100, 0));     // Green when on
        } else if (state == 0) {
          toggle.setColorForeground(color(100, 0, 0)) // Red when off
            .setColorActive(color(100, 0, 0))    // Red when off
            .setColorBackground(color(255, 0, 0));
        }
        byte[] payload = {(byte)ValveToggle.valueOf(toggle.getName()).ordinal(), (byte) state};
        byte lastID = targetID;
        targetID = 4;
        send((byte)Command.MANUAL_EXEC.ordinal(), payload);
        targetID = lastID;
      }
    }
  }
  for (ManCommand man_cmd : ManCommand.values()) {
    if (event.isFrom(man_cmd.name())) {
      byte[] man_payload = {(byte) man_cmd.ordinal()};
      send((byte)Command.MANUAL_EXEC.ordinal(), man_payload);
    }
  }
  if (event.isFrom("Reset Chart")) {
    fillingChart.setData("Pressure", new float[0]);
    fillingChart.setData("Temperature", new float[0]);
    fillingChart.setData("Weight", new float[0]);
  } else if (event.isTab()) {
    multi_tab_controllers(event.getTab().getName());
    updateControllersPos(event.getTab().getName());
  } else if (event.isFrom("Reset")) {
    launchChart.setData("Altitude", new float[0]);
    launchChart.setData("Velocity", new float[0]);
    launchChart.setData("Acceleration", new float[0]);
  } else if (event.isFrom("Open valve")) {
    try {
      int valve_time = (int) Float.parseFloat(valve_ms.getText());
      print(valve_time);
      byte[] payload = {(byte)valve_selected, (byte) valve_time};
      send((byte)ManCommand.VALVE_MS.ordinal(), payload);
    }
    catch (Exception e) {
      print("Valve open time empty\n");
    }
  } else if (event.isFrom("Mode Toggle")) {
    int mode = (int) event.getValue();
    mode = 1; // force dark : delete when light is done
    if (mode == 0) { // light mode
      abortColor = abortColorLight;
      stopColor = stopColorLight;
      unactiveColor = unactiveColorLight;
      defaultColor = defaultColorLight;
      bgColor = bgColorLight;
      fill_img = fill_img_light;
      labelColor = labelColorLight;
      labelColor2 = labelColor2Light;
    } else { // dark mode
      abortColor = abortColorDark;
      stopColor = stopColorDark;
      unactiveColor = unactiveColorDark;
      defaultColor = defaultColorDark;
      bgColor = bgColorDark;
      fill_img = fill_img_dark;
      labelColor = labelColorDark;
      labelColor2 = labelColor2Dark;
    }
    fill_diagram = loadImage(fill_img);
  }
}
