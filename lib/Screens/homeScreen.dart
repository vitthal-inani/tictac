import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tic_tac/Screens/GameScreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "TIC   TAC   TOE",
            style: GoogleFonts.montserrat(fontSize: 36, fontWeight: FontWeight.bold),
          ),
          // Spacer(),
          Column(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(

                ),
                  onPressed: () {
                    Get.to(() => GameScreen());
                  },
                  child: Text("Local")),
              ElevatedButton(onPressed: () {}, child: Text("Online")),
              ElevatedButton(onPressed: () {}, child: Text("Local"))
            ],
          ),
        ],
      ),
    );
  }
}
