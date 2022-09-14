import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tic_tac/Ads/BannerAd.dart';
import 'package:tic_tac/Models/AppData.dart';
import 'package:tic_tac/Screens/GameScreen.dart';
import 'package:tic_tac/Utilities/fonts.dart';
// import 'package:audioplayers/audioplayers.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeBanner homeAd = Get.put(HomeBanner());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeAd.createAnchoredBanner();
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    AppData gameData = Get.put(AppData());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              gameData.switchSound();
            },
            icon: GetBuilder<AppData>(
                init: AppData(),
                builder: (_) =>
                    Icon((_.sound) ? Icons.volume_up : Icons.volume_off)),
            color: Colors.blue,
          ),
          IconButton(
            onPressed: () {
              gameData.switchMusic();
              print(gameData.music);
            },
            icon: GetBuilder<AppData>(
                init: AppData(),
                builder: (_) => Icon((_.music)
                    ? Icons.music_note_sharp
                    : Icons.music_off_sharp)),
            color: Colors.blue,
          ),
        ],
      ),
      body: Center(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "TIC   TAC   TOE",
                  style: montserrat.copyWith(
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 8)),
                          onPressed: () async {
                            // AudioCache cache = new AudioCache();
                            // AudioPlayer player = new AudioPlayer();
                            // print(gameData.music);
                            // if (gameData.music)
                            //   player = await cache.play("sounds/backMusic.mp3",
                            //       volume: 0.1);
                            Get.to(() => GameScreen())!.then((value) {
                              // player.stop();
                              print("It All comes here");
                            });
                          },
                          child: Text(
                            "Local",
                            style: montserrat.copyWith(fontSize: 36),
                          )),
                      Spacer(
                        flex: 1,
                      ),
                      // ElevatedButton(onPressed: () {}, child: Text("Local"))
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              child: Container(
                  alignment: Alignment.bottomCenter,
                  width: _size.width,
                  height: _size.height * 0.1,
                  child: Container(
                      alignment: Alignment.bottomCenter,
                      child: AdWidget(
                        ad: homeAd.homeAd!,
                      ))),
            )
          ],
        ),
      ),
    );
  }
}
