import 'package:flutter/material.dart';
import 'package:ft_hint_bubbles/extensions/build_context_extensions.dart';

class HintBubbler extends StatefulWidget {
  const HintBubbler({
    super.key,
    this.distance = 5,
    this.margin = 20,
    this.maxWidth = 500,
    this.showHint = false,
    required this.child,
  });

  final Alignment alignment = Alignment.topRight;
  final double distance;
  final double margin;
  final double maxWidth;
  final bool showHint;
  final Widget child;

  @override
  State<HintBubbler> createState() => _HintBubblerState();
}

class _HintBubblerState extends State<HintBubbler> {
  Rect? _elementBounds;

  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 500), () {
      // open overlay
    });
    super.initState();
  }

  void _displayBubble() {
    if (_elementBounds == null) {
      return;
    }

    if (_overlayEntry != null) {
      _overlayEntry!.remove();
    }

    // final bubbleRect = Rect.fromPoints(
    //   Offset(
    //       widget.margin,
    //       ,
    //   Offset(),
    // );

    print(widget.alignment.y);

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          top: _elementBounds!.center.dy +
              widget.alignment.y *
                  (_elementBounds!.height / 2 + widget.distance),
          left: _elementBounds!.left - widget.margin,
          right: MediaQuery.of(context).size.width -
              (_elementBounds!.right -
                      (_elementBounds!.width / 2) * widget.alignment.x)
                  .ceil(),
          height: _elementBounds?.height,
          child: Material(
            child: Container(
              color: Colors.amber,
              child: Text("Overlayed"),
            ),
          ),
        );
      },
    );
    Overlay.of(context)?.insert(_overlayEntry!);
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      _elementBounds = context.globalPaintBounds;
      _displayBubble();
    });

    return Container(
      child: widget.child,
    );
  }
}
