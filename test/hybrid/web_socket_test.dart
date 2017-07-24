@TestOn("browser")

import "dart:html";

import "package:test/test.dart";

void main() {
  test("connects to a server-side WebSocket", () async {
    // Each spawnHybrid function returns a StreamChannel that communicates with
    // the hybrid isolate. You can close this channel to kill the isolate.
    var channel = spawnHybridUri("web_socket_server.dart");

    // Get the port for the WebSocket server from the hybrid isolate.
    var port = await channel.stream.first;

    var socket = new WebSocket('ws://localhost:$port');
    var message = await socket.onMessage.first;
    expect(message.data, equals("hello!"));
  });
}