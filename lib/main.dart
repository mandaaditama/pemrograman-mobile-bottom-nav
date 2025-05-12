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
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 253, 130, 191),
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

  final List<Widget> _pages = [
    const HomePage(),
    const MessagePage(),
    const ProfilePage(),
    const SettingPage(),
  ];

  final iconList = <IconData>[
    Icons.home,
    Icons.message,
    Icons.person,
    Icons.settings,
  ];

  final titles = ['Home', 'Message', 'Profile', 'Settings'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titles[_currentIndex]),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        automaticallyImplyLeading: false,
      ),
      body: _pages[_currentIndex],

      // FAB that can be hidden
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

      // Bottom navigation bar with dynamic notch
      bottomNavigationBar: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          AnimatedBottomNavigationBar.builder(
            itemCount: iconList.length,
            tabBuilder: (int index, bool isActive) {
              final color =
                  isActive
                      ? Theme.of(context).colorScheme.primary
                      : Colors.grey;
              return Icon(iconList[index], color: color);
            },
            backgroundColor: Theme.of(context).colorScheme.surface,
            activeIndex: _currentIndex,
            gapLocation: _showFab ? GapLocation.center : GapLocation.none,
            notchSmoothness: NotchSmoothness.softEdge,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            key: ValueKey(_showFab), // Forces re-render on FAB toggle
          ),

          // Invisible tap area to bring FAB back
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
