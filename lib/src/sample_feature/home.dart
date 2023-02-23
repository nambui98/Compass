import 'package:compass_1/src/sample_feature/clock_sample.dart';
import 'package:compass_1/src/sample_feature/compass.dart';
import 'package:compass_1/src/sample_feature/sample_item_list_view.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          InkWell(
            onTap: () {
              Navigator.restorablePushNamed(
                context,
                ClockFirstPage.routeName,
              );
            },
            child: Text("Clock"),
          ),
          InkWell(
            onTap: () {
              Navigator.restorablePushNamed(
                context,
                ComPassPage.routeName,
              );
            },
            child: Text("Compass"),
          ),
          InkWell(
            onTap: () {
              Navigator.restorablePushNamed(
                context,
                SampleItemListView.routeName,
              );
            },
            child: Text("Listview"),
          )
        ]),
      ),
    );
  }
}
