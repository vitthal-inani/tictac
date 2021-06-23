import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tac/Screens/ScoreBoard.dart';

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

class Board extends CustomPainter {
  final List board;

  Board(this.board);

  @override
  void paint(Canvas canvas, Size size) {
    var paintGrid = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2;

    var paintX = Paint()
      ..color = Colors.redAccent
      ..strokeWidth = 4;

    var paintO = Paint()
      ..color = Colors.green
      ..strokeWidth = 2;

    var paintbase = Paint()
      ..color = Colors.white
      ..strokeWidth = 2;
    // TODO: implement paint
    canvas.drawLine(Offset(size.width * (1 / 3), 0),
        Offset(size.width * (1 / 3), size.height), paintGrid);
    canvas.drawLine(Offset(size.width * (2 / 3), 0),
        Offset(size.width * (2 / 3), size.height), paintGrid);
    canvas.drawLine(Offset(0, size.height * (1 / 3)),
        Offset(size.width, size.height * (1 / 3)), paintGrid);
    canvas.drawLine(Offset(0, size.height * (2 / 3)),
        Offset(size.width, size.height * (2 / 3)), paintGrid);
    for (int l1 = 0; l1 < board.length; l1++) {
      for (int l2 = 0; l2 < board[l1].length; l2++) {
        if (board[l1][l2] == "")
          continue;
        else if (board[l1][l2] == "O") {
          canvas.drawCircle(
              Offset(size.width * (((2 * l2) + 1) / 6),
                  size.height * (((2 * l1) + 1) / 6)),
              25,
              paintO);
          canvas.drawCircle(
              Offset(size.width * (((2 * l2) + 1) / 6),
                  size.height * (((2 * l1) + 1) / 6)),
              20,
              paintbase);
        } else if (board[l1][l2] == "X") {
          canvas.drawLine(
              Offset(size.width * (((3 * l2) + 1) / 9),
                  size.height * (((3 * l1) + 1) / 9)),
              Offset(size.width * (((3 * l2) + 2) / 9),
                  size.height * (((3 * l1) + 2) / 9)),
              paintX);

          canvas.drawLine(
              Offset(size.width * (((3 * l2) + 2) / 9),
                  size.height * (((3 * l1) + 1) / 9)),
              Offset(size.width * (((3 * l2) + 1) / 9),
                  size.height * (((3 * l1) + 2) / 9)),
              paintX);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

enum Wins {
  ONGOING,
  P1_WINS,
  P2_WINS,
  DRAW,
}
