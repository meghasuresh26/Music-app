import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicapp/controllers/player_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Player extends StatelessWidget {
  final List<SongModel> data;
  const Player({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<PlayerController>();
    return Scaffold(
        backgroundColor: const Color(0xff070011),
        appBar: AppBar(),
        body: Padding(
          padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
          child: Column(children: [
            Obx(
              () => Expanded(
                  child: Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                height: 300,
                width: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),
                alignment: Alignment.center,
                child: QueryArtworkWidget(
                  id: data[controller.playerIndex.value].id,
                  type: ArtworkType.AUDIO,
                  artworkHeight: double.infinity,
                  artworkWidth: double.infinity,
                  nullArtworkWidget: const Icon(
                    Icons.music_note,
                    size: 48,
                    color: Colors.white,
                  ),
                ),
              )),
            ),
            SizedBox(
              height: 12,
            ),
            Expanded(
                child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                    ),
                    child: Obx(() => Column(
                          children: [
                            Text(
                              data[controller.playerIndex.value]
                                  .displayNameWOExt,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize: 24,
                                  color: const Color(0xff070011),
                                  fontFamily: "bold"),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Text(
                              data[controller.playerIndex.value]
                                  .artist
                                  .toString(),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize: 20,
                                  color: const Color(0xff070011),
                                  fontFamily: "regular"),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Obx(() => Row(children: [
                                  Text(
                                    controller.position.value,
                                    style: TextStyle(
                                        fontSize: 24,
                                        color: const Color(0xff070011),
                                        fontFamily: "bold"),
                                  ),
                                  Expanded(
                                    child: Slider(
                                      thumbColor:
                                          Color.fromRGBO(126, 112, 255, 1),
                                      inactiveColor: Color(0xff070011),
                                      activeColor: Color(0xff7E70FF),
                                      min: Duration(seconds: 0)
                                          .inSeconds
                                          .toDouble(),
                                      max: controller.max.value,
                                      value: controller.value.value,
                                      onChanged: (newValue) {
                                        controller.changeDurationToSeconds(
                                            newValue.toInt());
                                        newValue = newValue;
                                      },
                                    ),
                                  ),
                                  Text(
                                    controller.duration.value,
                                    style: TextStyle(
                                        fontSize: 24,
                                        color: const Color(0xff070011),
                                        fontFamily: "bold"),
                                  ),
                                ])),
                            SizedBox(
                              height: 12,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      controller.playSong(
                                          data[controller.playerIndex.value - 1]
                                              .uri,
                                          controller.playerIndex.value - 1);
                                    },
                                    icon: Icon(
                                      Icons.skip_previous_rounded,
                                      size: 40,
                                      color: Color(0xff070011),
                                    )),
                                Obx(
                                  () => CircleAvatar(
                                    radius: 35,
                                    backgroundColor: Color(0xff070011),
                                    child: Transform.scale(
                                      scale: 2.5,
                                      child: IconButton(
                                          onPressed: () {
                                            if (controller.isplaying.value) {
                                              controller.audioPlayer.pause();
                                              controller.isplaying(false);
                                            } else {
                                              controller.audioPlayer.play();
                                              controller.isplaying(true);
                                            }
                                          },
                                          icon: controller.isplaying.value
                                              ? const Icon(
                                                  Icons.pause,
                                                  color: Colors.white,
                                                  // size: 54,
                                                )
                                              : const Icon(
                                                  Icons.play_arrow_rounded,
                                                  color: Colors.white,
                                                )),
                                    ),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      controller.playSong(
                                          data[controller.playerIndex.value + 1]
                                              .uri,
                                          controller.playerIndex.value + 1);
                                    },
                                    icon: Icon(
                                      Icons.skip_next_rounded,
                                      size: 40,
                                      color: Color(0xff070011),
                                    )),
                              ],
                            )
                          ],
                        ))))
          ]),
        ));
  }
}
