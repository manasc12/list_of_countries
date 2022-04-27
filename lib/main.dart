import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:list_of_countries/country_provider.dart';
import 'package:list_of_countries/countries_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Country()),
        ChangeNotifierProvider(create: (context) => CountryListType()),
      ],
      child: MaterialApp(
        title: 'Countries Demo',
        theme: ThemeData(
          primarySwatch: Colors.amber,
        ),
        home: const MyHomePage(title: 'List of Countries'),
      ),
    );
  }
}
