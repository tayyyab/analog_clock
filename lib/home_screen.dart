import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math' as math;

final clockProvider = StreamProvider<int>((ref) => fetchNumbers());
Stream<int> fetchNumbers() => Stream<int>.periodic(
    const Duration(seconds: 1), (_) => DateTime.now().second);

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var timeAsync = ref.watch(clockProvider);
    return Scaffold(
        body: timeAsync.when(
            data: (int data) => Center(
                    child: Container(
                  color: Colors.red,
                  height: 50,
                  width: 50,
                  child: CustomPaint(
                    painter: SecondHandPainter(),
                    child: Center(child: Text(data.toString())),
                  ),
                )),
            error: (Object error, StackTrace stackTrace) =>
                Text(error.toString()),
            loading: () => const Center(child: CircularProgressIndicator())));
  }
}

class SecondHandPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p1 = Offset(size.width / 2, size.height / 2);
    final p2 = Offset(size.width / 2, 0);
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 4;
    canvas.drawLine(p1, p2, paint);

    final p3 = Offset(size.width / 2, size.height / 2);
    final p4 = Offset((size.width / 2) * (math.pi / 2), 0);
    final paint1 = Paint()
      ..color = Colors.black
      ..strokeWidth = 4;
    canvas.drawLine(p3, p4, paint1);
  }

  @override
  bool shouldRepaint(SecondHandPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(SecondHandPainter oldDelegate) => false;
}
