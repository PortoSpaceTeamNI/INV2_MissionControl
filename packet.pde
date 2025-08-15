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
    final_packet = append(final_packet, PACKET_VERSION);
    final_packet = append(final_packet, sender_id);
    final_packet = append(final_packet, target_id);
    final_packet = append(final_packet, command_id);
    for (int i = 0; i < payload.length; i++) {
      final_packet = append(final_packet, payload[i]);
    }
    return final_packet;
  }
}
