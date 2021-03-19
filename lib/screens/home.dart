import 'package:flutter/material.dart';
import './settings.dart';
import '../models/report.dart';
import 'package:provider/provider.dart';
import '../services/firestore_service.dart';
import 'package:intl/intl.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var reports = Provider.of<List<Report>>(context);
    FirestoreService _db = FirestoreService();
    return Scaffold(
      appBar: AppBar(
        title: Text('Wax App'),
        actions: [
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.of(context).pushNamed(SettingsScreen.routeName);
              }),
        ],
      ),
      body: ListView.builder(
          itemCount: reports != null ? reports.length : 0,
          itemBuilder: (context, index) {
            Report report = reports[index];
            return ListTile(
              leading: Text(report.temp.toString()),
              title: Text(report.wax),
              subtitle: Text(report.line),
              trailing: Text(DateFormat('dd/MM/yyyy')
                  .format(DateTime.parse(report.timeStamp))
                  .toString()),
            );
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          _db.addReport();
        },
      ),
    );
  }
}
