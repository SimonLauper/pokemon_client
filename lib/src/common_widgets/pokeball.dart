import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:pokemon_client/src/theme/app_theme.dart';

/// Poké Ball dessinée en code, pour ne dépendre d'aucune image.
///
/// - `Pokeball()` : version colorée (rouge / blanc).
/// - `Pokeball.silhouette()` : version monochrome, pratique en filigrane.
class Pokeball extends StatelessWidget {
  const Pokeball({super.key, this.size = 48}) : color = null;

  const Pokeball.silhouette({super.key, required this.size, required this.color});

  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: CustomPaint(painter: _PokeballPainter(color)),
    );
  }
}

class _PokeballPainter extends CustomPainter {
  _PokeballPainter(this.silhouette);

  final Color? silhouette;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.shortestSide / 2;
    final stroke = radius * 0.13;
    final body = Rect.fromCircle(center: center, radius: radius - stroke / 2);
    final buttonRadius = radius * 0.3;

    final outline = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..color = silhouette ?? PokedexTheme.ink;

    // saveLayer : permet de « percer » le filigrane avec BlendMode.clear.
    canvas.saveLayer(Offset.zero & size, Paint());

    if (silhouette != null) {
      canvas.drawArc(body, math.pi, math.pi, true, Paint()..color = silhouette!);
    } else {
      canvas.drawArc(body, math.pi, math.pi, true, Paint()..color = PokedexTheme.red);
      canvas.drawArc(body, 0, math.pi, true, Paint()..color = Colors.white);
    }

    canvas.drawCircle(center, body.width / 2, outline);
    canvas.drawLine(
      Offset(body.left, center.dy),
      Offset(body.right, center.dy),
      outline,
    );

    if (silhouette != null) {
      canvas.drawCircle(
        center,
        buttonRadius + stroke * 1.2,
        Paint()..blendMode = BlendMode.clear,
      );
    } else {
      canvas.drawCircle(center, buttonRadius, Paint()..color = Colors.white);
    }
    canvas.drawCircle(center, buttonRadius, outline);

    canvas.restore();
  }

  @override
  bool shouldRepaint(_PokeballPainter oldDelegate) {
    return oldDelegate.silhouette != silhouette;
  }
}

/// Indicateur de chargement : une Poké Ball qui tourne.
class PokeballLoader extends StatefulWidget {
  const PokeballLoader({super.key, this.size = 56});

  final double size;

  @override
  State<PokeballLoader> createState() => _PokeballLoaderState();
}

class _PokeballLoaderState extends State<PokeballLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: Pokeball(size: widget.size),
    );
  }
}
