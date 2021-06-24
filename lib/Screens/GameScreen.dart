import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tic_tac/Models/LocalGame.dart';
import 'package:tic_tac/Screens/ScoreBoard.dart';
import 'package:tic_tac/Utilities/BoardPainter.dart';
import 'package:tic_tac/Utilities/GlobalUtils.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final LocalGame local = Get.put(LocalGame());
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
              color: Colors.red,
              size: 24,
            )),
        actions: [
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                elevation: 0, primary: Colors.transparent),
            onPressed: () {
              setState(() {
                local.clear();
              });
            },
            icon: Icon(
              Icons.refresh_sharp,
              color: Colors.blue,
            ),
            label: Text(
              "Clear",
              style: GoogleFonts.montserrat(color: Colors.blue, fontSize: 18),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          IgnorePointer(
            ignoring: (local.winstate == Wins.ONGOING) ? false : true,
            child: SizedBox(
              height: _size.height * 0.6,
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
                        if (local.board[x][y] == "")
                          setState(() {
                            if (local.cntr % 2 == 0)
                              local.board[x][y] = "O";
                            else
                              local.board[x][y] = "X";
                            local.cntr++;
                          });
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
