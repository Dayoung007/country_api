import 'package:flutter/material.dart';

class CountryInput extends StatelessWidget {
  // final String fetchByCountry;
  final TextEditingController countryController;
  final Function(String?) theCountryCall;

  const CountryInput(
      {Key? key,
      // required this.fetchByCountry,
      required this.countryController,
      required this.theCountryCall})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      child: TextField(
        controller: countryController,
        onSubmitted: (String value) {
          // fetchByCountry;
        },
        onChanged: (value) {
          theCountryCall(value);
        },
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16.0,
          height: 1.0,
        ),
        decoration: const InputDecoration(
          filled: true,
          fillColor: Colors.white,
          icon: Icon(Icons.search),
          hintText: 'Enter City',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(34.0),
            ),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
