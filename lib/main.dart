import 'package:flutter/material.dart';

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
