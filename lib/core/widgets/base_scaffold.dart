import 'package:flutter/material.dart';
import 'package:map_search/core/shared_providers/bottom_nav_bar_provider.dart';
import 'package:map_search/core/widgets/bottom_nav_bar_container.dart';
import 'package:provider/provider.dart';

class BaseScaffold extends StatelessWidget {
  const BaseScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    final BottomNavBarProvider provider =
        Provider.of<BottomNavBarProvider>(context);

    return Scaffold(
        body: provider.screens[provider.currentIndex],
        bottomNavigationBar: const BottomNavbarContainer());
  }
}
