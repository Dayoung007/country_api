import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

import 'input_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String country = '';

  bool isLoading = true;
  String selectedProperty = 'All Region';
  String urlChange = 'https://restcountries.com/v3.1/all';
  String countryName = '';

  List<dynamic> countryData = [];
  TextEditingController countryController =
      TextEditingController();

  void getSearch() {
    if (countryController.text.isNotEmpty) {
      setState(() {
        countryName = countryController.text;
      });
    }
  }

  getCountriesRegion() {
    if (selectedProperty == 'Africa') {
      setState(() {
        urlChange =
            'https://restcountries.com/v3.1/region/africa';
      });
    } else if (selectedProperty == 'Europe') {
      setState(() {
        urlChange =
            'https://restcountries.com/v3.1/region/europe';
      });
    } else if (selectedProperty == 'Oceania') {
      setState(() {
        urlChange =
            'https://restcountries.com/v3.1/region/oceania';
      });
    } else if (selectedProperty == 'Asia') {
      setState(() {
        urlChange =
            'https://restcountries.com/v3.1/region/asia';
      });
    } else {
      setState(() {
        urlChange = 'https://restcountries.com/v3.1/all';
      });
    }
  }

  Future<void> getCountry() async {
    try {
      setState(() {
        isLoading = true;
      });

      String url = urlChange;

      http.Response response =
          await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        String data = response.body;

        print('API Response: $data');

        print("success ${response.statusCode}");

        setState(() {
          country = jsonDecode(data)[0]['name']['common'];
          countryData = jsonDecode(data);
          isLoading = false;
        });
      } else {
        print(
            'Failed to load weather data. Status Code: ${response.statusCode}');

        print(" error ${response.statusCode}");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getCountryByRegion() async {
    try {
      setState(() {
        isLoading = true;
      });

      String url = urlChange;

      http.Response response =
          await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        String data = response.body;

        print('API Response: $data');

        print("success ${response.statusCode}");

        setState(() {
          country = jsonDecode(data)[0]['name']['common'];
          countryData = jsonDecode(data);
          isLoading = false;
        });
      } else {
        print(
            'Failed to load weather data. Status Code: ${response.statusCode}');

        print(" error ${response.statusCode}");
      }
    } catch (e) {
      print(e);
    }
  }

  List<Widget> getContainer() {
    List<Widget> containerList = [];

    for (int i = 0; i < countryData.length; i++) {
      String countryName = countryData[i]['name']['common'];
      String region = countryData[i]['region'];
      var cityCapital = countryData[i]['capital'];
      var population = countryData[i]['population'];
      var flag = countryData[i]['flags']['png'];

      var newItem = Container(
        margin: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
          color: Color(0xffc1cecc),
        ),
        child: Column(
          children: [
            Image.network(flag.toString()),
            Container(
              margin: const EdgeInsets.all(16.0),
              height: 200,
              width: double.maxFinite,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    countryName,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 22,
                    ),
                  ),
                  Row(
                    children: [
                      const Text(
                        'Capital',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Text(
                        '$cityCapital ',
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Region',
                        softWrap: true,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Text(
                        region,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Population',
                        softWrap: true,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Text(
                        population.toString(),
                        softWrap: true,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );

      containerList.add(newItem);
    }
    return containerList;
  }

  @override
  void initState() {
    super.initState();
    getCountry();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Country App'),
        ),
      ),
      body: ListView(
        children: [
          CountryInput(
            countryController: countryController,
            theCountryCall: (value) {
              getSearch();
              print(value);
            },
            // fetchByCountry: getSearch()
          ),
          Container(
            color: Color(0xff02ffe5),
            padding: const EdgeInsets.all(16),
            child: DropdownButton<String>(
                value: selectedProperty,
                items: const [
                  DropdownMenuItem(
                    value: 'All Region',
                    child: Text('All Region'),
                  ),
                  DropdownMenuItem(
                    value: 'Africa',
                    child: Text('Africa'),
                  ),
                  DropdownMenuItem(
                    value: 'America',
                    child: Text('America'),
                  ),
                  DropdownMenuItem(
                    value: 'Asia',
                    child: Text('Asia'),
                  ),
                  DropdownMenuItem(
                    value: 'Europe',
                    child: Text('Europe'),
                  ),
                  DropdownMenuItem(
                    value: 'Oceania',
                    child: Text('Oceania'),
                  )
                ],
                onChanged: (value) {
                  setState(() {
                    selectedProperty = value!;
                    getCountriesRegion()!;
                    getCountry();
                  });
                  print(value);
                  print(urlChange);
                }),
          ),
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
                color: Color(0xff02ffe5)),
            child: isLoading
                ? Center(
                    child: Container(
                      height: 720,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: Color(0xff02ffe5)),
                      child: const Center(
                        child: SpinKitFadingCircle(
                          color: Colors.white,
                          size: 48.0,
                        ),
                      ),
                    ),
                  )
                : Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: getContainer(),
                  ),
          ),
        ],
      ),
    );
  }
}
