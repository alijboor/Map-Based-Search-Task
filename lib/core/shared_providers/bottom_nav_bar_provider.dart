import 'package:flutter/material.dart';
import 'package:map_search/core/constants/lang_keys.dart';
import 'package:map_search/features/bookmarks/screens/bookmarks_screen.dart';
import 'package:map_search/features/home/screens/home_screen.dart';
import 'package:map_search/features/profile/screens/profile_screen.dart';
import 'package:map_search/features/search/screens/search_screen.dart';

class BottomNavBarProvider with ChangeNotifier {
  int _currentIndex = 1;

  // List of screens
  final List<Widget> screens = [
    const HomeScreen(),
    const SearchScreen(),
    const BookmarksScreen(),
    const ProfileScreen(),
  ];

  final Map<String, IconData> bottomItem = {
    LangKeys.home: Icons.home_outlined,
    LangKeys.search: Icons.search,
    LangKeys.bookmarks: Icons.bookmark_border_rounded,
    LangKeys.profile: Icons.person_outline,
  };

  int get currentIndex => _currentIndex;

  void updateCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
