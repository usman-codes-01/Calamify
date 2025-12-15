import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SessionTimerPage extends StatefulWidget {
  const SessionTimerPage({super.key});

  @override
  State<SessionTimerPage> createState() => _SessionTimerPageState();
}

class _SessionTimerPageState extends State<SessionTimerPage> {
  int totalMinutes = 25;
  int elapsedMinutes = 0;
  int elapsedSeconds = 0;
  double progress = 0.0;
  Timer? timer;
  bool isRunning = false;

  void startTimer() {
    if (isRunning) return;

    isRunning = true;
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() {
        if (elapsedMinutes < totalMinutes) {
          elapsedSeconds++;
          if (elapsedSeconds == 60) {
            elapsedMinutes++;
            elapsedSeconds = 0;
          }
          int totalElapsedSeconds = elapsedMinutes * 60 + elapsedSeconds;
          progress = totalElapsedSeconds / (totalMinutes * 60);
        } else {
          stopTimer();
        }
      });
    });
  }

  void stopTimer() {
    timer?.cancel();
    isRunning = false;
  }

  void resetTimer() {
    stopTimer();
    setState(() {
      elapsedMinutes = 0;
      elapsedSeconds = 0;
      progress = 0.0;
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    String twoDigits(int n) => n.toString().padLeft(2, '0');

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F4),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: w * 0.05),

            // BACK BUTTON
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, size: 30, color: Colors.black87),
                onPressed: () {
                  Get.back();
                },
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Session Timer",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: w * 0.08),

            // TIMER CIRCLE
            SizedBox(
              width: w * 0.6,
              height: w * 0.6,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: w * 0.6,
                    height: w * 0.6,
                    child: CustomPaint(
                      painter: _GradientCircularProgress(progress: progress),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${twoDigits(elapsedMinutes)}:${twoDigits(elapsedSeconds)}",
                        style: TextStyle(
                          fontSize: w * 0.13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text("minutes"),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: w * 0.12),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _tag("Focus", Colors.green.shade200),
                SizedBox(width: 12),
                _tag("Sleep", Colors.purple.shade200),
                SizedBox(width: 12),
                _tag("Meditate", Colors.blue.shade200),
              ],
            ),

            SizedBox(height: w * 0.12),

            GestureDetector(
              onTap: () {
                isRunning ? stopTimer() : startTimer();
              },
              child: Container(
                width: w * 0.65,
                padding: const EdgeInsets.symmetric(vertical: 18),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  gradient: const LinearGradient(
                    colors: [Color(0xFFB8F1C9), Color(0xFFAEE6FF)],
                  ),
                ),
                child: Center(
                  child: Text(
                    isRunning ? "Stop Session" : "Start Session",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            GestureDetector(
              onTap: resetTimer,
              child: Container(
                width: w * 0.3,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  gradient: const LinearGradient(
                    colors: [Color(0xFFB8F1C9), Color(0xFFAEE6FF)],
                  ),
                ),
                child: const Center(
                  child: Text(
                    "Reset",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _tag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    );
  }
}

class _GradientCircularProgress extends CustomPainter {
  final double progress;
  _GradientCircularProgress({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    double strokeWidth = 18;
    double radius = (size.width / 2) - strokeWidth / 2;

    Paint bgPaint = Paint()
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawCircle(size.center(Offset.zero), radius, bgPaint);

    Rect rect = Rect.fromCircle(center: size.center(Offset.zero), radius: radius);
    Paint fgPaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFF007F50), Color(0xFF0055CC)],
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;

    double sweepAngle = 2 * 3.141592653589793 * progress;

    canvas.drawArc(
      Rect.fromCircle(center: size.center(Offset.zero), radius: radius),
      -3.141592653589793 / 2,
      sweepAngle,
      false,
      fgPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
