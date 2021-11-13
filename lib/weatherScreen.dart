import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WeatherScreen extends StatefulWidget {
  String location;
  String condition;
  late int temp_C, temp_F, feelsLike_C, feelsLike_F;
  String day;
  String trim = ".";
  WeatherScreen(this.location, this.condition, this.temp_C, this.temp_F,
      this.feelsLike_C, this.feelsLike_F, this.day);

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  TextEditingController country = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Wether App",),
      // ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/sunny_day.png"),
                fit: BoxFit.cover)),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                width: width,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        size: 50,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ),
                height: height / 9.8,
              ),
              Text(
                widget.location,
                style: TextStyle(fontSize: 50, color: Colors.white),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(),
                height: 100,
                width: 100,
                child: Image.network(
                  "http:" + widget.condition,
                  fit: BoxFit.fill,
                ),
              ),
              Text(
                widget.temp_C.toString() + "℃",
                style: TextStyle(fontSize: 70, color: Colors.white),
              ),
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              widget.day,
                              style:
                                  TextStyle(fontSize: 25, color: Colors.white),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 120),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Today",
                              style: TextStyle(
                                  fontSize: 25, color: Colors.white54),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              widget.feelsLike_C.toString(),
                              style: TextStyle(
                                  fontSize: 25, color: Colors.white54),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 70),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              widget.feelsLike_F.toString(),
                              style:
                                  TextStyle(fontSize: 25, color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
//Testing

}
