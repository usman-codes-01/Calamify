import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/player_controller.dart';
import 'session_timer.dart';

class AmbientPlayerPage extends StatelessWidget {
  const AmbientPlayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PlayerController());

    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF262A4D)),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        width: w,
        height: h,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF90C6F5),
              Color(0xFFBDE8AE),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Circular player
              Container(
                width: w * 0.45,
                height: w * 0.45,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const RadialGradient(
                    colors: [
                      Color(0xFFBDE8AE),
                      Color(0xFF90C6F5),
                    ],
                    radius: 0.9,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 30,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: const Center(
                  child: Icon(
                    Icons.music_note,
                    size: 80,
                    color: Colors.white70,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Show selected file name
              Obx(() {
                final fileName = controller.player.audioSource?.sequence.first.tag ?? "No song selected";
                return Text(
                  fileName.toString(),
                  style: const TextStyle(
                    color: Color(0xFF4A4A4A),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                );
              }),

              const SizedBox(height: 20),

              // Pick file button
              ElevatedButton(
                onPressed: controller.pickFile,
                child: const Text("Select Song from Phone"),
              ),

              const SizedBox(height: 30),

              // Slider with reactive progress
              Obx(() {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: w * 0.1),
                  child: Row(
                    children: [
                      Text(
                        _formatTime(controller.progress.value),
                        style: const TextStyle(color: Color(0xFF4A4A4A)),
                      ),
                      Expanded(
                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            activeTrackColor: const Color(0xFFBDE8AE),
                            inactiveTrackColor: const Color(0xFF90C6F5).withOpacity(0.4),
                            thumbColor: Colors.white,
                            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
                          ),
                          child: Slider(
                            min: 0,
                            max: controller.totalDuration.value,
                            value: controller.progress.value.clamp(0, controller.totalDuration.value),
                            onChanged: controller.seek,
                          ),
                        ),
                      ),
                      Text(
                        _formatTime(controller.totalDuration.value),
                        style: const TextStyle(color: Color(0xFF4A4A4A)),
                      ),
                    ],
                  ),
                );
              }),

              const SizedBox(height: 30),

              // Playback controls
              Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.skip_previous),
                      color: const Color(0xFF4A4A4A),
                      iconSize: 36,
                    ),
                    const SizedBox(width: 30),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.4),
                            blurRadius: 15,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 36,
                        backgroundColor: Colors.white,
                        child: IconButton(
                          icon: Icon(
                            controller.isPlaying.value ? Icons.pause : Icons.play_arrow,
                            color: const Color(0xFF4A4A4A),
                          ),
                          onPressed: controller.toggle,
                          iconSize: 36,
                        ),
                      ),
                    ),
                    const SizedBox(width: 30),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.skip_next),
                      color: const Color(0xFF4A4A4A),
                      iconSize: 36,
                    ),
                  ],
                );
              }),

              const SizedBox(height: 50),

              // Bottom navigation
              Padding(
                padding: EdgeInsets.symmetric(horizontal: w * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _bottomIcon(Icons.home, 'Calm'),
                    _bottomIconButton(Icons.timer, 'Timer', () {
                      Get.to(() => const SessionTimerPage());
                    }),
                    _bottomIcon(Icons.shield_moon, 'Focus'),
                    _bottomIcon(Icons.nights_stay, 'Relax'),
                    _bottomIcon(Icons.more_horiz, 'More'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTime(double seconds) {
    final mins = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toInt().toString().padLeft(2, '0');
    return "$mins:$secs";
  }

  Widget _bottomIcon(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, size: 28, color: const Color(0xFF4A4A4A)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Color(0xFF4A4A4A), fontSize: 12)),
      ],
    );
  }

  Widget _bottomIconButton(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, size: 28, color: const Color(0xFF4A4A4A)),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(color: Color(0xFF4A4A4A), fontSize: 12)),
        ],
      ),
    );
  }
}
