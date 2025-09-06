import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}

// Paste this part below as well ↓↓↓
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Shader _createSweepShader(Rect bounds, double value) {
    return LinearGradient(
      begin: Alignment(-1.0 + value * 2, 0),
      end: Alignment(1.0 + value * 2, 0),
      colors: [
        Colors.transparent,
        Colors.white.withOpacity(0.3),
        Colors.transparent,
      ],
      stops: const [0.3, 0.5, 0.7],
    ).createShader(bounds);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0, 0),
            radius: 1.0,
            colors: [
              Color(0xFF0B1E34),
              Colors.black,
            ],
          ),
        ),
        child: Center(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return ShaderMask(
                shaderCallback: (bounds) =>
                    _createSweepShader(bounds, _controller.value),
                blendMode: BlendMode.srcATop,
                child: RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 40,
                      fontWeight: FontWeight.w600,
                    ),
                    children: [
                      TextSpan(
                        text: 'Welcome to ',
                        style: TextStyle(color: Colors.white),
                      ),
                      TextSpan(
                        text: 'Memora!',
                        style: TextStyle(color: Color(0xFF1766B0)),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
