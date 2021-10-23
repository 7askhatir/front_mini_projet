class ApiResopnse<T>{
  T data;
  bool err;
  String status;

  ApiResopnse({required this.data,required this.err,required this.status});
}