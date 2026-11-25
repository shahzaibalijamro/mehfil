import 'package:flutter/material.dart';

class GuestSettingsScreen extends StatelessWidget {
  const GuestSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [Center(child: CircleAvatar(child: Text("Guset")))],
      ),
    );
  }
}
