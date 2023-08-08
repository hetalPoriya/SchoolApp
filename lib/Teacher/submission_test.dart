// ignore_for_file: unused_import, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:better_player/better_player.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:school_app/Student/profile_page.dart';
import 'package:school_app/Teacher/upload_video.dart';
import 'package:school_app/Teacher/viewsubmitted_test.dart';
import 'package:school_app/utils/animated_navigation.dart';
import 'package:school_app/utils/colors.dart';
import 'package:school_app/utils/constants.dart';
import 'package:school_app/utils/widgets/custom_page.dart';
import 'package:school_app/utils/images.dart';
import 'package:school_app/utils/strings.dart';
import 'package:school_app/utils/utility.dart';
import 'package:school_app/utils/widgets/video_player.dart';

class SubmissionTest extends StatefulWidget {
  final String? id;
  final String? name;
  const SubmissionTest({Key? key, this.id, this.name}) : super(key: key);

  @override
  State<SubmissionTest> createState() => _SubmissionTestState();
}

class _SubmissionTestState extends State<SubmissionTest> {
  DateTime todayDate = DateTime.now();

  get betterPlayerConfiguration => null;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        backgroundColor: Colors.grey[50],
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
          toolbarHeight: 150,
          centerTitle: true,
          flexibleSpace: ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(90),
              // bottomRight: Radius.circular(20)
            ),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AssetImages.view),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          backgroundColor: Colors.deepPurple,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(90),
              // bottomRight: Radius.circular(40),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 10,right: 10,left: 10),
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Text(Strings.viewTestSubmissions, style: titleTextStyle)),
                smallSizedBox,
                // Text(
                //   DateFormat('dd MMMM yyyy').format(DateTime.now()),
                //   style: textButtonTextStyle,
                // ),
                divider,
                smallSizedBox,
                Row(
                  children: [
                    Text(
                      Strings.testName,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Test 1",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                
                largeSizedBox,
                Expanded(
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return Card(
                          color: ColorConstants.kGreyColor100,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                         Strings.sNo,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        ),
                                         Text("${index +1}"),
                                      ],
                                    ),
                                  
                                    Row(
                                      children: [
                                        const Text(
                                          Strings.studentName,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        ),
                                        const Text(" Amar"),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          Strings.classStrings,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        ),
                                        const Text(" I"),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          Strings.section,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        ),
                                        const Text(" A"),
                                       
                                      ],
                                    ),
                                   
                                  ],
                                ),
                                //const SizedBox(height: 30),
                                Column(
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    const Text(
                                  Strings.action,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                   InkWell(
                                    onTap: ()=>AnimatedNavigation.pushAnimatedNavigation(context, ViewSubmittedTest()),
                                     child: const Icon(Icons.remove_red_eye,
                                     size: 20,
                                     color: Colors.pink,),
                                   )
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}