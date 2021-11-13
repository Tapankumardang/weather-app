import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather/database.dart';
import 'package:weather/weatherScreen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class WeatherReport extends StatefulWidget {
  String country;
  WeatherReport(this.country);

  @override
  _WeatherReportState createState() => _WeatherReportState();
}

class _WeatherReportState extends State<WeatherReport> {
  Database database = new Database();

  String location = "London";
  String error = "";
  String condition = "mostly sunny";
  // String temp_C = "70";
  late int temp_C, temp_F, feelsLike_C, feelsLike_F;

  // String temp_F = "20";
  // String feelsLike_C = "73";
  // String feelsLike_F = "20";
  String day = "Friday";
  @override
  void initState() {
    weatherConnection();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        color: Colors.black,
        height: height,
        width: width,
        child: Center(
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 250,
                ),
                Text("Loading...",
                    style: GoogleFonts.ubuntu(
                      color: Colors.white,
                      fontSize: 50,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //connecting to weather API
  weatherConnection() async {
    String location = "";
    String weatherUrl =
        "http://api.weatherapi.com/v1/current.json?key=df59eb1569994de282c112235211011&q=" +
            widget.country +
            "&aqi=no";

    final response = await http.get(Uri.parse(weatherUrl));
    if (response.statusCode == 400) {
      print("country not found");
      Fluttertoast.showToast(
          msg: "Please enter correct Counrty name",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.pop(context);
    }
    if (response.statusCode == 200) {
      // print(response.body);
      final data2 = jsonDecode(response.body);

      print(data2);
      final Map<String, dynamic> data = jsonDecode(response.body);
      double temp;

      print("connection success");
      print(response.body.toString());
      setState(() {
        location = data2["location"]["name"];
        String _date = data2["location"]["localtime"].toString();
        condition = data2["current"]["condition"]["icon"];
        temp = (data2["current"]["temp_c"]);
        temp_C = temp.round();

        temp = data2["current"]["temp_f"];
        temp_F = temp.round();
        temp = data2["current"]["feelslike_c"];
        feelsLike_C = temp.round();
        temp = data2["current"]["feelslike_f"];
        feelsLike_F = temp.round();
        print(data2);
        print("location=" + location);
        print("location=" + _date);
        print("condition=" + condition);
        // print("temp in c =" + temp_C);
        print("temp in c =" + temp_C.toString());

        print("temp in f=" + temp_F.toString());
        print("feels like in c=" + feelsLike_C.toString());
        print("feels like in f=" + feelsLike_F.toString());

        DateTime now = DateTime.now();
        DateTime date = new DateFormat("yyyy-MM-dd HH:mm").parse(_date);
        day = DateFormat('EEEE').format(date);
        print(day);

        //inserting in the database

        database.connection(location, widget.country);

        //navigating to the weatherReport Screen
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => WeatherScreen(location, condition, temp_C,
                    temp_F, feelsLike_C, feelsLike_F, day)));
      });
    } else {
      print("connection failed");
      print(response.body);
    }
  }
}
