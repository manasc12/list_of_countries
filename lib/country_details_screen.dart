import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:list_of_countries/country_provider.dart';
import 'package:list_of_countries/constants.dart';

class CountryDetailsScreen extends StatelessWidget {
  const CountryDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Provider.of<Country>(context, listen: false)
            .toggleShowContentFlag(showMore: false);
        return true;
      },
      child: Consumer<Country>(
        builder: (context, country, child) {
          String content = '';
          switch (country.resultFetchStatus) {
            case Status.waiting:
              {
                content = 'Please wait while the result is loading ...!';
              }
              break;
            case Status.failure:
              {
                content = 'Some error occurred while loading the results!';
              }
              break;
            case Status.success:
              {
                if (country.showMoreFlag) {
                  content = 'Country Code: ${country.code!}'
                      '\n'
                      'Name: ${country.name ?? ''}'
                      '\n'
                      'Capital: ${country.capital ?? ''}'
                      '\n'
                      'Currency:${country.currency ?? ''}'
                      '\n'
                      'Native:${country.native ?? ''}'
                      '\n'
                      'Phone:${country.phone ?? ''}'
                      '\n'
                      'Emoji: ${country.emoji ?? ''}'
                      '\n'
                      'Continent:${country.continent ?? ''}'
                      '\n'
                      'Languages:${country.languages ?? ''}';
                } else {
                  content = 'Country Code: ${country.code!}'
                      '\n'
                      'Name: ${country.name ?? ''}';
                }
              }

              break;
            default:
              {
                content = 'Initializing!';
              }
          }
          return Scaffold(
            appBar: AppBar(
              title: const Text('County Details'),
            ),
            body: Scrollbar(
              child: ListView(
                children: [
                  Text(
                    content,
                    style: const TextStyle(fontSize: 20),
                  ),
                  Center(
                    child: OutlinedButton(
                      child: Text(
                          country.showMoreFlag ? 'Show less' : 'Show More'),
                      onPressed: () {
                        Provider.of<Country>(context, listen: false)
                            .toggleShowContentFlag(
                                showMore: !country.showMoreFlag);
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
