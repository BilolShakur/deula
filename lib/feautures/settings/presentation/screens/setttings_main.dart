import 'package:deula/feautures/settings/presentation/wdigets/settings_row.dart';
import 'package:flutter/material.dart';

class SettingsMainScreen extends StatelessWidget {
  const SettingsMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

    
      body:  SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListView.builder(itemBuilder: (context, index) {
              return const SettingsRow();
            }, shrinkWrap: true, itemCount: 10,),
            SettingsRow()
          ],
        ),
      )
    );
  }
}
