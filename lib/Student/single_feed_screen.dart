// ignore_for_file: unused_import, avoid_unnecessary_containers, prefer_const_constructors

import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:school_app/Controller/studentFeedController.dart';
import 'package:school_app/Student/profile_page.dart';
import 'package:school_app/utils/colors.dart';
import 'package:school_app/utils/constants.dart';
import 'package:school_app/utils/student/app_widget.dart';
import 'package:school_app/utils/widgets/custom_page.dart';
import 'package:school_app/utils/images.dart';
import 'package:school_app/utils/strings.dart';
import 'package:school_app/utils/utility.dart';

import '../utils/network_handler.dart';

class SingleFeed extends StatefulWidget {
  final dynamic feed;
  const SingleFeed({Key? key, required this.feed,}) : super(key: key);

  @override
  State<SingleFeed> createState() => _SingleFeedState();
}

class _SingleFeedState extends State<SingleFeed> {

  var studentFeed = Get.put(StudentFeedController());
  NetworkHandler nr = NetworkHandler();
  @override
  void initState() {
    _init();

    super.initState();
  }

  _init() async {
    bool isConnected = await nr.checkConnectivity();

    if (isConnected) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        studentFeed.getStuFeed();
      });
    }
    else{
     StudentAppWidgets.noInternetAvailable(context: context);
    }
  }

  DateTime todayDate = DateTime.now();
  final DateFormat formatter = DateFormat('EEEE');
  final DateFormat formatter1 = DateFormat('dMMMM');
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      automaticallyImplyLeading: false,
      child: Padding(
        padding: const EdgeInsets.only(top: 60,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Strings.feeds.toUpperCase(),
              style: titleTextStyle,
              // textAlign: TextAlign.start,
            ),
            divider,
            Obx(
                    () => studentFeed.isLoading ==true?
               StudentAppWidgets.loadingWidget():studentFeed.events.length == 0?StudentAppWidgets.noDataFound(text: Strings.thereAreNoEventFeeds):
                    Card(
                      color: ColorConstants.kGreyColor100,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                /*Text(
                                             "Event",
                                             style: TextStyle(
                                                 color: Colors.black, fontWeight: FontWeight.bold),
                                           ),*/
                                Text(
                                  Strings.dailyFeed,
                                  style: TextStyle(
                                      color: Colors.black, fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(7.0),
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius:
                                      BorderRadius.circular(50.0)),
                                ),
                              ],
                            ),
                            smallSizedBox,
                            Text(widget.feed.title),
                            Text(
                              DateFormat('dd-MM-yyyy  hh:mm  a')
                                  .format(widget.feed.createdAt),
                              style: TextStyle(color: Colors.grey),
                            ),
                            smallSizedBox,
                            /*Row(
                                         // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                         children: [
                                           GestureDetector(
                                               onTap: (){},
                                               child: Image.asset(AssetImages.pdfFile,height: 20,width: 20,scale: 2.0,)),
                                           SizedBox(width: 4,),
                                           Text("Holiday Assignment LKG.pdf"),
                                         ],
                                       ),
                                       const SizedBox(height: 30),*/
                            Html(data:widget.feed.message,style: {
                              '#': Style(
                                fontSize: FontSize(15),
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                maxLines: null,
                           
                              ),
                            }, ),
                          ],
                        ),
                      ),
                    )),
            const SizedBox(
              height: 10,
            ),
            // Padding(
            //   padding: const EdgeInsets.only(bottom: 400),
            //   child: ListView.builder(
            //     shrinkWrap: true,
            //     itemCount: _events.length,
            //     itemBuilder: (context, index) {
            //       return Card(
            //         color: ColorConstants.kGreyColor100,
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(10),
            //         ),
            //         child: Padding(
            //           padding: const EdgeInsets.all(10.0),
            //           child: Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               Text(
            //                 _events[index]['title'],
            //                 style: TextStyle(
            //                     color: Colors.black, fontWeight: FontWeight.bold),
            //               ),
            //               smallSizedBox,
            //               Text(
            //                 DateFormat('dd-MM-yyyy      hh:mm:ss')
            //                     .format(DateTime.now()),
            //                 style: TextStyle(color: Colors.grey),
            //               ),

            //               const SizedBox(height: 30),
            //               Text(
            //                 _events[index]['Description'],
            //               ),
            //             ],
            //           ),
            //         ),
            //       );
            //     },
            //   ),
            // ),
            // const TabBar(
            //   tabs: [
            //     Tab(
            //       text: "News & Events",
            //     ),
            //     Tab(
            //       text: "others",
            //     ),
            //   ],
            // isScrollable: true,
            //   labelColor: ColorConstants.kBlackColor,
            //   labelStyle: TextStyle(fontSize: 18),
            //   unselectedLabelColor: ColorConstants.kBlackColor,

            // ),
            // const SizedBox(height: 10),
            // buildTabBarView(),
          ],
        ),
      ),
    );
    //   ),
    // );
  }
}

//   buildTabBarView() {
//     return SizedBox(
//       height: MediaQuery.of(context).size.height -
//           MediaQuery.of(context).size.height * 0.35,
//       child: MediaQuery.removePadding(
//         context: context,
//         removeTop: true,
//         child: TabBarView(
//           key: ValueKey(DateTime.now().toString()),
//           physics: const NeverScrollableScrollPhysics(),
//           children: [
//             ListView.builder(
//               shrinkWrap: true,
//               itemCount: _events.length,
//               itemBuilder: (context, index) {
//                 return Card(
//                   color: ColorConstants.kGreyColor100,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           _events[index]['title'],
//                           style: TextStyle(
//                               color: Colors.black, fontWeight: FontWeight.bold),
//                         ),
//                         smallSizedBox,
//                         Text(
//                           DateFormat('dd-MM-yyyy      hh:mm:ss')
//                               .format(DateTime.now()),
//                           style: TextStyle(color: Colors.grey),
//                         ),
//                         const SizedBox(height: 30),
//                         Text(
//                           _events[index]['Description'],
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//             ListView.builder(
//               shrinkWrap: true,
//               itemCount: _events.length,
//               itemBuilder: (context, index) {
//                 return Card(
//                   color: ColorConstants.kGreyColor100,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           _events[index]['title'],
//                           style: TextStyle(
//                               color: Colors.black, fontWeight: FontWeight.bold),
//                         ),
//                         smallSizedBox,
//                         Text(
//                           DateFormat('dd-MM-yyyy      hh:mm:ss')
//                               .format(DateTime.now()),
//                           style: TextStyle(color: Colors.grey),
//                         ),
//                         const SizedBox(height: 30),
//                         Text(
//                           _events[index]['Description'],
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }