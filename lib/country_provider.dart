import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:list_of_countries/constants.dart';

class CountryListType extends ChangeNotifier {
  List<Country> countriesList;
  Status resultFetchStatus;

  CountryListType(
      {this.resultFetchStatus = Status.initialized,
      this.countriesList = const []}) {
    notifyListeners();
    _getListOfCountries();
  }

  _getListOfCountries() async {
    resultFetchStatus = Status.waiting;
    notifyListeners();
    var result = await client.query(
      QueryOptions(
        document: gql(getAllCountries),
      ),
    );
    if (result.hasException) {
      resultFetchStatus = Status.failure;
      notifyListeners();
      throw result.exception!;
    } else {
      var json = result.data!["countries"];
      // print('countries: $json');
      List<Country> countries = [];
      for (var res in json) {
        var country = Country();
        country._mapJsonData(json: res);
        countries.add(country);
      }
      countriesList = countries;
      resultFetchStatus = Status.success;
      notifyListeners();
    }
  }
}

class Country extends ChangeNotifier {
  String? code;
  String? name;
  String? capital;
  String? currency;
  String? native;
  String? phone;
  String? emoji;
  Map<String, dynamic>? continent;
  List<Map<String, dynamic>>? languages;
  Status resultFetchStatus;
  bool showMoreFlag;

  Country(
      {this.resultFetchStatus = Status.initialized, this.showMoreFlag = false});

  _mapJsonData(
      {required Map<String, dynamic> json,
      Status resultFetchStatus = Status.initialized}) {
    code = json["code"];
    name = json["name"];
    capital = json["capital"];
    currency = json["currency"];
    native = json["native"];
    phone = json["phone"];
    emoji = json["emoji"];
    continent = json["continent"] != null
        ? {"code": json["continent"]["code"], "name": json["continent"]["name"]}
        : null;
    languages = [];
    List languageList = json["languages"] ?? [];
    for (var language in languageList) {
      languages!.add({
        "code": language["code"],
        "name": language["name"],
        "native": language["native"],
        "rtl": language["rtl"]
      });
    }
    this.resultFetchStatus = resultFetchStatus;
  }

  getCountryDetails(String code) async {
    Map<String, dynamic> json = {};
    _mapJsonData(json: json, resultFetchStatus: Status.waiting);
    notifyListeners();
    var result = await client.query(
      QueryOptions(
        document: gql(getCountry),
        variables: {
          "code": code,
        },
      ),
    );

    if (result.hasException) {
      _mapJsonData(json: json, resultFetchStatus: Status.failure);
      notifyListeners();
      throw result.exception!;
    } else {
      json = result.data!["country"];
      _mapJsonData(json: json, resultFetchStatus: Status.success);
      notifyListeners();
    }
  }

  toggleShowContentFlag({required bool showMore}) {
    showMoreFlag = showMore;
    notifyListeners();
  }
}
