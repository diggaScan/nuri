import 'package:flutter/cupertino.dart';
import 'package:nuri/ui_theme/ui_color.dart';

class EffectGesture extends StatefulWidget {
  final Widget? child;
  final Color? backgroundColor;
  final BorderRadius? radius;
  final VoidCallback? onTap;

  const EffectGesture(
      {Key? key,
      this.backgroundColor = UiColor.black,
      this.child,
      this.onTap,
      this.radius})
      : super(key: key);

  @override
  _YlTapEffectState createState() => _YlTapEffectState();
}

class _YlTapEffectState extends State<EffectGesture> {
  bool _tappingDown = false;

  @override
  Widget build(BuildContext context) {
    var tappedCoverColor =
        (widget.backgroundColor ?? UiColor.black).withOpacity(0.1);

    return TapDetector(
      onTap: widget.onTap,
      onTapDown: () {
        if (widget.onTap != null) {
          setState(() {
            _tappingDown = true;
          });
        }
      },
      onTapUp: () {
        if (widget.onTap != null) {
          setState(() {
            _tappingDown = false;
          });
        }
      },
      child: Stack(
        children: [
          widget.child!,
          Visibility(
            visible: _tappingDown,
            child: Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: widget.radius, color: tappedCoverColor),
                )),
          )
        ],
      ),
    );
  }
}


// ignore: must_be_immutable
class TapDetector extends StatelessWidget {
  final Widget child;
  final int count;
  final VoidCallback? onTap;
  final VoidCallback? onTapDown;
  final VoidCallback? onTapUp;

  final int _tapDuration = 500;

  int _lastTapTime = 0;
  int _tapCount = 0;

  TapDetector(
      {Key? key,
      required this.child,
      this.count = 1,
      this.onTap,
      this.onTapDown,
      this.onTapUp})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: child,
      onTap: () {
        var now = DateTime.now().millisecondsSinceEpoch;
        if (_lastTapTime + _tapDuration < now) {
          _tapCount = 0;
        }

        _lastTapTime = now;
        _tapCount++;

        if (onTap != null && _tapCount == count) {
          onTap!();
        }
      },
      onTapDown: (_) {
        if (onTapDown != null) {
          onTapDown!();
        }
      },
      onTapCancel: () {
        if (onTapUp != null) {
          onTapUp!();
        }
      },
      onTapUp: (_) {
        if (onTapUp != null) {
          onTapUp!();
        }
      },
    );
  }
}
