import java.util.BitSet;

enum ParseState {
    VERSION,
    SENDER_ID,
    TARGET_ID,
    COMMAND_ID,
    PAYLOAD,
};

void serialThread() {
  myPort = new Serial(this, selectedPort, baudRate);
  port_selected = true;
  myPort.clear();
  while (port_selected) {
    while (myPort.available() > 0) {
      byte rx_byte = (byte) myPort.read();
      parseIncomingByte(rx_byte);
    }

    // Send packets in queue
    dataPacket head = tx_queue.peek();
    if (millis() - last_cmd_sent_time > packet_loss_timeout) {
      if (head != null) {
        myPort.write(head.getPacket());
        last_cmd_sent_time = millis();
        if (last_cmd_sent != (byte)0xff) {
          ack_packet_loss++;
        }
        last_cmd_sent = head.command_id;
        if (history_deque.size() == history_capacity) {
          history_deque.removeFirst();
        }
        history_deque.addLast("CMD -> " + Command.values()[last_cmd_sent]);
        String history_string = "";
        for (String element : history_deque) {
          history_string += element + "\n";
        }
        history.setText("History: \n" + history_string);
        tx_queue.remove();
      }
    }
  }
}

void parseIncomingByte(byte rx_byte) {
  print((char)rx_byte);
  if (last_read_time == 0 || millis() - last_read_time > packet_read_timeout) {
    currentParseState = ParseState.VERSION;
  }
  last_read_time = millis();
  switch(currentParseState) {
    case VERSION:
      rx_packet.version = rx_byte;
      currentParseState = ParseState.VERSION;
      break;
    case SENDER_ID:
      rx_packet.sender_id = rx_byte;
      currentParseState = ParseState.TARGET_ID;
      break;
    case TARGET_ID:
      rx_packet.target_id = rx_byte;
      currentParseState = ParseState.COMMAND_ID;
      break;
    case COMMAND_ID:
      rx_packet.command_id = rx_byte;
      currentParseState = ParseState.PAYLOAD;
      rx_payload_index = 0;
      break;
    case PAYLOAD:
      rx_payload[rx_payload_index] = rx_byte;
      rx_payload_index++;
      if (rx_payload_index >= 124) {
        currentParseState = ParseState.VERSION;
      }
      break;
  }
}

void processPacket() {
  //println();
  //println(rx_packet.getPacket());
  rx_packet.logPacket(LogEvent.MSG_RECEIVED);
  if (rx_packet.command_id == Command.STATUS_REP.ordinal()) {
    updateData(rx_packet.payload);
  } else if (rx_packet.command_id == Command.ACK.ordinal()) {
    displayAck(rx_packet);
  }
}

void updateLogStats(int id) {
  if (last_received_log_id == id) {
    log_packet_loss++;
  }
  if (id == 1) {
    int r_log_interval = millis() - last_r_log_time;
    last_r_log_time = millis();
    r_log_rate = 1000.00 / r_log_interval;
    last_received_log_id = 1;
  } else if (id == 2) {
    int f_log_interval = millis() - last_f_log_time;
    last_f_log_time = millis();
    f_log_rate = 1000.00 / f_log_interval;
    last_received_log_id = 2;
  }

  log_stats.setText("Rocket Log Rate: " + String.format("%.2f", r_log_rate) + "\nFilling Log Rate: " + String.format("%.2f", f_log_rate) + "\nLog Packets Lost: " + log_packet_loss + "\nAck Packets Lost: " + ack_packet_loss);
}

void updateLogStats() {
  log_stats.setText("Rocket Log Rate: " + String.format("%.2f", r_log_rate) + "\nFilling Log Rate: " + String.format("%.2f", f_log_rate) + "\nLog Packets Lost: " + log_packet_loss + "\nAck Packets Lost: " + ack_packet_loss);
}

void updateData(byte[] payload) {
  obc.state = RocketState.values()[payload[0]];
}
void displayAck(dataPacket rx_packet) {
  byte ack_cmd_id = rx_packet.payload[0];
  Command ack_cmd = Command.values()[ack_cmd_id];
  String ack_name = ack_cmd.name();
  if (ack_cmd_id != last_cmd_sent) {
    ack_packet_loss++;
    updateLogStats();
  }
  last_cmd_sent = (byte) Command.NONE.ordinal();
  ack_display.setText("Last Ack Received: \n" + ack_name);
  if (history_deque.size() == history_capacity) {
    history_deque.removeFirst();
  }
  history_deque.addLast("Ack <- " + ack_name);
  String history_string = "";
  for (String element : history_deque) {
    history_string += element + "\n";
  }
  history.setText("History: \n" + history_string);
}

void send(byte command, byte[] payload) {
  /*
  if (targetID == 0) {
    print("No ID selected\n");
    return;
  }
  */
  //println(command, payload);
  /*
  if (targetID == 4) {
    targetID = (byte)0xFF;
  }
  */
  tx_packet = new dataPacket(My_ID, targetID, command, payload);
  tx_packet.logPacket(LogEvent.MSG_SENT);
  if (myPort != null) {
    //byte[] packet = tx_packet.getPacket();
    //for(byte b : packet) {
    //println(hex(b));
    //}
    //println();
    //println(tx_packet.getPacket());
    tx_queue.add(tx_packet);
  } else {
    println("No serial port selected!");
  }
}

//float calc_n2o_loss() {
//  if (tank_mol_loss > he_mol) {
//    return (((tank_mol_loss - he_mol) * .1) * 44.012);
//  } else {
//    return 0.0;
//  }
//}

short createAskDataMask(AskData[] asks) {
  short mask = 0;
  for (AskData ask : asks) {
    mask |= (1 << ask.ordinal());
  }
  return mask;
}

void auto_status() {
  if (millis() - last_status_time > status_interval && status_toggle_state == 1) {
    request_status();
    last_status_time = millis();
  }
}

void request_status() {
  send((byte)Command.STATUS_REQ.ordinal(), empty_payload);
}

enum AskData {
  rocket_flags_state,
    tank_pressures,
    tank_temps,
    gps_data,
    barometer_altitude,
    imu_data,
    kalman_data,
    parachutes_ematches,
    fill_station_state,
    fill_pressures,
    fill_temps,
    nitro_loadcell,
    ignition_station_state,
    chamber_trigger_temp,
    main_ematch,
};
