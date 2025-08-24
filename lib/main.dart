import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sliver_catalog/sliver_catalog.dart';

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
          const _BestPlaceEverWidget(),
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

class _BestPlaceEverWidget extends StatelessWidget {
  const _BestPlaceEverWidget();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;

    return ScrollHijackSliver(
      consumingSpaceSize: 2 * height,
      builder: (context, consumingProgress) {
        return Container(
          height: height,
          color: Colors.blueGrey,
          child: Column(
            children: [
              const _Header(),
              Expanded(
                child: _AdvertisingContent(
                  progress: consumingProgress,
                ),
              ),
            ],
          ),
        );
      },
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

class _AdvertisingContent extends StatefulWidget {
  final ValueListenable<double> progress;

  const _AdvertisingContent({required this.progress});

  @override
  State<_AdvertisingContent> createState() => __AdvertisingContentState();
}

class __AdvertisingContentState extends State<_AdvertisingContent> {
  late final ContentAnimation _animation;

  @override
  void initState() {
    super.initState();

    _animation = ContentAnimation(widget.progress);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _PositionedEarth(animation: _animation),
        _PositionedFact(animation: _animation),
        _PositionedEarthName(animation: _animation),
      ],
    );
  }
}

class _PositionedFact extends StatelessWidget {
  final ContentAnimation animation;

  const _PositionedFact({required this.animation});

  @override
  Widget build(BuildContext context) {
    final positionAnimation = animation.factMovingAnimaion;

    return AnimatedBuilder(
      animation: positionAnimation,
      builder: (context, child) {
        final offset = positionAnimation.value;
        final opacityAnimation = animation.factTransparencyAnimaion;

        return Positioned(
          top: offset,
          left: 0,
          right: 0,
          child: FractionallySizedBox(
            widthFactor: 2 / 3,
            child: AnimatedBuilder(
              animation: opacityAnimation,
              builder: (context, child) {
                final opacity = opacityAnimation.value;

                if (opacity > 0) {
                  return Opacity(
                    opacity: opacity,
                    child: child,
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
              child: const _FunFact(),
            ),
          ),
        );
      },
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

class _PositionedEarthName extends StatelessWidget {
  final ContentAnimation animation;

  const _PositionedEarthName({required this.animation});

  @override
  Widget build(BuildContext context) {
    final opacityAnimation = animation.earthNameAnimaion;

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: AnimatedBuilder(
        animation: opacityAnimation,
        builder: (context, child) {
          final opacity = opacityAnimation.value;

          if (opacity > 0) {
            return Opacity(
              opacity: opacity,
              child: child,
            );
          } else {
            return const SizedBox.shrink();
          }
        },
        child: const _EarthName(),
      ),
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

class _PositionedEarth extends StatelessWidget {
  final ContentAnimation animation;

  const _PositionedEarth({
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: animation.earthScalingAnimaion,
      builder: (context, value, child) {
        return Positioned.fill(
          child: Transform.scale(
            scale: value,
            alignment: Alignment.topCenter,
            child: child,
          ),
        );
      },
      child: _Earth(animation: animation.earthSpiningAnimaion),
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

class ContentAnimation {
  late final Animation<double> earthSpiningAnimaion;
  late final Animation<double> earthScalingAnimaion;
  late final Animation<double> factMovingAnimaion;
  late final Animation<double> factTransparencyAnimaion;
  late final Animation<double> earthNameAnimaion;

  ContentAnimation(ValueListenable<double> driver) {
    final drivingAnimation = Animation.fromValueListenable(driver);

    earthSpiningAnimaion = drivingAnimation.drive(
      TweenSequence(
        [
          TweenSequenceItem(tween: ConstantTween<double>(0.0), weight: 25),
          TweenSequenceItem(
            tween: Tween<double>(begin: 0.0, end: 1.0),
            weight: 75,
          ),
        ],
      ),
    );

    earthScalingAnimaion = drivingAnimation.drive(
      TweenSequence(
        [
          TweenSequenceItem(
            tween: Tween<double>(
              begin: 3.0,
              end: 1.5,
            ).chain(CurveTween(curve: Curves.easeIn)),
            weight: 30,
          ),
          TweenSequenceItem(
            tween: ConstantTween<double>(1.5),
            weight: 30,
          ),
          TweenSequenceItem(
            tween: Tween<double>(
              begin: 1.5,
              end: 1.0,
            ).chain(CurveTween(curve: Curves.easeIn)),
            weight: 30,
          ),
          TweenSequenceItem(
            tween: ConstantTween<double>(1.0),
            weight: 10,
          ),
        ],
      ),
    );

    factMovingAnimaion = drivingAnimation.drive(
      TweenSequence(
        [
          TweenSequenceItem(
            tween: Tween<double>(
              begin: 100.0,
              end: 0.0,
            ).chain(CurveTween(curve: Curves.easeIn)),
            weight: 25,
          ),
          TweenSequenceItem(tween: ConstantTween<double>(0.0), weight: 75),
        ],
      ),
    );

    factTransparencyAnimaion = drivingAnimation.drive(
      TweenSequence(
        [
          TweenSequenceItem(
            tween: Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).chain(CurveTween(curve: Curves.easeIn)),
            weight: 25,
          ),
          TweenSequenceItem(tween: ConstantTween<double>(1.0), weight: 25),
          TweenSequenceItem(
            tween: Tween<double>(
              begin: 1.0,
              end: 0.0,
            ).chain(CurveTween(curve: Curves.easeOut)),
            weight: 25,
          ),
          TweenSequenceItem(tween: ConstantTween<double>(0.0), weight: 25),
        ],
      ),
    );

    earthNameAnimaion = drivingAnimation.drive(
      TweenSequence(
        [
          TweenSequenceItem(tween: ConstantTween<double>(0.0), weight: 80),
          TweenSequenceItem(
            tween: Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).chain(CurveTween(curve: Curves.fastLinearToSlowEaseIn)),
            weight: 20,
          ),
        ],
      ),
    );
  }
}
