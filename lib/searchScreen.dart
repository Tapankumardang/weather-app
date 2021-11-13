import 'package:flutter/material.dart';
import 'package:weather/gettingWeather.dart';
import 'package:google_fonts/google_fonts.dart';

import 'database.dart';

class SearchScreen extends StatefulWidget {
  String username = "";
  SearchScreen(this.username);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Database database = new Database();

  TextEditingController locationTextEditingController =
      new TextEditingController();

  String location = "London";
  String condition = "mostly sunny";
  bool _validate = false;
  late int temp_C, temp_F, feelsLike_C, feelsLike_F;

  String day = "Friday";

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          widget.username + ": Weather App",
          style: GoogleFonts.ubuntu(
            color: Colors.white,
          ),
        )),
      ),
      body: Container(
        width: width,
        height: height,
        color: Colors.black,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(" Enter Country name to search",
                  style: GoogleFonts.ubuntu(
                    color: Colors.white,
                    fontSize: 20,
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.amber, borderRadius: BorderRadius.circular(20)),
              width: width / 1.5,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: locationTextEditingController,
                  style: TextStyle(color: Colors.black, fontSize: 20),
                  // decoration: textFieldInputDecoration("Country Name")),
                  decoration: InputDecoration(
                    labelText: 'Enter the Counrty',
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                    errorText: _validate ? 'Value Can\'t Be Empty' : null,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height / 9.5,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  locationTextEditingController.text.isEmpty
                      ? _validate = true
                      : _validate = false;
                });
                if (_validate == false) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WeatherReport(
                              locationTextEditingController.text)));
                }
              },
              child: Container(
                alignment: Alignment.center,
                width: width / 2,
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [Color(0xff007EF4), Color(0xff2A75BC)]),
                    borderRadius: BorderRadius.circular(38)),
                child: Text(
                  "Search",
                  style: GoogleFonts.ubuntu(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
