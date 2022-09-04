import 'dart:async';
import 'package:flutter/foundation.dart';

class SpecFunction {
  Timer? _debounce;

  /// 防抖方法，[time] ms 内触发的 [fn] 方法都会被取消
  xuDebounce(VoidCallback fn, {int time = 600}) {
    // 还在时间之内，抛弃上一次
    if (_debounce?.isActive ?? false) {
      _debounce!.cancel();
    }

    _debounce = Timer(Duration(milliseconds: time), fn);
  }

  bool _enable = true;
  Map<String, bool> _funcThrottle = {};

  /// 节流方法，[time] ms 内触发的 [fn] 方法都会被取消
  xuThrottle(VoidCallback fn, {int time = 500, String key = ''}) {
    if (key.isNotEmpty) {
      var status = _funcThrottle[key] ?? true;
      if (!status) return;
    }
    // 还在时间之内，抛弃上一次
    if (!_enable) {
      return;
    }
    Future Function() hangOn = () async {
      if (key.isNotEmpty) {
        _funcThrottle[key] = false;
      } else {
        _enable = false;
      }
      fn();
      await Future.delayed(Duration(milliseconds: time));
    };

    hangOn().then((value) {
      if (key.isNotEmpty) {
        _funcThrottle[key] = true;
      } else {
        _enable = true;
      }
    }).whenComplete(() {
      if (key.isNotEmpty) {
        _funcThrottle.remove(key);
      } else {
        _enable = true;
      }
    });
  }
}
