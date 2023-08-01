import 'package:flutter/material.dart';
import 'package:json_api/local_json.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Http Json"),
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const LocalJson(),
              ),
            );
          },
          style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.deepOrange),
          ),
          child: const Text("Local Json"),
        ),
      ),
    );
  }
}
