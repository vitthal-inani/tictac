import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tic_tac/Screens/GameScreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "TIC   TAC   TOE",
            style: GoogleFonts.montserrat(
                fontSize: 36, fontWeight: FontWeight.bold),
          ),
          // Spacer(),
          Container(
            alignment: Alignment.bottomCenter,
            height: _size.height * 0.4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Spacer(
                  flex: 2,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 8)),
                    onPressed: () {
                      Get.to(() => GameScreen());
                    },
                    child: Text(
                      "Local",
                      style: GoogleFonts.sora(fontSize: 34),
                    )),
                Spacer(
                  flex: 1,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 8)),
                    onPressed: () {},
                    child: Text(
                      "Online",
                      style: GoogleFonts.sora(fontSize: 34),
                    )),
                // ElevatedButton(onPressed: () {}, child: Text("Local"))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
