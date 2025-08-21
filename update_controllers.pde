void updateControllersData() {
  n2_p_label.setText(df.format(float(hydra_fs.n2.pressure) * .01) + " bar");
  
  n2o_p_label.setText(df.format(float(hydra_fs.n2o.pressure) * .01) + " bar");
  n2o_t_label.setText(df.format(float(hydra_fs.n2o.temperature) * .01) + " ºC");
  n2o_w_label.setText(df.format(float(lift_fs.n2o_loadcell) * .1) + " kg");

  String n2o_tank_data = "N2O Tank\n" +
    "UF\n" + 
    df.format(float(hydra_uf.probe_thermo1) * .01) + " ºC\n" +
    df.format(float(hydra_uf.probe_thermo2) * .01) + " ºC\n" +
    "LF\n" + 
    df.format(float(hydra_lf.probe_thermo1) * .01) + " ºC\n" +
    df.format(float(hydra_lf.probe_thermo2) * .01) + " ºC\n" +
    df.format(float(hydra_lf.probe_thermo3) * .01) + " ºC\n" +
    df.format(float(hydra_lf.tank_pressure) * .01) + " bar";
  n2o_tank_label.setText(n2o_tank_data);
  
  String quick_dc_data =
    df.format(float(hydra_fs.quick_dc.pressure) * .01) + "\n  bar";
  quick_dc_label.setText(quick_dc_data);
  
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
    "Gx: " + df.format(float(nav.imu.gyro_x) * .1) + "\n" +
    "Gy: " + df.format(float(nav.imu.gyro_y) * .1) + "\n" +
    "Gz: " + df.format(float(nav.imu.gyro_z) * .1);
  imu_label.setText(imu_data);

  String kalman_data = "Kalman\n" +
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
  if (tab == "launch") {
    ematch_label.setPosition(width*.4, height*.05);
    chamber_label.setPosition(width*.55, height*.05);
    gps_label.setPosition(width*.23, height*.4);
    kalman_label.setPosition(width*.24, height*.5);

    vent_toggle.setPosition(width*.095, height*.07);
    abort_toggle.setPosition(width*.14, height*.3);
    main_toggle.setPosition(width*.095, height*.45);
    pressurizing_toggle.setPosition(width*.095, height*.45);

    vent_toggle.setSize((int)(width*.02), (int)(height*.02));
    pressurizing_toggle.setSize((int)(width*.02), (int)(height*.02));
    abort_toggle.setSize((int)(width*.02), (int)(height*.02));
    main_toggle.setSize((int)(width*.02), (int)(height*.02));
  } else {
    ematch_label.setPosition(width*.23, height*.05);
    chamber_label.setPosition(width*.3, height*.1);
    gps_label.setPosition(width*.23, height*.13);
    kalman_label.setPosition(width*.41, height*.05);
    
    bar_label.setPosition(width*.5, height*.05);
    imu_label.setPosition(width*.58, height*.05);
    
    n2_label.setPosition(width*.511, height*.451);
    n2_p_label.setPosition(width*.443, height*.55);
    
    n2o_label.setPosition(width*.57, height*.6);
    n2o_t_label.setPosition(width*.473, height*.822);
    n2o_p_label.setPosition(width*.418, height*.773);
    n2o_w_label.setPosition(width*.565, height*.932);
    
    quick_dc_label.setPosition(width*.385, height*.55);
    n2o_tank_label.setPosition(width*.24, height*.66);
    chamber_label.setPosition(width*.35, height*.85);

    n2_fill_toggle.setPosition(width*.457, height*.5);
    n2o_fill_toggle.setPosition(width*.44, height*.68);
    n2_purge_toggle.setPosition(width*.433, height*.465);
    n2o_purge_toggle.setPosition(width*.372, height*.717);
    n2_quick_dc_toggle.setPosition(width*.348, height*.52);
    n2o_quick_dc_toggle.setPosition(width*.348, height*.66);

    vent_toggle.setSize((int)(width*toggle_width), (int)(height*toggle_height));
    abort_toggle.setSize((int)(width*toggle_width), (int)(height*toggle_height));
    main_toggle.setSize((int)(width*toggle_width), (int)(height*toggle_height));
    pressurizing_toggle.setSize((int)(width*toggle_width), (int)(height*toggle_height));
    
    vent_toggle.setPosition(width*.299, height*.585);
    abort_toggle.setPosition(width*.305, height*.871);
    main_toggle.setPosition(width*.265, height*.935);
    pressurizing_toggle.setPosition(width*.265, height*.58);
    
  } 
}
