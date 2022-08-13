import 'package:songlib/util/env/flavor_config.dart';
import 'package:flutter/material.dart';

class TextScaleFactor extends StatelessWidget {
  final Widget child;

  const TextScaleFactor({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    FlavorConfig.instance.devicePixelRatio = mediaQuery.devicePixelRatio;
    if (FlavorConfig.isInTest()) return child;
    return MediaQuery(
      data: mediaQuery.copyWith(textScaleFactor: 1),
      child: child,
    );
  }
}
