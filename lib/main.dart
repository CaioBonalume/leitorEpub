import 'package:desafio2/provider/fav_provider.dart';
import 'package:desafio2/shared/color_schemes.dart';
import 'package:desafio2/pages/Home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=> FavoriteProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Escribo Desafio 2',
        theme: ThemeData(
            colorScheme: lightColorScheme,
            useMaterial3: true,
            appBarTheme:
                const AppBarTheme(elevation: 0, scrolledUnderElevation: 0)),
        darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: darkColorScheme,
            appBarTheme:
                const AppBarTheme(elevation: 0, scrolledUnderElevation: 0)),
        home: const HomePage(),
      ),
    );
  }
}
