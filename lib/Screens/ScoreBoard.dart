import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tic_tac/Models/LocalGame.dart';
import 'package:tic_tac/Utilities/GlobalUtils.dart';
import 'package:tic_tac/Utilities/fonts.dart';

class ScoreBoard extends StatefulWidget {
  const ScoreBoard({Key? key, required this.currState, required this.cntr})
      : super(key: key);
  final Wins currState;
  final int cntr;

  @override
  _ScoreBoardState createState() => _ScoreBoardState();
}

class _ScoreBoardState extends State<ScoreBoard> {
  Color getColor(Wins state) {
    if (state == Wins.ONGOING)
      return Colors.transparent;
    else if (state == Wins.DRAW)
      return Colors.amber;
    else if (state == Wins.P1_WINS)
      return Colors.green;
    else if (state == Wins.P2_WINS) return Colors.red;
    return Colors.white;
  }

  Text getText(Wins state) {
    if (state == Wins.DRAW)
      return Text(
        "DRAW",
        style: GoogleFonts.bowlbyOne(color: Colors.white, fontSize: 38),
      );
    else if (state == Wins.P1_WINS)
      return Text(
        "O\nP1 Wins",
        style: GoogleFonts.bowlbyOne(color: Colors.white, fontSize: 38),
        textAlign: TextAlign.center,
      );
    else if (state == Wins.P2_WINS)
      return Text(
        "X\nP2 Wins",
        style: GoogleFonts.bowlbyOne(color: Colors.white, fontSize: 38),
        textAlign: TextAlign.center,
      );

    return Text(" ");
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final LocalGame local = Get.put(LocalGame());
    return AnimatedContainer(
        alignment: Alignment.center,
        width: (widget.currState == Wins.ONGOING)
            ? _size.width
            : _size.width * 0.9,
        decoration: BoxDecoration(
            color: getColor(widget.currState),
            borderRadius: BorderRadius.circular(15)),
        child: (widget.currState == Wins.ONGOING)
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "P1",
                        style: bowlbyOne.copyWith(fontSize: 48, color: Colors.green),
                      ),
                      (widget.cntr % 2 == 0)
                          ? SizedBox(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.play_arrow,
                                    color: Colors.blueAccent,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "O",
                                    style: montserrat.copyWith(
                                        fontSize: 32, color: Colors.green),
                                  )
                                ],
                              ),
                            )
                          : Container(),
                    ],
                  ),
                  Text(
                    "[ ${local.p1score} - ${local.p2score} ]",
                    style: GoogleFonts.roboto(
                        fontSize: 36,
                        color: Colors.brown,
                        fontWeight: FontWeight.bold),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "P2",
                        style: GoogleFonts.bowlbyOne(
                            fontSize: 48, color: Colors.redAccent),
                      ),
                      (widget.cntr % 2 == 1)
                          ? SizedBox(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.play_arrow,
                                    color: Colors.blueAccent,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "X",
                                    style: montserrat.copyWith(
                                        fontSize: 32, color: Colors.red),
                                  )
                                ],
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ],
              )
            : getText(widget.currState),
        duration: Duration(milliseconds: 200));
  }
}
