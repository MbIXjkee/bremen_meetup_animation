import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: EarthAdvertising());
  }
}

class EarthAdvertising extends StatelessWidget {
  const EarthAdvertising({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          for (int i = 0; i < 10; i++)
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.all(8.0),
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          for (int i = 0; i < 10; i++)
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.all(8.0),
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        'Our beautiful home',
        style: Theme.of(context).textTheme.displayLarge?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _FunFact extends StatelessWidget {
  const _FunFact();

  @override
  Widget build(BuildContext context) {
    return Text(
      'the only place in the solar system where water can be present in all the'
      ' three states: solid, liquid and gas.',
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
        color: Colors.white,
      ),
      textAlign: TextAlign.center,
    );
  }
}

class _EarthName extends StatelessWidget {
  const _EarthName();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        'Earth',
        style: Theme.of(context).textTheme.displayLarge?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _Earth extends StatelessWidget {
  final Animation<double> animation;

  const _Earth({required this.animation});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        'assets/globe.json',
        controller: animation,
      ),
    );
  }
}
