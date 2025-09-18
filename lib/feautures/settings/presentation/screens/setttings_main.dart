import 'package:deula/feautures/settings/presentation/wdigets/settings_row.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(child: SafeArea(child: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            SettingsRow()
          ],
        
          
        ),
      ))),
    );
  }
}