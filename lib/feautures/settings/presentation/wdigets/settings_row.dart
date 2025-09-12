import 'package:flutter/material.dart';

class SettingsRow extends StatelessWidget {
  const SettingsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Setting Name'),
          Switch(
            value: true,
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }
}