// // ignore_for_file: unused_import
// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:school_app/Controller/teacherEventController.dart';
import 'package:school_app/Student/event_details.dart';
import 'package:school_app/Student/profile_page.dart';
import 'package:school_app/Teacher/home.dart';
import 'package:school_app/utils/animated_navigation.dart';
import 'package:school_app/utils/colors.dart';
import 'package:school_app/utils/constants.dart';
import 'package:school_app/utils/student/app_widget.dart';
import 'package:school_app/utils/widgets/custom_page.dart';
import 'package:school_app/utils/images.dart';
import 'package:school_app/utils/strings.dart';
import 'package:school_app/utils/utility.dart';
import 'package:school_app/utils/widgets/widgets.dart';

class TeacherParticularEvent extends StatefulWidget {
  final int id;
  const TeacherParticularEvent({Key? key, required this.id}) : super(key: key);

  @override
  State<TeacherParticularEvent> createState() => _TeacherParticularEventState();
}

class _TeacherParticularEventState extends State<TeacherParticularEvent> {
  var teacherEventController = Get.put(TeacherEventController());
  DateTime todayDate = DateTime.now();
  final DateFormat formatter = DateFormat('EEEE');
  final DateFormat formatter1 = DateFormat('dMMMM');

  @override
  void initState() {
    teacherEventController.teacherViewEvent();
    super.initState();
  }

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
            onPressed: () =>Get.back(),
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
                  image: AssetImage(AssetImages.activity2),
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
          padding: const EdgeInsets.only(
            top: 20,
            left: 10,
            right: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Events List",
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    decorationThickness: 2.0,
                    decorationStyle: TextDecorationStyle.solid,
                    // wordSpacing: 8,
                    //letterSpacing: 2,
                    // ignore: prefer_const_literals_to_create_immutables
                    // shadows: [
                    //   Shadow(
                    //       color: Colors.black,
                    //       blurRadius: 2.0,
                    //       offset: Offset(3, 1))
                    // ]
                  ),
                ),
              ),

              Expanded(
                child: StudentAppWidgets.eventCardDetails(title: teacherEventController.eventList[widget.id].title,
                    eventDate:
                    teacherEventController.eventList[widget.id].eventDate,
                    description: teacherEventController
                        .eventList[widget.id].description),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}