import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:musicapp/controllers/player_controller.dart';
import 'package:musicapp/views/player.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(PlayerController());
    return Scaffold(
        backgroundColor: const Color(0xff070011),
        appBar: AppBar(
          backgroundColor: const Color(0xff070011),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
              color: const Color(0xffFFFFff),
            )
          ],
          leading: const Icon(
            Icons.sort_rounded,
            color: Color(0xffFFFFff),
          ),
          title: const Text(
            "Beats",
            style: TextStyle(
                fontSize: 18, color: Colors.white, fontFamily: "bold"),
          ),
        ),
        body: FutureBuilder<List<SongModel>>(
            future: controller.audioQuery.querySongs(
                ignoreCase: true,
                orderType: OrderType.ASC_OR_SMALLER,
                uriType: UriType.EXTERNAL),
            builder: (BuildContext context, snapshot) {
              if (snapshot.data == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.data!.isEmpty) {
                return Center(
                  child: Text(
                    "No song found",
                    style: TextStyle(
                        fontSize: 18, color: Colors.white, fontFamily: "bold"),
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                            margin: const EdgeInsets.only(bottom: 4),
                            child: Obx(
                              () => ListTile(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                tileColor: const Color(0xff070011),
                                title: Text(
                                  snapshot.data![index].displayNameWOExt,
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontFamily: "bold"),
                                ),
                                subtitle: Text(
                                  "${snapshot.data![index].artist}",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontFamily: "regular"),
                                ),
                                leading: QueryArtworkWidget(
                                  id: snapshot.data![index].id,
                                  type: ArtworkType.AUDIO,
                                  nullArtworkWidget: const Icon(
                                    Icons.music_note,
                                    color: Colors.white,
                                    size: 32,
                                  ),
                                ),
                                trailing:
                                    controller.playerIndex.value == index &&
                                            controller.isplaying.value
                                        ? const Icon(
                                            Icons.play_arrow,
                                            color: Colors.white,
                                            size: 26,
                                          )
                                        : null,
                                onTap: () {
                                  Get.to(
                                    () => Player(data: snapshot.data!),
                                    transition: Transition.downToUp,
                                  );
                                  controller.playSong(
                                      snapshot.data![index].uri, index);
                                },
                              ),
                            ));
                      }),
                );
              }
            }));
  }
}
