import 'dart:convert';
import 'package:flutter/material.dart';
import 'lugar_page.dart';
import '../classes/lugar.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Lugar>> futureLugares;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    futureLugares = fetchLugares();
  }

  Future<List<Lugar>> fetchLugares() async {
    final response =
        await http.get(Uri.parse('http://192.168.100.114:8084/lugares'));
    if (response.statusCode == 200) {
      List<dynamic> lugaresJson = jsonDecode(response.body);
      List<Lugar> lugares =
          lugaresJson.map((json) => Lugar.fromJson(json)).toList();
      return lugares;
    } else {
      throw Exception('Failed to load lugares');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Lugar>>(
        future: futureLugares,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            List<Lugar> lugares = snapshot.data!;
            return CarouselSlider.builder(
              itemCount: lugares.length,
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 0.60,
                enlargeCenterPage: true,
                enableInfiniteScroll: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentPage = index;
                  });
                },
              ),
              itemBuilder: (context, index, realIndex) {
                if (index >= 0 && index < lugares.length) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              LugarPage(lugar: lugares[index]),
                        ),
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 1.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black87,
                            blurRadius: 10.0,
                            offset: Offset(0, 5),
                          ),
                        ],
                        image: DecorationImage(
                          image: AssetImage(lugares[index].foto),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          lugares[index].nome,
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  print('Index out of bounds: $realIndex');
                  return Center(
                    child: Text('Index out of bounds'),
                  );
                }
              },
            );
          } else {
            return Center(
              child: Text('No data available'),
            );
          }
        },
      ),
    );
  }
}
