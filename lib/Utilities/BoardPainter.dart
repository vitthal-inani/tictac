import 'package:flutter/material.dart';

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
