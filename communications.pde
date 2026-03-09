import java.util.BitSet;

enum ParseState {
SYNC,
SENDER_ID,
TARGET_ID,
CMD,
PAYLOAD_SIZE,
PAYLOAD,
CRC1, // first byte of crc
CRC2, // second byte of crc
};

dataPacket new_packet;

void serialThread() {
myPort = new Serial(this, selectedPort, baudRate); 
port_selected = true;
myPort.clear();
while(port_selected) {
    while(myPort.available() > 0) {
        byte rx_byte = (byte)myPort.read();
        parseIncomingByte(rx_byte);
    }
    
    // Send packets in queue
    dataPacket head = tx_queue.peek();
    if (millis() - last_cmd_sent_time > packet_loss_timeout) {
        if (head != null) {
            println(head.getPacket());
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
if (last_read_time == 0 || millis() - last_read_time > packet_read_timeout) {
    currentParseState = ParseState.SYNC;
}
last_read_time = millis();
switch(currentParseState) {
    case SYNC:
        if (rx_byte == SYNC_BYTE) {
            currentParseState = ParseState.SENDER_ID;
        }
        break;
    case SENDER_ID:
        new_packet.sender_id = rx_byte;
        currentParseState = ParseState.TARGET_ID;
        break;
    case TARGET_ID:
        new_packet.target_id = rx_byte;
        if(new_packet.target_id == MyID) {
            currentParseState = ParseState.CMD;
        } else {
            currentParseState = ParseState.SYNC;
        }
        break;
    case CMD:
        new_packet.command_id = rx_byte;
        currentParseState = ParseState.PAYLOAD_SIZE;
        break;
    case PAYLOAD_SIZE:
        new_packet.payload_size = rx_byte;
        if(new_packet.payload_size > 0) {
          currentParseState = ParseState.PAYLOAD;
          rx_payload_index = 0;
        } else {
          currentParseState = ParseState.CRC1;
        }
        break;
    case PAYLOAD:
        rx_payload[rx_payload_index] = rx_byte;
        rx_payload_index++;
        if (rx_payload_index >= new_packet.payload_size) {
            new_packet.payload = new byte[new_packet.payload_size];
            for(int i = 0; i < rx_payload_index; i++) {
                new_packet.payload[i] = rx_payload[i];
            }
            currentParseState = ParseState.CRC1;
        }
        break;
    case CRC1:
        new_packet.crc1 = rx_byte;
        currentParseState = ParseState.CRC2;
        break;
    case CRC2:
        new_packet.crc2 = rx_byte;
        currentParseState = ParseState.SYNC;
        //println(new_packet.getPacket());
        processPacket();
        break;
    default:
    println("Parse state notvalid");
}
}

void processPacket() {
rx_packet = new_packet;

println(rx_packet.getPacket());
// println();

rx_packet.logPacket(LogEvent.MSG_RECEIVED);
if (rx_packet.command_id == Command.ACK.ordinal()) {
    if(rx_packet.payload[0] == Command.STATUS.ordinal()) {
        
        updateData(rx_packet.payload); 
    }
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
    int index = 1; // first byte is for ack cmd

    last_r_ping = millis();
    if(payload.length < 36) { // this value is hardcoded, check any time payload is updated
      println("PAYLOAD SIZE MAY OVERFLOW"); 
    }
    obc.state = State.values()[payload[index++]];
    
    short flags = ByteBuffer.wrap(Arrays.copyOfRange(payload, index, index + 2)).getShort();
    index += 2;
    
    hydra_uf.pressurizing_valve = (flags & (0x01 << 0 )) != 0 ? true : false;
    hydra_uf.vent_valve = (flags & (0x01 << 1 )) != 0 ? true : false;
    hydra_lf.abort_valve = (flags & (0x01 << 2 )) != 0 ? true : false;
    hydra_lf.main_valve = (flags & (0x01 << 3)) != 0 ? true : false;
    
    hydra_fs.n2o.fill_valve = (flags & (0x01 << 4)) != 0 ? true : false;
    hydra_fs.n2o.purge_valve = (flags & (0x01 << 5)) != 0 ? true : false;
    hydra_fs.n2.fill_valve = (flags & (0x01 << 6)) != 0 ? true : false;
    hydra_fs.n2.purge_valve = (flags & (0x01 << 7)) != 0 ? true : false;
    
    lift_r.main_ematch = (flags & (0x01 << 8)) != 0 ? true : false;
    elytra.drogue_chute_ematch = (flags & (0x01 << 9)) != 0 ? true : false;
    elytra.main_chute_ematch = (flags & (0x01 << 10)) != 0 ? true : false;
    
    hydra_fs.quick_dc.n2o_valve = (flags & (0x01 << 11)) != 0 ? true : false;
    hydra_fs.quick_dc.n2_valve = (flags & (0x01 << 12)) != 0 ? true : false;
    
    hydra_lf.tank_pressure = ByteBuffer.wrap(Arrays.copyOfRange(payload, index, index + 2)).getShort();
    index += 2;
    hydra_lf.chamber_pressure = ByteBuffer.wrap(Arrays.copyOfRange(payload, index, index + 2)).getShort();
    index += 2;
    hydra_fs.n2o.pressure = ByteBuffer.wrap(Arrays.copyOfRange(payload, index, index + 2)).getShort();
    index += 2;
    hydra_fs.n2.pressure = ByteBuffer.wrap(Arrays.copyOfRange(payload, index, index + 2)).getShort();
    index += 2;
    hydra_fs.quick_dc.pressure = ByteBuffer.wrap(Arrays.copyOfRange(payload, index, index + 2)).getShort();
    index += 2;
    
    hydra_uf.probe_thermo1 = ByteBuffer.wrap(Arrays.copyOfRange(payload, index, index + 2)).getShort();
    index += 2;
    hydra_uf.probe_thermo2 = ByteBuffer.wrap(Arrays.copyOfRange(payload, index, index + 2)).getShort();
    index += 2;
    hydra_uf.probe_thermo3 = ByteBuffer.wrap(Arrays.copyOfRange(payload, index, index + 2)).getShort();
    index += 2;
    hydra_lf.probe_thermo1 = ByteBuffer.wrap(Arrays.copyOfRange(payload, index, index + 2)).getShort();
    index += 2;
    hydra_lf.probe_thermo2 = ByteBuffer.wrap(Arrays.copyOfRange(payload, index, index + 2)).getShort();
    index += 2;
    hydra_lf.chamber_temperature = ByteBuffer.wrap(Arrays.copyOfRange(payload, index, index + 2)).getShort();
    index += 2;
    hydra_fs.n2o.temperature = ByteBuffer.wrap(Arrays.copyOfRange(payload, index, index + 2)).getShort();
    index += 2;
    
    lift_fs.n2o_loadcell = ByteBuffer.wrap(Arrays.copyOfRange(payload, index, index + 2)).getShort();
    index += 2;
    lift_r.loadcell1 = ByteBuffer.wrap(Arrays.copyOfRange(payload, index, index + 2)).getShort();
    index += 2;
    lift_r.loadcell2 = ByteBuffer.wrap(Arrays.copyOfRange(payload, index, index + 2)).getShort();
    index += 2;
    lift_r.loadcell3 = ByteBuffer.wrap(Arrays.copyOfRange(payload, index, index + 2)).getShort();
    index += 2;
    
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
last_cmd_sent = (byte)0xFF;
}

void send(byte command, byte[] payload) {
tx_packet = new dataPacket(myID, obcID, command, payload);
tx_packet.logPacket(LogEvent.MSG_SENT);
if (myPort != null) {
    tx_queue.add(tx_packet);
} else {
    println("No serial port selected!");
}
}

void auto_status() {
if (millis() - last_status_time > status_interval && status_toggle_state == 1) {
    request_status();
    last_status_time = millis();
}
}

void request_status() {
  send((byte)Command.STATUS.ordinal(), empty_payload);
}
