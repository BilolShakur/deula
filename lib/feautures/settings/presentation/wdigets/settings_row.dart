import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsRow extends StatefulWidget {
  const SettingsRow({super.key});

  @override
  State<SettingsRow> createState() => _SettingsRowState();
}

class _SettingsRowState extends State<SettingsRow> {
  bool isDarkMode = false;
  String selectedLang = 'en';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Theme",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            Spacer(),
            Text(isDarkMode ? "Dark" : "Light"),
            CupertinoSwitch(
              value: isDarkMode,
              onChanged: (value) {
                setState(() {
                  isDarkMode = value;
                  // TODO: Connect to app theme logic
                });
              },
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Text(
              "Language",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            Spacer(),
            DropdownButton<String>(
              value: selectedLang,
              items: const [
                DropdownMenuItem(value: 'en', child: Text('English')),
                DropdownMenuItem(value: 'uz', child: Text('Uzbek')),
                DropdownMenuItem(value: 'ru', child: Text('Russian')),
              ],
              onChanged: (value) {
                setState(() {
                  selectedLang = value!;
                  // TODO: Connect to app language logic
                });
              },
            ),
          ],
        ),
        SizedBox(height: 20),
        Container(height: 1, width: double.infinity, color: Colors.grey.withOpacity(0.5)),
      ],
    );
  }
}