class HttpException implements Exception {
  final String message;
  HttpException(this.message);

  @override
  String toString() {
    //message from Http Exception
    return message;
  }
}
