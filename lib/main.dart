import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'biodata_page.dart'; // Import halaman biodata

void main() => runApp(FoodFinderApp());

class FoodFinderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FoodFinder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => FoodFinderHomePage(),
        '/biodata': (context) => BiodataPage(),
      },
    );
  }
}

class FoodFinderHomePage extends StatefulWidget {
  @override
  _FoodFinderHomePageState createState() => _FoodFinderHomePageState();
}

class _FoodFinderHomePageState extends State<FoodFinderHomePage> {
  List<dynamic> _meals = [];
  String _searchKeyword = '';
  bool _isLoading = false;

  Future<void> _searchMeals() async {
    setState(() {
      _isLoading = true;
    });

    String apiUrl =
        'https://www.themealdb.com/api/json/v1/1/search.php?s=$_searchKeyword';
    var response = await http.get(Uri.parse(apiUrl));
    var data = json.decode(response.body);

    setState(() {
      _isLoading = false;
      _meals = data['meals'] ?? [];
    });
  }

  Widget _buildMealList() {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (_meals.isEmpty) {
      return Center(
        child: Text('Data tidak ditemukan.'),
      );
    } else {
      return Expanded(
        child: ListView.builder(
          itemCount: _meals.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(_meals[index]['strMeal']),
              subtitle: Text(_meals[index]['strCategory']),
              leading: Image.network(_meals[index]['strMealThumb']),
              onTap: () {
                _showMealDetails(_meals[index]);
              },
            );
          },
        ),
      );
    }
  }

  void _showMealDetails(dynamic meal) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(meal['strMeal']),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(meal['strMealThumb']),
                SizedBox(height: 10.0),
                Text('Category: ${meal['strCategory']}'),
                SizedBox(height: 10.0),
                Text('Instructions: ${meal['strInstructions']}'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  void _navigateToBiodataPage() {
    Navigator.pushNamed(context, '/biodata');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FoodFinder'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchKeyword = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Cari Makanan',
                suffixIcon: IconButton(
                  onPressed: _searchMeals,
                  icon: Icon(Icons.search),
                ),
              ),
            ),
          ),
          _buildMealList(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToBiodataPage,
        child: Icon(Icons.person),
      ),
    );
  }
}
