// ignore_for_file: unused_import, prefer_const_constructors

import 'dart:developer';

import 'package:better_player/better_player.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:school_app/Student/profile_page.dart';
import 'package:school_app/Teacher/upload_video.dart';
import 'package:school_app/utils/animated_navigation.dart';
import 'package:school_app/utils/colors.dart';
import 'package:school_app/utils/constants.dart';
import 'package:school_app/utils/student/app_widget.dart';
import 'package:school_app/utils/widgets/custom_page.dart';
import 'package:school_app/utils/images.dart';
import 'package:school_app/utils/strings.dart';
import 'package:school_app/utils/utility.dart';
import 'package:school_app/utils/widgets/teacher_youtube_video_player.dart';
import 'package:school_app/utils/widgets/video_player.dart';

import '../Controller/videoController.dart';
import '../utils/network_handler.dart';
import '../utils/widgets/youtube_video_player.dart';

class TeacherVideo extends StatefulWidget {
  final String? id;
  final String? name;
  const TeacherVideo({Key? key, this.id, this.name}) : super(key: key);

  @override
  State<TeacherVideo> createState() => _TeacherVideoState();
}

class _TeacherVideoState extends State<TeacherVideo> {
  DateTime todayDate = DateTime.now();


  var videoController = Get.put(VideoController());
  NetworkHandler nr = NetworkHandler();
  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() async {
    bool isConnected = await nr.checkConnectivity();

    if (isConnected) {
      videoController.getTeacherVideos();
    } else {
     StudentAppWidgets.noInternetAvailable(context: context);
    }
  }

  get betterPlayerConfiguration => null;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            alignment: Alignment.topLeft,
            icon: const Icon(
              Icons.arrow_back,
              size: 35,
              color: Colors.white,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          automaticallyImplyLeading: false,
          toolbarHeight: 150,
          centerTitle: true,
          flexibleSpace: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(90),
              //bottomRight: Radius.circular(20),
            ),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AssetImages.youtubeVideo),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          backgroundColor: Colors.deepPurple,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(90),
              // bottomRight: Radius.circular(40),
            ),
          ),
        ),
        body: Obx(() => videoController.isLoading == true
            ? StudentAppWidgets.loadingWidget()
            : DefaultTabController(
                length: videoController.videos.length,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 60, bottom: 10, left: 15, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      smallSizedBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(Strings.videos.toUpperCase(), style: titleTextStyle),
                          // SvgPicture.asset(AssetImages.search, height: 25),
                          ElevatedButton(
                            onPressed: () =>
                                AnimatedNavigation.pushAnimatedNavigation(
                                    context, UploadVideo()),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              primary: Colors.deepPurple,
                            ),
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 18.0,
                                ),
                                Text(
                                  Strings.addNewVideo,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      divider,
                      smallSizedBox,
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: videoController.status == Strings.videosNotFound
                            ? StudentAppWidgets.noDataFound(text: Strings.videosNotFound)
                            : TabBar(
                                // ignore: prefer_const_literals_to_create_immutables
                                tabs: [
                                  for (var entry
                                      in videoController.videos.entries)
                                    Tab(
                                      text: entry.key,
                                    )
                                ],
                                isScrollable: true,
                                indicator: BoxDecoration(
                                  color: Color.fromARGB(255, 238, 220, 241),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                indicatorPadding: EdgeInsets.only(
                                    top: 8, bottom: 10, left: 4, right: 4),
                                labelColor: ColorConstants.kHeadingTextColor,
                                labelStyle: mediumStyle,
                                unselectedLabelColor:
                                    ColorConstants.kBlackColor,
                              ),
                      ),
                      const SizedBox(height: 10),
                      buildTabBarView(),
                    ],
                  ),
                ),
              )),
      ),
    );
    //   ),
    // );
  }

  buildTabBarView() {
    for (var entry in videoController.videos.entries)
      log('entry ${entry.value}');
    return Obx(() => videoController.isLoading == true
        ? StudentAppWidgets.loadingWidget()
        : Expanded(
            child: TabBarView(
              key: ValueKey(DateTime.now().toString()),
              //physics: const NeverScrollableScrollPhysics(),
              children: [
                for (var entry in videoController.videos.entries)
                  entry.value.length == 0
                      ? StudentAppWidgets.noDataFound(text: Strings.videosNotFound)

                      : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 12,crossAxisSpacing: 12),
                    shrinkWrap: true,

                    physics: const ClampingScrollPhysics(),
                    itemCount: entry.value.length,
                    itemBuilder: (context, index) =>   videoWidget(index: index, entry: entry))

              ],
            ),
          ));
  }

  videoWidget({required int index, required MapEntry entry }){
    return  InkWell(
        onTap: () {
          AnimatedNavigation.pushAnimatedNavigation(
            context,
            TeacherYoutubeVideoPlayer(
              url: entry.value[index]["video_link"],
              index: index,
              value: entry.key,
            ),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            smallerSizedBox,
            Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius:
                  BorderRadius.circular(12.0),
                  child: Image.asset(
                    AssetImages.english,
                    fit: BoxFit.fill,
                    height: 120,

                  ),
                ),
                Image.asset(
                  AssetImages.videoIcon,
                ),
              ],
            ),
            smallSizedBox,
            Text(
              "  ${entry.value[index]["video_description"]}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
              ),
            ),
          ],
        ));
  }



}