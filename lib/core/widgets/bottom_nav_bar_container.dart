import 'package:flutter/material.dart';
import 'package:map_search/core/shared_providers/bottom_nav_bar_provider.dart';
import 'package:provider/provider.dart';

class BottomNavbarContainer extends StatelessWidget {
  const BottomNavbarContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavBarProvider>(
      builder: (context, provider, child) {
        return Row(
          children: List.generate(provider.bottomItem.length, (index) {
            bool isSelected = provider.currentIndex == index;

            String key = provider.bottomItem.keys.toList()[index];
            IconData icon = provider.bottomItem.values.toList()[index];

            return Expanded(
              child: InkWell(
                onTap: () => provider.updateCurrentIndex(index),
                child: Container(
                  padding: EdgeInsets.symmetric(
                      vertical: isSelected ? 8 : 4, horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(icon,
                          color: isSelected ? Colors.amberAccent : Colors.black, size: 26,),
                      if (isSelected)
                        Text(key, style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
              ),
            );
          }),
        );
        // return BottomNavigationBar(
        //   currentIndex: provider.currentIndex,
        //   onTap: provider.updateCurrentIndex,
        //   items: List.generate(provider.bottomItem.length, (index) {
        //     bool isSelected = provider.currentIndex == index;
        //
        //     String key = provider.bottomItem.keys.toList()[index];
        //     IconData icon = provider.bottomItem.values.toList()[index];
        //
        //     return BottomNavigationBarItem(
        //         icon: Icon(icon,
        //             color: isSelected ? Colors.amberAccent : Colors.black),
        //         label: '',
        //         activeIcon: Column(
        //           children: [
        //             Icon(icon,
        //                 color: isSelected ? Colors.amberAccent : Colors.black),
        //             Text(isSelected ? key : '')
        //           ],
        //         ));
        //   }),
        // );
      },
    );
  }
}
