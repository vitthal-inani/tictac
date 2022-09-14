import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:tic_tac/Models/AppData.dart';
import 'package:tic_tac/Models/LocalGame.dart';
import 'package:tic_tac/Screens/ScoreBoard.dart';
import 'package:tic_tac/Utilities/BoardPainter.dart';
import 'package:tic_tac/Utilities/GlobalUtils.dart';
import 'package:tic_tac/Utilities/fonts.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  // AudioCache back = new AudioCache();
  // AudioPlayer? player;

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final LocalGame local = Get.put(LocalGame());
    // final AppData gameData = Get.put(AppData());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.close,
              color: Colors.deepOrangeAccent,
              size: 32,
            )),
        actions: [
          IconButton(
              onPressed: () {
                // AudioCache audioCache = new AudioCache(respectSilence: true);
                // audioCache.load("sounds/coins.mp3");
                // audioCache.play("sounds/coins.mp3", volume: 0.1);
                // audioCache
                // // AudioCache().play("assets/sounds/coins.mp3");
              },
              icon: Icon(Icons.speaker)),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                elevation: 0, backgroundColor: Colors.transparent),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      child: Container(
                        alignment: Alignment.center,
                        height: _size.height * 0.6,
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                        child: SizedBox(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Wrap(children: [
                                Text(
                                  "Select the player that goes first",
                                  style: montserrat.copyWith(
                                      fontSize: _size.width / 12,
                                      color: Colors.black),
                                  textAlign: TextAlign.center,
                                ),
                              ]),
                              ElevatedButton(
                                onPressed: () =>
                                    Navigator.pop(context, "Random"),
                                child: Text(
                                  "Random",
                                  style: GoogleFonts.bowlbyOne(
                                      fontSize: _size.width / 12,
                                      color: Colors.white),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ElevatedButton(
                                    onPressed: () =>
                                        Navigator.pop(context, "P1"),
                                    child: Column(
                                      children: [
                                        Text(
                                          "P1",
                                          style: GoogleFonts.bowlbyOne(
                                              fontSize: _size.width / 12,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          "O",
                                          style: GoogleFonts.bowlbyOne(
                                              fontSize: _size.width / 10,
                                              color: Colors.green),
                                        ),
                                      ],
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () =>
                                        Navigator.pop(context, "P2"),
                                    child: Column(
                                      children: [
                                        Text(
                                          "P2",
                                          style: GoogleFonts.bowlbyOne(
                                              fontSize: _size.width / 12,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          "X",
                                          style: GoogleFonts.bowlbyOne(
                                              fontSize: _size.width / 10,
                                              color: Color(0xff8B0000)),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }).then((value) {
                setState(() {
                  local.clear(value);
                });
              });
            },
            icon: Icon(
              Icons.refresh_sharp,
              color: Colors.blue,
              size: 28,
            ),
            label: Text(
              "Restart",
              style: montserrat.copyWith(color: Colors.blue, fontSize: 22),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          IgnorePointer(
            ignoring: (local.winstate == Wins.ONGOING) ? false : true,
            child: SizedBox(
              height: _size.height * 0.59,
              width: _size.width,
              child: Container(
                padding: EdgeInsets.all(20),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return GestureDetector(
                      onTapUp: (dragdetails) {
                        int x = ((3 * (dragdetails.localPosition.dy)) /
                                constraints.maxHeight)
                            .floor();
                        int y = ((3 * (dragdetails.localPosition.dx)) /
                                constraints.maxWidth)
                            .floor();
                        if (local.board[x][y] == "") {
                          setState(() {
                            if (local.cntr % 2 == 0)
                              local.board[x][y] = "O";
                            else
                              local.board[x][y] = "X";
                            local.cntr++;
                          });
                          // if (gameData.sound) {
                          //   AudioCache audioCache =
                          //       new AudioCache(respectSilence: true);
                          //   audioCache.load("sounds/coins.mp3");
                          //   audioCache.play("sounds/coins.mp3", volume: 0.1);
                          // }
                        }
                        for (int i = 0; i < 3; i++) {
                          if ((local.board[i][0] == local.board[i][1]) &&
                              (local.board[i][1] == local.board[i][2]) &&
                              (local.board[i][0] != "")) {
                            print("Row" + i.toString());
                            local.winstate = (local.board[i][0] == "O")
                                ? Wins.P1_WINS
                                : Wins.P2_WINS;
                          }
                          if ((local.board[0][i] == local.board[1][i]) &&
                              (local.board[1][i] == local.board[2][i]) &&
                              (local.board[0][i] != "")) {
                            print("Column " +
                                i.toString() +
                                " " +
                                local.board[0][1].toString());
                            local.winstate = (local.board[0][i] == "O")
                                ? Wins.P1_WINS
                                : Wins.P2_WINS;
                          }
                        }
                        if ((local.board[0][0] == local.board[1][1]) &&
                            (local.board[1][1] == local.board[2][2]) &&
                            (local.board[0][0] != ""))
                          local.winstate = (local.board[0][0] == "O")
                              ? Wins.P1_WINS
                              : Wins.P2_WINS;
                        else if ((local.board[0][2] == local.board[1][1]) &&
                            (local.board[1][1] == local.board[2][0]) &&
                            (local.board[2][0] != ""))
                          local.winstate = (local.board[0][2] == "O")
                              ? Wins.P1_WINS
                              : Wins.P2_WINS;
                        if (local.winstate == Wins.ONGOING) {
                          int emps = 0;
                          local.board.forEach((element) {
                            element.forEach((e) {
                              if (e == "") emps++;
                            });
                          });
                          if (emps == 0) local.winstate = Wins.DRAW;
                        }
                        // if (local.winstate == Wins.DRAW && gameData.sound) {
                        //   AudioCache gamEnd =
                        //       new AudioCache(respectSilence: true);
                        //   gamEnd.load("sounds/death.wav");
                        //   gamEnd.play("sounds/death.wav", volume: 0.3);
                        // } else if (local.winstate != Wins.ONGOING &&
                        //     gameData.sound) {
                        //   AudioCache gamEnd =
                        //       new AudioCache(respectSilence: true);
                        //   gamEnd.load("sounds/round_end.wav");
                        //   gamEnd.play("sounds/round_end.wav", volume: 0.1);
                        // }
                        setState(() {
                          if (local.winstate == Wins.P1_WINS)
                            local.p1score++;
                          else if (local.winstate == Wins.P2_WINS)
                            local.p2score++;
                        });

                        // print(x.toString() + " " + y.toString());
                      },
                      child: Container(
                        child: CustomPaint(
                          painter: Board(local.board),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Container(
            height: _size.height * 0.25,
            child: ScoreBoard(
              cntr: local.cntr,
              currState: local.winstate,
            ),
          )
        ],
      ),
    );
  }
}
