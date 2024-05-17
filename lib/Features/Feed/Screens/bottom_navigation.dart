import 'package:flutter/material.dart';
import '../../../Core/Constants/pallete.dart';
import '../../AddPost/Screens/create_new_post.dart';
import '../../Profile/Screens/profile_screen.dart';
import 'feed_screen.dart';

class BottomNavigationTabs extends StatefulWidget {
  const BottomNavigationTabs({super.key});

  @override
  State<BottomNavigationTabs> createState() => _BottomNavigationTabsState();
}

class _BottomNavigationTabsState extends State<BottomNavigationTabs> {
  int _index = 0;
  final pages = [
    const FeedScreen(),
    const CreatePostScreen(),
    const Center(
      child: Text(
        'This is Search Screen',
        style: TextStyle(color: Colors.black),
      ),
    ),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.bgColor,
      body: pages[_index],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          elevation: 0,
          indicatorColor: Colors.blue[100],
          labelTextStyle: const MaterialStatePropertyAll(
            TextStyle(
              color: Pallete.primaryTextColor,
              fontFamily: 'Sofia Pro',
              fontWeight: FontWeight.w400,
              fontSize: 15,
            ),
          ),
        ),
        child: NavigationBar(
          selectedIndex: _index,
          backgroundColor: Pallete.bgColor,
          height: 70,
          onDestinationSelected: (value) {
            setState(() {
              _index = value;
            });
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(
                Icons.home,
                size: 25,
              ),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.add_circle_rounded,
                size: 25,
              ),
              label: 'Add Post',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.search,
                size: 27,
              ),
              label: 'Search',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.person,
                size: 25,
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
