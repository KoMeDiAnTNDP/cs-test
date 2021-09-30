const String localHost = 'http://127.0.0.1';
const String androidEmulatorLocalhost = 'http://10.0.2.2'; // Local address on the Android emulator that routes to the host machine

const String serverPort = '9000'; // Local server port

String getAPIUrl() {
  return '$androidEmulatorLocalhost:$serverPort';
}