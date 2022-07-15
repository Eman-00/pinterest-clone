

class ErrorMessageHandler {
  late String message;

  ErrorMessageHandler(String msg) {
    message = msg.replaceAll(RegExp(r'-'), ' ')
      .replaceFirst(msg[0], msg[0].toUpperCase());
  }
}