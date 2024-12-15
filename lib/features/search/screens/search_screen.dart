import 'package:flutter/material.dart';
import 'package:map_search/features/search/providers/search_provider_screen.dart';
import 'package:map_search/features/search/widgets/map_widget.dart';
import 'package:map_search/features/search/widgets/search_field.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SearchProviderScreen(),
      builder: (context, child) {
        return const Stack(
          children: [MapWidget(), SearchField()],
        );
      },
    );
  }
}
