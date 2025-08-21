void setupCharts() {
  fillingChart.addDataSet("Pressure");
  fillingChart.addDataSet("Temperature");
  fillingChart.addDataSet("Weight");

  launchChart.addDataSet("Altitude");
  launchChart.addDataSet("Velocity");
  launchChart.addDataSet("Acceleration");
  launchChart.addDataSet("Pressure");
  launchChart.addDataSet("zero");

  fillingChart.setColors("Pressure", color(0, 255, 0));
  fillingChart.setColors("Temperature", color(255, 150, 255));
  fillingChart.setColors("Weight", color(0, 255, 255));

  launchChart.setColors("Altitude", color(255, 0, 255));
  launchChart.setColors("Velocity", color(255, 255, 0));
  launchChart.setColors("Acceleration", color(255, 150, 150));
  launchChart.setColors("Pressure", color(0, 255, 0));
  launchChart.setColors("zero", color(255, 255, 255));

  pressureLabel = cp5.addLabel("Pressure: ")
    .setColor(color(0, 255, 0))
    .setFont(font)
    .moveTo("global")
    .setPosition(width*.63, height*.16)
    .setSize((int)(width*.1), (int)(height*.1))
    .hide()
    ;
  temperatureLabel = cp5.addLabel("Temperature: ")
    .setColor(color(255, 150, 255))
    .setFont(font)
    .moveTo("filling")
    .setPosition(width*.63, height*.20)
    .setSize((int)(width*.1), (int)(height*.1))
    ;
  weightLabel = cp5.addLabel("Weight: ")
    .setColor(color(0, 255, 255))
    .setFont(font)
    .moveTo("filling")
    .setPosition(width*.63, height*.28)
    .setSize((int)(width*.1), (int)(height*.1))
    ;

  altitudeLabel = cp5.addLabel("Altitude: ")
    .setColor(color(255, 0, 255))
    .setFont(font)
    .moveTo("launch")
    .setPosition(width*.63, height*.25)
    .setSize((int)(width*.1), (int)(height*.1))
    ;
  velocityLabel = cp5.addLabel("Velocity: ")
    .setColor(color(255, 255, 0))
    .setFont(font)
    .moveTo("launch")
    .setPosition(width*.63, height*.19)
    .setSize((int)(width*.1), (int)(height*.1))
    ;
  accelerationLabel = cp5.addLabel("Acceleration: ")
    .setColor(color(255, 150, 150))
    .setFont(font)
    .moveTo("launch")
    .setPosition(width*.63, height*.22)
    .setSize((int)(width*.1), (int)(height*.1))
    ;
}

void updateCharts() {
  // filling chart
  float fp = float(hydra_lf.tank_pressure) * .01,
    ft = float(hydra_lf.probe_thermo3) * .1,
    fw = float(lift_fs.n2o_loadcell);

  fillingChart.addData("Pressure", fp);
  fillingChart.addData("Temperature", ft);
  fillingChart.addData("Weight", -fw);

  max_f = max(max_f, fp);
  max_f = max(max_f, ft);
  max_f = max(max_f, fw);

  fillingChart.setRange(0, max_f*1.3);

  pressureLabel.setText("Pressure: " + df.format(fp));
  temperatureLabel.setText("Temperature: " + df.format(ft));
  weightLabel.setText("Weight: " + df.format(fw));

  // launch chart
  float lalt = float(nav.kalman.altitude) * .1,
    lvel = float(nav.kalman.velocity_z) * .1,
    lacel = float(nav.kalman.acceleration_z) * .1;

  launchChart.addData("Altitude", lalt);
  launchChart.addData("Velocity", lvel);
  launchChart.addData("Acceleration", lacel);
  launchChart.addData("Pressure", fp);
  launchChart.addData("zero", 0);

  max_l = max(max_l, lalt);
  max_l = max(max_l, lvel);
  max_l = max(max_l, lacel);
  max_l = max(max_l, fp);

  min_l = min(min_l, lalt);
  min_l = min(min_l, lvel);
  min_l = min(min_l, lacel);
  min_l = min(min_l, fp);

  altitudeLabel.setText("Altitude: " + df.format(lalt));
  velocityLabel.setText("Velocity: " + df.format(lvel));
  accelerationLabel.setText("Acceleration: " + df.format(lacel));

  launchChart.setRange(min_l*1.3, max_l*1.3);
}
