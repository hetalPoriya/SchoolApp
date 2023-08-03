// ignore_for_file: unused_import, prefer_const_literals_to_create_immutables, unused_field, prefer_final_fields, prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:school_app/Student/profile_page.dart';
import 'package:school_app/utils/animated_navigation.dart';
import 'package:school_app/utils/widgets/custom_page.dart';
import 'package:school_app/utils/images.dart';
import 'package:school_app/utils/strings.dart';
import 'package:school_app/utils/utility.dart';

class TeacherNotification extends StatefulWidget {
  const TeacherNotification({
    Key? key,
  }) : super(key: key);

  @override
  State<TeacherNotification> createState() => _TeacherNotificationState();
}

class _TeacherNotificationState extends State<TeacherNotification> {
 
 
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
                    image: AssetImage(AssetImages.notification1),
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
          body: ListView(
            padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
            children: [
               Center(
                child: Text(
                  "Notifications",
                  style: deepPurpleStyle,
                ),
              ),
              const Divider(color: Colors.grey),
              smallSizedBox,
             
            ],
          )),
    );
  }
}