import 'package:flutter/material.dart';

class Home2 extends StatefulWidget {
  const Home2({super.key});

  @override
  State<Home2> createState() => _Home2State();
}

class _Home2State extends State<Home2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff070011),
      appBar: AppBar(
        backgroundColor: const Color(0xff070011),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
            color: const Color(0xffFFFFff),
          )
        ],
        leading: const Icon(
          Icons.sort_rounded,
          color: Color(0xffFFFFff),
        ),
        title: const Text(
          "Beats",
          style:
              TextStyle(fontSize: 18, color: Colors.white, fontFamily: "bold"),
        ),
      ),
    );
  }
}
