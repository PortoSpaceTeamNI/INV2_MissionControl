// Packet Structure: START BYTE(0x55) | PACKET_VERSION | COMMAND | TARGET_ID | SENDER_ID | PAYLOAD LENGTH | H_CRC | PAYLOAD | CRC1 | CRC2

class dataPacket {
  final byte START_BYTE = (byte)0x55;
  final byte PACKET_VERSION = (byte)0x01;
  byte command;
  byte sender_id;
  byte target_id;
  byte payloadLength;
  byte h_crc;
  byte[] payload;
  byte crc1;
  byte crc2;

  dataPacket(byte command, byte target_id, byte sender_id, byte[] payload) {
    this.command = command;
    this.payload = payload;
    this.payloadLength = (byte)payload.length;
    this.target_id = target_id;
    this.sender_id = sender_id;
    this.h_crc = (byte) 0x00;
  }

  void logPacket(LogEvent event) {
    flash_log(this, event);
  }

  byte[] getPacket() {
    byte[] finalPacket = {START_BYTE, PACKET_VERSION, command, sender_id, target_id, payloadLength, h_crc};
    for (int i = 0; i < payloadLength; i++) {
      finalPacket = append(finalPacket, payload[i]);
    }
    int result = crc(finalPacket);
    byte crc2 = (byte) (result & 0xFF);
    byte crc1 = (byte) ((result >> 8) & 0xFF);
    finalPacket = append(finalPacket, crc1);
    finalPacket = append(finalPacket, crc2);
    return finalPacket;
  }
}
