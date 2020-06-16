class HttpException implements Exception{
   String message;
  HttpException(this.message);

  @override
  String toString() {
    
    return this.message;
  }
}