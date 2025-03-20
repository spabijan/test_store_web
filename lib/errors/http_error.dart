class HttpError implements Exception {

  HttpError({required this.message});
  final String message;
}
