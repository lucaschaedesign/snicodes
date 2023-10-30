import 'package:flutter/material.dart';

class AnimatedCheckboxListItem extends StatefulWidget {
  final Color color;
  final double intensity;
  final String title;

  AnimatedCheckboxListItem({
    required this.color,
    this.intensity = 1.0,
    required this.title,
  });

  @override
  _AnimatedCheckboxListItemState createState() =>
      _AnimatedCheckboxListItemState();
}

class _AnimatedCheckboxListItemState extends State<AnimatedCheckboxListItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool isDone = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isDone = !isDone;
          if (isDone) {
            _animationController.forward();
          } else {
            _animationController.reverse();
          }
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  children: [
                    SizedBox(
                      height: 2.0, // Height of the line-through effect
                      child: CustomPaint(
                        size:
                            Size(constraints.maxWidth * _animation.value, 2.0),
                        painter: StrikeThroughPainter(color: widget.color),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        widget.title,
                        style: TextStyle(
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class StrikeThroughPainter extends CustomPainter {
  final Color color;

  StrikeThroughPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2.0;

    final Offset start = Offset(0, size.height / 2);
    final Offset end = Offset(size.width, size.height / 2);

    canvas.drawLine(start, end, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
