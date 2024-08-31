import 'package:events_emitter/emitters/event_emitter.dart';
import 'package:events_emitter/events_emitter.dart';


class Events{
  static final EventEmitter _events = EventEmitter();

  static void emit({ required String event, dynamic data }){
    _events.emit(event, data);
  }

  static void registerListener({ required String key, required void Function() callback, bool once = false }){
    print("registered");
    EventListener l = EventListener(key, (dynamic data) => callback(), once: once);
    _events.addEventListener(l);
  }

  static void detachListener(String key){
    try{
      EventListener listener = _events.listeners.firstWhere((el) => el.type == key);
      _events.removeEventListener(listener);
    }on StateError catch (e){
      print("Listener does not exist");
    }
  }


}
