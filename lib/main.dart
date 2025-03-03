import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sudoku/screens/main_screen.dart';
import 'package:sudoku/states/sudoku_state.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (_) => SudokuState(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}
