import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tac/Screens/ScoreBoard.dart';
import 'package:tic_tac/Utilities/BoardPainter.dart';
import 'package:tic_tac/Utilities/GlobalUtils.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List board = [
    ["", "", ""],
    ["", "", ""],
    ["", "", ""]
  ];
  int cntr = 0;
  Wins winstate = Wins.ONGOING;

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
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
              ))),
      body: Column(
        children: [
          IgnorePointer(
            ignoring: (winstate == Wins.ONGOING) ? false : true,
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
                        if (board[x][y] == "")
                          setState(() {
                            if (cntr % 2 == 0)
                              board[x][y] = "O";
                            else
                              board[x][y] = "X";
                            cntr++;
                          });
                        for (int i = 0; i < 3; i++) {
                          if ((board[i][0] == board[i][1]) &&
                              (board[i][1] == board[i][2]) &&
                              (board[i][0] != "")) {
                            print("Row" + i.toString());
                            winstate = (board[i][0] == "O")
                                ? Wins.P1_WINS
                                : Wins.P2_WINS;
                          }
                          if ((board[0][i] == board[1][i]) &&
                              (board[1][i] == board[2][i]) &&
                              (board[0][i] != "")) {
                            print("Column " +
                                i.toString() +
                                " " +
                                board[0][1].toString());
                            winstate = (board[0][i] == "O")
                                ? Wins.P1_WINS
                                : Wins.P2_WINS;
                          }
                        }
                        if ((board[0][0] == board[1][1]) &&
                            (board[1][1] == board[2][2]) &&
                            (board[0][0] != ""))
                          winstate = (board[0][0] == "O")
                              ? Wins.P1_WINS
                              : Wins.P2_WINS;
                        if ((board[0][2] == board[1][1]) &&
                            (board[1][1] == board[2][0]) &&
                            (board[2][0] != ""))
                          winstate = (board[0][2] == "O")
                              ? Wins.P1_WINS
                              : Wins.P2_WINS;
                        if (winstate == Wins.ONGOING) {
                          int emps = 0;
                          board.forEach((element) {
                            element.forEach((e) {
                              if (e == "") emps++;
                            });
                          });
                          if (emps == 0) winstate = Wins.DRAW;
                        }
                        setState(() {});
                        print(x.toString() + " " + y.toString());
                      },
                      child: Container(
                        child: CustomPaint(
                          painter: Board(board),
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
              key: Key("123"),
              cntr: cntr,
              currState: winstate,
            ),
          )
        ],
      ),
    );
  }
}
