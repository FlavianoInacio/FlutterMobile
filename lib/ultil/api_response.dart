class ApiResponse<T>{
  bool ok;
  String mensagem;
  T results;

  ApiResponse.ok({this.results}){
    ok = true;
  }

  ApiResponse.error(this.mensagem){
    ok = false;
  }
}