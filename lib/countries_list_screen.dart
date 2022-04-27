import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:list_of_countries/country_provider.dart';
import 'package:list_of_countries/country_details_screen.dart';
import 'package:list_of_countries/constants.dart';
import 'package:list_of_countries/widgets.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({required this.title, Key? key}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Consumer<CountryListType>(
        builder: (context, countryList, child) {
          List<Country> allCountriesList = countryList.countriesList;
          switch (countryList.resultFetchStatus) {
            case Status.initialized:
              {
                return buildCenteredTextWidget(text: 'Initializing ...!');
              }
            case Status.waiting:
              {
                return buildCenteredTextWidget(
                    text: 'Please wait while the result is loading ...!');
              }
            case Status.failure:
              {
                return buildCenteredTextWidget(
                    text: 'Some error occurred while loading the results!');
              }
            case Status.success:
              {
                return Scrollbar(
                  child: ListView.builder(
                    itemCount: allCountriesList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(allCountriesList[index].name ?? ''),
                        trailing: IconButton(
                            onPressed: () {
                              Provider.of<Country>(context, listen: false)
                                  .getCountryDetails(
                                      allCountriesList[index].code ?? '');
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const CountryDetailsScreen(),
                                  ));
                            },
                            icon: const Icon(Icons.play_arrow_sharp)),
                      );
                    },
                  ),
                );
              }
          }
        },
      ),
    );
  }
}
