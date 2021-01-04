import 'dart:async';

class BlocSimple<T>{
  final _streamController = StreamController<T>.broadcast();

  Stream<T> get fetch => _streamController.stream;

  void add(T object){
    _streamController.add(object);
  }
  void addError(Object error){
    _streamController.addError(error);
  }
  void dispose(){
    _streamController.close();
  }
}