import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppData extends GetxController {
  bool sound = true;
  bool music =true;

  _populateSound() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("Sound") == null) {
      prefs.setBool("Sound", true);
    }
    sound = prefs.getBool("Sound")!;
  }
  _populateMusic() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("Music") == null) {
      prefs.setBool("Music", true);
    }
    music = prefs.getBool("Music")!;
  }

  AppData() {
    _populateSound();
    _populateMusic();
  }

  switchSound() async {
    sound = (sound == true) ? false : true;
    update();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("Sound", sound);
  }
  switchMusic() async {
    music = (music == true) ? false : true;
    update();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("Music", music);
  }
}
