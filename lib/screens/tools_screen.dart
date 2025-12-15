// tools_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'ambient_player_page.dart';

// ---------------------- TOOLS SCREEN COLORS ----------------------
const Color kBackgroundStart = Color(0xFF7ECFFF);
const Color kBackgroundEnd = Color(0xFFB6F7C1);
const Color kTextDark = Color(0xFF262A4D);

const Color kGreenLight = Color(0xFF9EE37D);
const Color kGreenDark = Color(0xFF3DC985);

const Color kPurpleLight = Color(0xFF6C63FF);
const Color kPurpleDark = Color(0xFFB46CFF);

const Color kBlueLight = Color(0xFF69C9D0);
const Color kBlueDark = Color(0xFF2AB2C6);

const Color kOrangeLight = Color(0xFFFFA987);
const Color kOrangeDark = Color(0xFFFF7360);

// ---------------------- MODEL ----------------------
class ToolModel {
  final String title;
  final String iconPath;
  final List<Color> gradientColors;

  ToolModel({
    required this.title,
    required this.iconPath,
    required this.gradientColors,
  });
}

// ---------------------- CONTROLLER ----------------------
class ToolsController extends GetxController {
  final tools = <ToolModel>[
    ToolModel(
      title: 'BMI & BMR',
      iconPath: 'assets/icons/bmi.png',
      gradientColors: [kGreenLight, kGreenDark],
    ),
    ToolModel(
      title: 'Media Player',
      iconPath: 'assets/icons/media.png',
      gradientColors: [kPurpleLight, kPurpleDark],
    ),
    ToolModel(
      title: 'Notepad',
      iconPath: 'assets/icons/note.png',
      gradientColors: [kBlueLight, kBlueDark],
    ),
    ToolModel(
      title: 'Coming Soon',
      iconPath: 'assets/icons/soon.png',
      gradientColors: [kOrangeLight, kOrangeDark],
    ),
  ].obs;
}

// ---------------------- TOOL CARD WIDGET ----------------------
class ToolCard extends StatelessWidget {
  final ToolModel tool;

  const ToolCard({super.key, required this.tool});

  // Map tool titles to icons
  IconData _getIcon(String title) {
    switch (title) {
      case 'BMI & BMR':
        return Icons.fitness_center;
      case 'Media Player':
        return Icons.music_note;
      case 'Notepad':
        return Icons.note;
      case 'Coming Soon':
        return Icons.upcoming;
      default:
        return Icons.extension;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (tool.title == 'Media Player') {
          Get.to(() => AmbientPlayerPage());
        } else {
          print('Tapped on ${tool.title}');
        }
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: tool.gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: tool.gradientColors.last.withOpacity(0.25),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _getIcon(tool.title),
              size: 45,
              color: Colors.white,
            ),
            const SizedBox(height: 10),
            Text(
              tool.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// ---------------------- UI SCREEN ----------------------
class ToolsScreen extends StatelessWidget {
  final controller = Get.put(ToolsController());

  ToolsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [kBackgroundStart, kBackgroundEnd],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ---------------- HEADER ----------------
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(10),
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          color: kTextDark,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Text(
                      'Essential Tools',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: kTextDark,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // ---------------- SEARCH BAR ----------------
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search tools...',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // ---------------- GRID SECTION ----------------
                Expanded(
                  child: Obx(
                        () => GridView.builder(
                      itemCount: controller.tools.length,
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemBuilder: (context, index) {
                        final tool = controller.tools[index];
                        return ToolCard(tool: tool);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
