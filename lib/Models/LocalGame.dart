import 'package:get/get.dart';
import 'package:tic_tac/Utilities/GlobalUtils.dart';
import 'dart:math';

class LocalGame extends GetxController {
  List board = [
    ["", "", ""],
    ["", "", ""],
    ["", "", ""]
  ];
  int cntr = 0;
  Wins winstate = Wins.ONGOING;
  int p1score = 0;
  int p2score = 0;

  void clear(String player) {
    board = [
      ["", "", ""],
      ["", "", ""],
      ["", "", ""]
    ];
    cntr = (player == "P1")
        ? 0
        : (player == "P2")
            ? 1
            : Random().nextInt(10) % 2;
    winstate = Wins.ONGOING;
  }
}
