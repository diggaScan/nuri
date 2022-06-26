import 'package:event_bus/event_bus.dart';

class Dispatcher{

  Dispatcher._(){
    eventBus=EventBus();
  }

  static  Dispatcher? _dispatcher;
 late EventBus eventBus;
  factory Dispatcher(){
    _dispatcher??=Dispatcher._();
    return _dispatcher!;
  }


  


}