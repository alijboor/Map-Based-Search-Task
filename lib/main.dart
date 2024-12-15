import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:map_search/core/shared_providers/bottom_nav_bar_provider.dart';
import 'package:map_search/core/widgets/base_scaffold.dart';
import 'package:provider/provider.dart';

void main() async {
  await Hive.initFlutter();

  runApp(
    ChangeNotifierProvider(
      create: (_) => BottomNavBarProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Map-Based Search Task',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true),
      home: const BaseScaffold(),
    );
  }
}
