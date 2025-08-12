
import 'dart:math';
import 'package:flutter/material.dart';

class OrbitingAnimation extends StatefulWidget {
  const OrbitingAnimation({super.key});

  @override
  _OrbitingAnimationState createState() => _OrbitingAnimationState();
}

class _OrbitingAnimationState extends State<OrbitingAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;


  final List<String> clockwiseImagePaths = [
    'assets/icons/commando.png',
    'assets/icons/cisco.png',
    'assets/icons/juniper.png',
    'assets/icons/commando.png',
    'assets/icons/cisco.png',
    'assets/icons/juniper.png',
  ];

  final List<String> anticlockwiseImagePaths = [
    'assets/icons/switch.png',
    'assets/icons/partner.jpg',
    'assets/icons/router.jpg',
    'assets/icons/switch.png',
  ];


  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 4), // Half orbit duration
      vsync: this,
    )
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Offset _calculatePosition(double radius, double angle) {
    return Offset(radius * cos(angle), radius * sin(angle));
  }

  @override
  Widget build(BuildContext context) {
    const double innerOrbitRadius = 110;
    const double outerOrbitRadius = 180;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return SizedBox(
          width: 360,
          height: 360,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Orbit paths
              CustomPaint(
                size: const Size(360, 360),
                painter: OrbitPainter(),
              ),

              // Central glowing logo
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.6),
                      blurRadius: 25,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: const CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage('assets/icons/changelogo.png'),
                ),
              ),


// Outer orbit - clockwise motion (5 icons)
              for (int i = 0; i < clockwiseImagePaths.length; i++)
                for (int k = -1; k <= 1; k++) // Repeat icons in overlapping semicircle
                  Builder(builder: (context) {
                    final double step = pi / (clockwiseImagePaths.length - 1);
                    final double baseAngle = pi + i * step;
                    final double animatedAngle = (baseAngle + _controller.value * pi + k * pi) % (2 * pi);

                    if (sin(animatedAngle) > 0) return const SizedBox.shrink();

                    final Offset pos = _calculatePosition(outerOrbitRadius, animatedAngle);
                    return Transform.translate(
                      offset: pos,
                      child: _orbitIcon(clockwiseImagePaths[i]),
                    );
                  }),

// Inner orbit - anticlockwise motion (4 icons)
              for (int i = 0; i < anticlockwiseImagePaths.length; i++)
                for (int k = -1; k <= 1; k++)
                  Builder(builder: (context) {
                    final double step = pi / (anticlockwiseImagePaths.length - 1);
                    final double baseAngle = pi + i * step;
                    final double animatedAngle = (baseAngle - _controller.value * pi + k * pi) % (2 * pi);

                    if (sin(animatedAngle) > 0) return const SizedBox.shrink();

                    final Offset pos = _calculatePosition(innerOrbitRadius, animatedAngle);
                    return Transform.translate(
                      offset: pos,
                      child: _orbitIcon(anticlockwiseImagePaths[i]),
                    );
                  }),

            ],
          ),
        );
      },
    );
  }


  Widget _orbitIcon(String imagePath) {
    return Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.blueAccent.withOpacity(0.5),
            // Keep glow blue or adjust as needed
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Image.asset(
          imagePath,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

  class OrbitPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint orbitPaint = Paint()
      ..color = Colors.blueGrey.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final Offset center = Offset(size.width / 2, size.height / 2);

    final Rect innerRect = Rect.fromCircle(center: center, radius: 110);
    final Rect outerRect = Rect.fromCircle(center: center, radius: 180);

    canvas.drawArc(innerRect, pi, pi, false, orbitPaint);
    canvas.drawArc(outerRect, pi, pi, false, orbitPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
