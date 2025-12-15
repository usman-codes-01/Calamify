// main.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Profile_Screen.dart';
import 'tools_screen.dart';
import 'session_timer.dart';


// --------------------------- GLOBAL COLORS -----------------------------------
const Color kBackgroundColor = Color(0xFFF7F9FC);
const Color kTextDark = Color(0xFF262A4D);
const Color kPrimaryLight = Color(0xFF5EB8FF);
const Color kPrimaryDark = Color(0xFFB6F7C1);
const Color kgradient = Color(0xFF7ECFFF);
const Color kgradientlight = Color(0xFFB6F7C1);

// --------------------------- PLAYLIST COLORS ---------------------------------
const Color kRainyDayStart = Color(0xFF91B8EF);
const Color kRainyDayEnd = Color(0xFFD9E9FF);
const Color kEveningZenStart = Color(0xFFF7C887);
const Color kEveningZenEnd = Color(0xFFFFF0D0);

// ------------------------ SOUND CATEGORY COLORS ------------------------------
const Color kNatureStart = Color(0xFFFFF0F5);
const Color kNatureEnd = Color(0xFFFFB6C1);
const Color kAmbientStart = Color(0xFFE9E0FF);
const Color kAmbientEnd = Color(0xFF8869D6);
const Color kGuidedStart = Color(0xFFFFEAD0);
const Color kGuidedEnd = Color(0xFFFFD2A0);

// --------------------------- NAV BAR COLORS ----------------------------------
const Color kNavHome = Color(0xFF1E88E5);
const Color kNavExplore = Color(0xFF4CAF50);
const Color kNavTimer = Color(0xFFFF9800);
const Color kNavProfile = Color(0xFF673AB7);

// --------------------------- MAIN FUNCTION -----------------------------------
void main() {
  runApp(const MyApp());
}

//-------------------- MAIN APP --------------------------------------
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Calmify Static Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: kBackgroundColor,
        useMaterial3: true,
      ),
      home: const StaticHomeScreen(),
    );
  }
}

// -------------------------- STATIC HOME SCREEN -------------------------------
class StaticHomeScreen extends StatelessWidget {
  const StaticHomeScreen({super.key});

  PreferredSizeWidget _buildCalmifyAppBar() {
    return AppBar(
      backgroundColor: kBackgroundColor,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.black12, width: 1.0),
            gradient: const LinearGradient(
              colors: [kPrimaryLight, kPrimaryDark],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: const Icon(Icons.menu_rounded, color: Colors.white, size: 24),
        ),
      ),
      title: const Padding(
        padding: EdgeInsets.only(left: 8.0),
        child: Text(
          'Calmify',
          style: TextStyle(
            color: kTextDark,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 20, top: 8, bottom: 8),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black12, width: 1.5),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              const Icon(Icons.sunny, color: Color(0xFFF7BD5C), size: 18),
              const SizedBox(width: 4),
              Icon(Icons.dark_mode_outlined, color: Colors.grey.withAlpha(108), size: 18),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildCalmifyAppBar(),
      body: const HomePageContent(),
      bottomNavigationBar: const StaticBottomNavBar(),
    );
  }
}

// -------------------------- HOME PAGE CONTENT --------------------------------
class HomePageContent extends StatelessWidget {
  const HomePageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // -------- GRADIENT CARD --------
          Container(
            height: 170,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                colors: [kgradient, kgradientlight],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Daily Focus",
                        style: TextStyle(
                          color: kTextDark,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 2,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Quick Start",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: kTextDark,
                              ),
                            ),
                            SizedBox(width: 6),
                            Icon(Icons.volume_up, size: 18, color: kTextDark),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 10,
                  child: Image.asset(
                    "assets/meditation.png",
                    height: 160,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) =>
                    const Text("Image Placeholder", style: TextStyle(color: Colors.black54)),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),

          // -------- SOUND CATEGORIES --------
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Sound Categories",
                  style: TextStyle(
                    color: kTextDark,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                Icon(
                  Icons.stars_outlined,
                  color: kTextDark.withOpacity(0.6),
                  size: 20,
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Expanded(
                  child: SoundCategoryCard(
                    title: "Nature Sounds",
                    icon: Icons.landscape_outlined,
                    gradientStart: kNatureStart,
                    gradientEnd: kNatureEnd,
                    iconColor: Color(0xFF4CAF50),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: SoundCategoryCard(
                    title: "Ambient Music",
                    icon: Icons.music_note_outlined,
                    gradientStart: kAmbientStart,
                    gradientEnd: kAmbientEnd,
                    iconColor: Color(0xFF673AB7),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: SoundCategoryCard(
                    title: "Guided Meditations",
                    icon: Icons.psychology_outlined,
                    gradientStart: kGuidedStart,
                    gradientEnd: kGuidedEnd,
                    iconColor: Color(0xFFFF9800),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // -------- PLAYLISTS & BREATHING --------
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "My Playlists",
                              style: TextStyle(
                                color: kTextDark,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Icon(
                              Icons.stars_outlined,
                              color: kTextDark.withOpacity(0.6),
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      const PlaylistCard(
                        title: "Rainy Days",
                        icon: Icons.cloudy_snowing,
                        gradientStart: kRainyDayStart,
                        gradientEnd: kRainyDayEnd,
                      ),
                      const SizedBox(height: 10),
                      const PlaylistCard(
                        title: "Evening Zen",
                        icon: Icons.mode_night_outlined,
                        gradientStart: kEveningZenStart,
                        gradientEnd: kEveningZenEnd,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                const Expanded(child: BreathingExerciseCard()),
              ],
            ),
          ),

          const SizedBox(height: 50),
        ],
      ),
    );
  }
}

// --------------------------- STATIC BOTTOM NAV BAR ---------------------------
class StaticBottomNavBar extends StatelessWidget {
  const StaticBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              NavIconItem(icon: Icons.home_outlined, label: "Home", circleColor: kNavHome),
              NavIconItem(icon: Icons.search, label: "Explore", circleColor: kNavExplore, isExplore: true),
              NavIconItem(icon: Icons.timer_outlined, label: "Timer", circleColor: kNavTimer, isTimer: true),
              NavIconItem(icon: Icons.person_outline, label: "Profile", circleColor: kNavProfile), // <-- will navigate now
            ],
          ),
        ),
      ),
    );
  }
}

// ------------------ NAV ICON ITEM ---------------------------------------------
class NavIconItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color circleColor;
  final bool isExplore;
  final bool isTimer;

  const NavIconItem({
    super.key,
    required this.icon,
    required this.label,
    required this.circleColor,
    this.isExplore = false,
    this.isTimer = false,
  });

  void _handleTap() {
    if (isExplore) {
      Get.to(() => ToolsScreen());
    } else if (isTimer) {
      Get.to(() => SessionTimerPage());
    } else if (label == "Profile") {
      Get.to(() => const ProfileScreen()); // <-- added profile navigation
    } else {
      print('Tapped on $label');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: circleColor,
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: kTextDark,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------PLAYLIST CARD ------------------------------------
class PlaylistCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color gradientStart;
  final Color gradientEnd;

  const PlaylistCard({
    super.key,
    required this.title,
    required this.icon,
    required this.gradientStart,
    required this.gradientEnd,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          colors: [gradientStart, gradientEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: gradientStart.withOpacity(0.3),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, size: 24, color: kTextDark.withOpacity(0.7)),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(
              color: kTextDark,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

// ------------------------ BREATHING EXERCISE CARD ----------------------------
class BreathingExerciseCard extends StatelessWidget {
  const BreathingExerciseCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(top: 8),
          alignment: Alignment.center,
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: kPrimaryLight, width: 2.5),
                    ),
                  ),
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(color: Colors.black12, width: 1.0),
                    ),
                    child: Image.asset(
                      'assets/breathing_logo.png',
                      height: 100,
                      width: 100,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) =>
                      const Center(child: Text("Logo", style: TextStyle(color: Colors.black54, fontSize: 10))),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                "Breathing Exercise",
                style: TextStyle(
                  color: kTextDark,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFBE8),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.black12.withOpacity(0.1), width: 1.0),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Quote of the Day:",
                style: TextStyle(
                  color: kTextDark,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 4),
              Text(
                "\"Find stillness within.\"",
                style: TextStyle(
                  color: kTextDark,
                  fontStyle: FontStyle.italic,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// -------------------------- SOUND CATEGORY CARD ------------------------------
class SoundCategoryCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color gradientStart;
  final Color gradientEnd;
  final Color iconColor;

  const SoundCategoryCard({
    super.key,
    required this.title,
    required this.icon,
    required this.gradientStart,
    required this.gradientEnd,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 105,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          colors: [gradientStart, gradientEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.95),
            ),
            child: Icon(icon, size: 28, color: iconColor),
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Text(
              title,
              style: const TextStyle(
                color: kTextDark,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
