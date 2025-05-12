import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

import 'home_page.dart';
import 'message_page.dart';
import 'profile_page.dart';
import 'setting_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bottom Nav Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 237, 133, 168),
        ),
      ),
      home: const MainNavigation(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;
  bool _showFab = true;

  final List<Widget> _screens = [
    const HomePage(),
    const MessagePage(),
    const ProfilePage(),
    const SettingPage(),
  ];

  final iconList = [Icons.home, Icons.message, Icons.person, Icons.settings];

  final pageTitles = [
    'AMANDA ADITAMA',
    'AMANDA ADITAMA',
    'AMANDA ADITAMA',
    'AMANDA ADITAMA',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitles[_currentIndex]),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
      ),
      body: _screens[_currentIndex],
      floatingActionButton: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child:
            _showFab
                ? FloatingActionButton(
                  key: const ValueKey('fab'),
                  onPressed: () {
                    setState(() {
                      _showFab = false;
                    });
                  },
                  backgroundColor:
                      Theme.of(context).colorScheme.primaryContainer,
                  child: const Icon(Icons.add),
                )
                : const SizedBox.shrink(key: ValueKey('no_fab')),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          AnimatedBottomNavigationBar.builder(
            itemCount: iconList.length,
            tabBuilder: (index, isActive) {
              final color =
                  isActive
                      ? Colors.white
                      : const Color.fromARGB(255, 65, 64, 64);
              return Icon(iconList[index], color: color);
            },
            backgroundColor: const Color.fromARGB(255, 237, 133, 168),
            activeIndex: _currentIndex,
            gapLocation: _showFab ? GapLocation.center : GapLocation.none,
            notchSmoothness: NotchSmoothness.softEdge,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            key: ValueKey(_showFab),
          ),
          if (!_showFab)
            Positioned(
              bottom: 10,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _showFab = true;
                  });
                },
                behavior: HitTestBehavior.translucent,
                child: Container(
                  height: 70,
                  width: 70,
                  color: Colors.transparent,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
