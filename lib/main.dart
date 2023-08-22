import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF401318), // Cor de fundo
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ColorChangingLogo(),
            SizedBox(height: 20),
            Text(
              'Site em Construção',
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class ColorChangingLogo extends StatefulWidget {
  @override
  _ColorChangingLogoState createState() => _ColorChangingLogoState();
}

class _ColorChangingLogoState extends State<ColorChangingLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _colorAnimation = ColorTween(
      begin: Color(0xFF401318),
      end: Colors.white,
    ).animate(_controller);

    _controller.addListener(() {
      if (_controller.status == AnimationStatus.completed) {
        _controller.reset(); // Reinicia a animação
        _controller.forward(); // Inicia novamente
      }
    });

    _controller.forward(); // Inicia a animação
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ColorFiltered(
          colorFilter: ColorFilter.mode(
            _colorAnimation.value ?? Colors.transparent,
            BlendMode.srcIn,
          ),
          child: Image.asset(
            'assets/logo.png',
            width: 350,
            height: 350,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
