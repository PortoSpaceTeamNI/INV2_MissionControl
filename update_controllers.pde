void updateControllersData() {
  String n2_data = "N2\n" +
    "P: " + df.format(float(hydra_fs.n2.pressure) * .01) + " bar\n";
  n2_label.setText(n2_data);
  String n2o_data = "N2O\n" +
    "P: " + df.format(float(hydra_fs.n2o.pressure) * .01) + " bar\n" +
    "T: " + df.format(float(hydra_fs.n2o.temperature)* .1) + " ºC\n" +
    "W: " + df.format(float(lift_fs.n2o_loadcell) * .1) + " kg";
  n2o_label.setText(n2o_data);

  if (millis() - last_r_ping > doubt_timeout) {
    log_display_rocket.setText("State: " + obc.state.name() + "?");
  } else {
    log_display_rocket.setText("State: " + obc.state.name());
  }

  String chamber_data = "Chamber\n" +
    "P: " + df.format(float(hydra_lf.chamber_pressure) * .01) + " bar\n" +
    "T: " + df.format(float(hydra_lf.chamber_temperature) * .1) + " ºC";
  chamber_label.setText(chamber_data);

  // other
  ematch_label.setText("Main e-Match: " + (lift_r.main_ematch ? "ON" : "OFF")
    + "\nDrogue Chute e-Match: " + (elytra.drogue_chute_ematch ? "ON" : "OFF")
    + "\nMain Chute e-Match: " + (elytra.main_chute_ematch ? "ON" : "OFF"));

  String gps_data = "GPS          " +
    "Sat: " + str(int(nav.gps.sat_count)) +
    "\nLat: " + nav.gps.latitude + "    " +
    "Alt: " + df.format(float(nav.gps.altitude)) + "\n" +
    "Lon: " + nav.gps.longitude + "    " +
    "hVel: " + df.format(float(nav.gps.horizontal_velocity) * .1) + "\n";

  gps_label.setText(gps_data);

  String bar_data = "Barometer\n\n" +
    "Alt1: " + df.format(float(nav.barometer_alt1)) + "\n" +
    "Alt2: " + df.format(float(nav.barometer_alt2));
  bar_label.setText(bar_data);

  String imu_data = "IMU\n" +
    "\nAx: " + df.format(float(nav.imu.accel_x) * .1) + "\n" +
    "Ay: " + df.format(float(nav.imu.accel_y) * .1) + "\n" +
    "Az: " + df.format(float(nav.imu.accel_z) * .1) + "\n" +
    "Mx: " + df.format(float(nav.imu.mag_x) * .1) + "\n" +
    "My: " + df.format(float(nav.imu.mag_y) * .1) + "\n" +
    "Mz: " + df.format(float(nav.imu.mag_z) * .1) + "\n" +
    "\nGx: " + df.format(float(nav.imu.gyro_x) * .1) + "\n" +
    "Gy: " + df.format(float(nav.imu.gyro_y) * .1) + "\n" +
    "Gz: " + df.format(float(nav.imu.gyro_z) * .1);
  imu_label.setText(imu_data);

  String kalman_data = "Kalman\n\n" +
    "Alt: " + df.format(float(nav.kalman.altitude)*.1) + "\n" +
    "Max Alt: " + df.format(float(nav.kalman.max_altitude)*.1) + "\n" +
    "Vel: " + df.format(float(nav.kalman.velocity_z)*.1) + "\n" +
    "Acel: " + df.format(float(nav.kalman.acceleration_z)*.1) + "\n" +
    "q1: " + df.format(float(nav.kalman.q1)) + "\n" +
    "q2: " + df.format(float(nav.kalman.q2)) + "\n" +
    "q3: " + df.format(float(nav.kalman.q3)) + "\n" +
    "q4: " + df.format(float(nav.kalman.q4));
  kalman_label.setText(kalman_data);
}

void updateControllersPos(String tab) {
  if (tab == "default") {
    // fill
    n2_label.setPosition(width*.25, height*.05);
    n2o_label.setPosition(width*.35, height*.05);
    quick_dc_label.setPosition(width*.45, height*.05);
    //rocket
    uf_label.setPosition(width*.25, height*.2);
    lf_label.setPosition(width*.35, height*.2);
    //ignition
    chamber_label.setPosition(width*.45, height*.2);

    //fill
    n2_fill_toggle.setPosition(width*.25, height*.15);
    n2o_fill_toggle.setPosition(width*.35, height*.15);
    n2_purge_toggle.setPosition(width*.45, height*.15);
    n2o_purge_toggle.setPosition(width*.55, height*.15);
    
    // rocket
    pressurizing_toggle.setSize((int)(width*toggle_width), (int)(height*toggle_height));
    vent_toggle.setSize((int)(width*toggle_width), (int)(height*toggle_height));
    abort_toggle.setSize((int)(width*toggle_width), (int)(height*toggle_height));
    main_toggle.setSize((int)(width*toggle_width), (int)(height*toggle_height));
    pressurizing_toggle.setPosition(width*.15, height*.28);
    vent_toggle.setPosition(width*.25, height*.28);
    abort_toggle.setPosition(width*.35, height*.28);
    main_toggle.setPosition(width*.45, height*.28);

    //other
    ematch_label.setPosition(width*.55, height*.05);
    gps_label.setPosition(width*.55, height*.15);
    bar_label.setPosition(width*.45, height*.32);
    imu_label.setPosition(width*.25, height*.32);
    kalman_label.setPosition(width*.35, height*.32);
  } else if (tab == "filling") {
    n2_label.setPosition(displayWidth*.5, displayHeight*.47);
    n2o_label.setPosition(displayWidth*.5, displayHeight*.69);
    quick_dc_label.setPosition(displayWidth*.4, displayHeight*.48);
    uf_label.setPosition(displayWidth*.31, displayHeight*.35);
    lf_label.setPosition(displayWidth*.39, displayHeight*.83);
    chamber_label.setPosition(width*.25, height*.89);

    n2_fill_toggle.setPosition(width*.5, height*.55);
    n2o_fill_toggle.setPosition(width*.5, height*.65);
    n2_purge_toggle.setPosition(width*.5, height*.55);
    n2o_purge_toggle.setPosition(width*.5, height*.65);
    n2_quick_dc_toggle.setPosition(width*.385, height*.62);
    n2o_quick_dc_toggle.setPosition(width*.385, height*.62);

    vent_toggle.setSize((int)(width*toggle_width), (int)(height*toggle_height));
    abort_toggle.setSize((int)(width*toggle_width), (int)(height*toggle_height));
    main_toggle.setSize((int)(width*toggle_width), (int)(height*toggle_height));
    pressurizing_toggle.setSize((int)(width*toggle_width), (int)(height*toggle_height));
    
    vent_toggle.setPosition(width*.265, height*.41);
    abort_toggle.setPosition(width*.32, height*.84);
    main_toggle.setPosition(width*.265, height*.8);
    pressurizing_toggle.setPosition(width*.265, height*.8);
    
  } else if (tab == "launch") {
    ematch_label.setPosition(displayWidth*.4, displayHeight*.05);
    chamber_label.setPosition(displayWidth*.55, displayHeight*.05);
    gps_label.setPosition(width*.23, height*.4);
    kalman_label.setPosition(width*.25, height*.5);

    vent_toggle.setPosition(width*.095, height*.07);
    abort_toggle.setPosition(width*.14, height*.3);
    main_toggle.setPosition(width*.095, height*.45);
    pressurizing_toggle.setPosition(width*.095, height*.45);

    vent_toggle.setSize((int)(width*.02), (int)(height*.02));
    pressurizing_toggle.setSize((int)(width*.02), (int)(height*.02));
    abort_toggle.setSize((int)(width*.02), (int)(height*.02));
    main_toggle.setSize((int)(width*.02), (int)(height*.02));
  }
}
