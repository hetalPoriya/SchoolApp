// ignore_for_file: unused_import, avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:school_app/Controller/studentFeedController.dart';
import 'package:school_app/Student/profile_page.dart';
import 'package:school_app/Student/single_feed_screen.dart';
import 'package:school_app/utils/colors.dart';
import 'package:school_app/utils/constants.dart';
import 'package:school_app/utils/widgets/custom_page.dart';
import 'package:school_app/utils/images.dart';
import 'package:school_app/utils/strings.dart';
import 'package:school_app/utils/utility.dart';

import '../utils/network_handler.dart';

class Feeds extends StatefulWidget {
  const Feeds({Key? key}) : super(key: key);

  @override
  State<Feeds> createState() => _FeedsState();
}

class _FeedsState extends State<Feeds> {
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
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(days: 1),
        behavior: SnackBarBehavior.floating,
        content: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const <Widget>[
            Icon(
              Icons.signal_wifi_off,
              color: Colors.white,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 16.0,
                ),
                child: Text(
                  'No internet available',
                  textAlign: TextAlign.start,
                ),
              ),
            ),
          ],
        ),
        action: SnackBarAction(
            textColor: Colors.white, label: 'RETRY', onPressed: () async {}),
        backgroundColor: Colors.grey,
      ));
    }
  }
  final List<Map<String, dynamic>> _events = [
    {'title': 'Sakshi Sharma Class Teacher', 'Description': 'Dear Parents,\n\nGreetings of the day! \n Kindly find the attached holiday assignment.\n Thank You'
    
    },
    {'title': 'Sakshi Sharma Class Teacher', 'Description':  'Dear Parents,\n\nGreetings of the day! \n Kindly find the attached holiday assignment.\n Thank You'
    },
    {'title': 'Sakshi Sharma Class Teacher', 'Description':  'Dear Parents,\n\nGreetings of the day! \n Kindly find the attached holiday assignment.\n Thank You'
    },
    {'title': 'Sakshi Sharma Class Teacher', 'Description':  'Dear Parents,\n\nGreetings of the day! \n Kindly find the attached holiday assignment.\n Thank You'
    },
  ];
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
              "Feeds".toUpperCase(),
              style: titleTextStyle,
              // textAlign: TextAlign.start,
            ),
            divider,
            Obx(
                  () => studentFeed.isLoading ==true?
              Center(
                  child: Image.asset(
                    "assets/loading.gif",
                    height: 425.0,
                    width: 425.0,
                    fit: BoxFit.fitHeight,
                  )
              ):DefaultTabController(
                 length: 2,
                 child: Padding(
                   padding: const EdgeInsets.only(right: 5),
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.start,
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                   TabBar(
                   // ignore: prefer_const_literals_to_create_immutables
                   tabs: [
                   //Tab(text: "Events",),
                   Tab(text: "Daily feed",),
                   Tab(text: "Others",)
                   ],
                   isScrollable: true,
                   indicator: BoxDecoration(
                     color: Color.fromARGB(255, 238, 220, 241),
                     borderRadius: BorderRadius.circular(25),
                   ),
                   indicatorPadding:
                   EdgeInsets.only(top: 8, bottom: 10, left: 4, right: 4),
                   labelColor: ColorConstants.kHeadingTextColor,
                   labelStyle: TextStyle(fontSize: 15),
                   unselectedLabelColor: ColorConstants.kBlackColor,
                 ),
                 SizedBox(
                   height: MediaQuery.of(context).size.height*0.72,
                   child: MediaQuery.removePadding(
                       context: context,
                       removeTop: true,
                       child: TabBarView(
                         children: [
                           studentFeed.events.length == 0?Column(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               Image.asset("assets/no-data.gif"),
                               smallSizedBox,
                               Text("There are no event feeds", style: TextStyle(color: Colors.purple[800]),)
                             ],
                           ):
                           ListView.builder(
                             scrollDirection:Axis.vertical,
                             shrinkWrap: true,
                             itemCount: studentFeed.events.length,
                             itemBuilder: (context, index) {
                               return GestureDetector(
                                 onTap: (){
                                   Navigator.push(
                                     context,
                                     MaterialPageRoute(builder: (context) =>  SingleFeed(feed:studentFeed.events[index]))
                                   );
                                 },
                                 child: Card(
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
                                               "Daily feed",
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
                                         Text(studentFeed.events[index].title),
                                         Text(
                                           DateFormat('dd-MM-yyyy hh:mm  a')
                                               .format(studentFeed.events[index].createdAt),
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
                                         Html(data:studentFeed.events[index].message,style: {
                                           '#': Style(
                                             fontSize: FontSize(15),
                                             color: Colors.black,
                                             fontWeight: FontWeight.w400,
                                             maxLines: 2,
                                             textOverflow: TextOverflow.ellipsis,
                                           ),
                                         }, ),
                                       ],
                                     ),
                                   ),
                                 ),
                               );
                             },
                           ),
                           studentFeed.others.length == 0?
                           Column(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               Image.asset("assets/no-data.gif"),
                               smallSizedBox,
                               Text("There are no other feeds", style: TextStyle(color: Colors.purple[800]),)
                             ],
                           ):ListView.builder(
                             scrollDirection:Axis.vertical,
                             shrinkWrap: true,
                             itemCount: studentFeed.others.length,
                             itemBuilder: (context, index) {
                               return GestureDetector(
                                 onTap: (){
                                   Navigator.push(
                                     context,
                                     MaterialPageRoute(builder: (context) =>   SingleFeed(feed:studentFeed.others[index]))
                                   );
                                 },
                                 child: Card(
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
                                             Text(
                                               "Other",
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
                                         Text(studentFeed.others[index].title),
                                         Text(
                                           DateFormat('dd-MM-yyyy hh:mm  a')
                                               .format(studentFeed.others[index].createdAt),
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
                                         ),*/
                                         Html(data:studentFeed.others[index].message,style: {
                                           '#': Style(
                                             fontSize: FontSize(15),
                                             color: Colors.black,
                                             fontWeight: FontWeight.w400,
                                             maxLines: 2,
                                             textOverflow: TextOverflow.ellipsis,
                                           ),
                                         }, ),
                                       ],
                                     ),
                                   ),
                                 ),
                               );
                             },
                           ),
                         ],
                       )),
                 )
               ]
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