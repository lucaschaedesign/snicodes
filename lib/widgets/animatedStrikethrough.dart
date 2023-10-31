import 'package:flutter/material.dart';

class AnimatedStrikeThrough extends StatefulWidget {
  final String title;

  const AnimatedStrikeThrough({super.key, required this.title});
  @override
  _AnimatedStrikeThroughState createState() => _AnimatedStrikeThroughState();
}

class _AnimatedStrikeThroughState extends State<AnimatedStrikeThrough>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  bool isStrikedThrough = false;
  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );

    _shakeController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 120),
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInCubic,
    );

    _shakeAnimation = CurvedAnimation(
      parent: _shakeController,
      curve: Curves.easeOutQuad,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                isStrikedThrough = !isStrikedThrough;
                if (isStrikedThrough) {
                  _controller.forward();
                  Future.delayed(Duration(milliseconds: 210), () {
                    _shakeController.forward();
                  });
                  Future.delayed(Duration(milliseconds: 430), () {
                    _shakeController.reverse();
                  });
                } else {
                  _controller.reverse();
                  _shakeController.forward();
                  _shakeController.reverse();
                }

                // _shakeController.repeat(reverse: true);
              });
            },
            child: AnimatedBuilder(
              animation: _shakeAnimation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(_shakeAnimation.value * 10, 0),
                  child: CustomPaint(
                    painter: StrikethroughPainter(_animation),
                    child: Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _shakeController.dispose();
    super.dispose();
  }
}

class StrikethroughPainter extends CustomPainter {
  final Animation<double> animation; // Update the parameter type here

  StrikethroughPainter(this.animation) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1.5;

    double strikeThroughWidth = size.width * animation.value;
    canvas.drawLine(
      Offset(0, size.height / 1.8),
      Offset(strikeThroughWidth, size.height / 1.8),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
