import 'package:flutter/material.dart';

class SingleDigit extends StatefulWidget {
  final TextStyle textStyle;
  final BoxDecoration boxDecoration;

  final int value;

  _SingleDigitState _state;

  SingleDigit(
      {this.boxDecoration: const BoxDecoration(color: Colors.white),
      this.textStyle: const TextStyle(color: Colors.blue, fontSize: 40,fontStyle: FontStyle.italic),
      this.value});

  @override
  State<StatefulWidget> createState() {
    _state = new _SingleDigitState();
    return _state;
  }

  setValue(newValue) {
    if (_state != null) {
      _state._setValue(newValue);
    }
  }
}

class _SingleDigitState extends State<SingleDigit>
    with TickerProviderStateMixin {
  int previousValue;
  int currentValue;

  Animation<double> animation;
  AnimationController controller;

  @override
  void didUpdateWidget(covariant SingleDigit oldWidget) {
    // TODO: implement didUpdateWidget
    // _setValue(widget.value.toInt());
    // print("didUpdateWidget ");
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();
    _setValue(widget.value);
    // _setValue(widget.value.toInt());
  }

  _initAnimation() {
    controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    animation = Tween<double>(
            begin: previousValue != null ? previousValue.toDouble() : 0.0,
            end: currentValue != null ? currentValue.toDouble() : 0.0)
        .animate(controller)
          ..addListener(() {
            setState(() {});
          });
    controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  _setValue(int newValue) {
    this.previousValue = this.currentValue;
    this.currentValue = newValue;
    controller?.dispose();
    _initAnimation();
    // if (newValue != null) {
    //
    //
    // }

  }

  @override
  Widget build(BuildContext context) {
    final Size digitSize = _getSingleDigitSize();

    return Container(
      decoration: widget.boxDecoration,
      child: SizedOverflowBox(
        alignment: Alignment.topCenter,
        size: digitSize,
        child: ClipRect(
          clipper: CustomDigitClipper(digitSize),
          child: currentValue != null
              ? Transform.translate(
                  offset: Offset(0, -this.animation.value * digitSize.height),
                  child: Column(
                    children: <Widget>[
                      for (var i = 0; i < 10; i++)
                        Text(i.toString(), style: widget.textStyle)
                      // ADD STYLE TO THE TEXT
                    ],
                  ),
                )
              : Container(),
        ),
      ),
    );
  }

  ///
  /// Calculates the size of a single digit based on the current text style
  ///
  _getSingleDigitSize() {
    final painter = TextPainter();
    painter.text = TextSpan(style: widget.textStyle, text: '0');
    painter.textDirection = TextDirection.ltr;
    painter.textAlign = TextAlign.left;
    painter.textScaleFactor = 1.0;
    painter.layout();
    return painter.size;
  }
}

class CustomDigitClipper extends CustomClipper<Rect> {
  CustomDigitClipper(this.digitSize);

  final Size digitSize;

  @override
  Rect getClip(Size size) {
    return Rect.fromPoints(
        Offset.zero, Offset(digitSize.width, digitSize.height));
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return false;
  }
}
