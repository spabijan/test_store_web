class HttpError implements Exception {
  final String message;

  HttpError({required this.message});
}
