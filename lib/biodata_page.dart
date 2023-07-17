import 'package:flutter/material.dart';

class BiodataPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Biodata'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nama: Adryan Syah',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              'NIM : 201552018152793',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10.0),
            Text(
              'Prodi : Teknik Informatika',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10.0),
            Text(
              'Mata Kuliah : SA Mobile',
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
