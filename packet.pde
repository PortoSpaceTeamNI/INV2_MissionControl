// Packet Structure: PACKET_VERSION | SENDER_ID | TARGET_ID | COMMAND_ID | PAYLOAD HEADER (optional) | PAYLOAD
int HEADER_SIZE = 5;
int MAX_PAYLOAD_SIZE = 150;
class dataPacket {
  byte sender_id;
  byte target_id;
  byte command_id;
  byte payload_size;
  byte[] payload;
  byte crc1, crc2;

  dataPacket(byte sender_id, byte target_id, byte command_id, byte[] payload) {
    this.sender_id = sender_id;
    this.target_id = target_id;
    this.command_id = command_id;
    this.payload_size = (byte) (payload.length & 0xFF);
    this.payload = payload;
  }

  void logPacket(LogEvent event) {
    flash_log(this, event);
  }

  byte[] getPacket() {
    byte[] final_packet = new byte[HEADER_SIZE + payload.length + 2]; //2 from CRC
    int index = 0;
    final_packet[index++] = SYNC_BYTE;
    final_packet[index++] = sender_id;
    final_packet[index++] = target_id; 
    final_packet[index++] = command_id;
    final_packet[index++] = payload_size;
    for (int i = 0; i < payload.length; i++) {
      final_packet[index++] = payload[i];
    }
    // TODO: Add checksum
    final_packet[index++] = (byte)0x00;
    final_packet[index++] = (byte)0x00;
    return final_packet;
  }
}
