// Packet Structure: PACKET_VERSION | SENDER_ID | TARGET_ID | COMMAND_ID | PAYLOAD HEADER (optional) | PAYLOAD
int PACKET_SIZE = 128; // Packet size is constant

class dataPacket {
  byte version;
  byte sender_id;
  byte target_id;
  byte command_id;
  byte[] payload;

  dataPacket(byte sender_id, byte target_id, byte command_id, byte[] payload) {
    this.sender_id = sender_id;
    this.target_id = target_id;
    this.command_id = command_id;
    this.payload = payload;
  }

  void logPacket(LogEvent event) {
    flash_log(this, event);
  }

  byte[] getPacket() {
    byte[] final_packet = new byte[128];
    final_packet[0] = PACKET_VERSION;
    final_packet[1] = sender_id;
    final_packet[2] = target_id; 
    final_packet[3] = command_id;
    for (int i = 0; i < payload.length; i++) {
      final_packet[i+4] = payload[i];
    }
    return final_packet;
  }
}
