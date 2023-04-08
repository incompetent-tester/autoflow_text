import 'package:flutter/material.dart';

class AutoFlowText extends StatefulWidget {
  final String text;

  final Duration? scrollDelay;
  final Duration? scrollDuration;

  const AutoFlowText({
    super.key,
    required this.text,
    this.scrollDelay,
    this.scrollDuration,
  });

  @override
  State<StatefulWidget> createState() => _AutoFlowTextState();
}

class _AutoFlowTextState extends State<AutoFlowText> with SingleTickerProviderStateMixin {
  final _scrollCtrl = ScrollController();

  late AnimationController _animationCtrl;
  late Animation<double> _animation;
  var _showFade = false;

  @override
  void initState() {
    super.initState();

    assert(
      (widget.scrollDelay == null && widget.scrollDuration == null) || (widget.scrollDelay != null && widget.scrollDuration != null),
      "Both scrollDelay and scrollDuration must be provided",
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.scrollDelay != null && widget.scrollDuration != null) {
        _animationCtrl = AnimationController(vsync: this, duration: widget.scrollDuration);
        _animation = Tween<double>(begin: 0, end: 1).animate(_animationCtrl)
          ..addListener(
            () {
              _scrollCtrl.jumpTo(_animation.value * _scrollCtrl.position.maxScrollExtent);
            },
          );

        _animationCtrl.forward();

        _animation.addStatusListener((status) {
          switch (status) {
            case AnimationStatus.completed:
              Future.delayed(widget.scrollDelay!, () {
                _animationCtrl.reverse();
              });
              break;
            case AnimationStatus.dismissed:
              Future.delayed(widget.scrollDelay!, () {
                _animationCtrl.forward();
              });
              break;
            default:
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: (evt) {
        if (evt is OverscrollIndicatorNotification) {
          evt.disallowIndicator();
        }

        if (_scrollCtrl.position.atEdge && _scrollCtrl.offset > 0) {
          _showFade = false;
        } else {
          _showFade = true;
        }

        setState(() {});
        return true;
      },
      child: ShaderMask(
        shaderCallback: (Rect rect) {
          return LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Colors.black,
              Colors.black,
              _showFade ? Colors.transparent : Colors.black,
            ],
            stops: const [
              0.0,
              0.9,
              1.0
            ],
          ).createShader(rect);
        },
        blendMode: BlendMode.dstIn,
        child: SingleChildScrollView(
          controller: _scrollCtrl,
          scrollDirection: Axis.horizontal,
          child: Text(widget.text),
        ),
      ),
    );
  }
}
