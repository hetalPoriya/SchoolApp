// ignore_for_file: unused_import, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, unused_field, prefer_final_fields

import 'dart:io';

import 'package:better_player/better_player.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:school_app/Controller/teacherEventController.dart';
import 'package:school_app/Student/profile_page.dart';
import 'package:school_app/Teacher/Tests.dart';
import 'package:school_app/Teacher/upload_video.dart';
import 'package:school_app/utils/animated_navigation.dart';
import 'package:school_app/utils/colors.dart';
import 'package:school_app/utils/constants.dart';
import 'package:school_app/utils/student/app_widget.dart';
import 'package:school_app/utils/widgets/custom_app_bar.dart';
import 'package:school_app/utils/widgets/custom_drop_down.dart';
import 'package:school_app/utils/widgets/custom_page.dart';
import 'package:school_app/utils/images.dart';
import 'package:school_app/utils/strings.dart';
import 'package:school_app/utils/utility.dart';
import 'package:school_app/utils/widgets/form_validator.dart';
import 'package:school_app/utils/widgets/video_player.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({
    Key? key,
  }) : super(key: key);

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {

  final _formKey = GlobalKey<FormState>();

  DateTime todayDate = DateTime.now();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  var teacherEventController = Get.put(TeacherEventController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          leading: IconButton(
            alignment: Alignment.topLeft,
            icon: Icon(
              Icons.arrow_back,
              size: 35,
              color: Colors.black,
            ),
            onPressed: () => Get.back(),
          ),

          // automaticallyImplyLeading: true,
          toolbarHeight: 180,
          centerTitle: true,
          flexibleSpace: ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(90),
              // bottomRight: Radius.circular(20)
            ),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(AssetImages.test), fit: BoxFit.fill),
              ),
            ),
          ),
          backgroundColor: Colors.deepPurple,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(90),
              // bottomRight: Radius.circular(20),
            ),
          ),
        ),
        // extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding:
                const EdgeInsets.only(top: 20, bottom: 10, left: 15, right: 15),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  StudentAppWidgets.titleTextHeading(title: Strings.createEvent),
                  divider,
                  smallSizedBox,
                  StudentAppWidgets.titleTextMarked(text: Strings.eventTitle),
                  StudentAppWidgets.textFormFieldWidget(
                      hintText: Strings.eventTitle,
                      textEditingController: _titleController,

                      validator: FormValidator.emptyFieldValidation(
                          value: _titleController.text)),
                  smallSizedBox,
                  StudentAppWidgets.titleTextMarked(text: Strings.eventDescription),
                  StudentAppWidgets.textFormFieldWidget(
                      hintText: Strings.eventDescription,
                      textEditingController: _descriptionController,

                      validator: FormValidator.emptyFieldValidation(
                          value: _descriptionController.text)),
                  smallSizedBox,
                  StudentAppWidgets.titleText(text: Strings.scheduleDate),
                  StudentAppWidgets.textFormFieldWidget(hintText:Strings.scheduleDate , textEditingController: _dateController,readOnly: true,validator: FormValidator.emptyFieldValidation(value: _dateController.text),onTap:() =>
                      StudentAppWidgets.calenderView(context: context,dateTime: todayDate,dateController: _dateController)
                  ),

                  largerSizedBox,
              Obx(() => StudentAppWidgets.elevatedButtonWithVisibility(context: context, isVisible: teacherEventController.isLoading.value, text: 'Add Event', onPressed: (){
                if(_formKey.currentState!.validate()){
                  teacherEventController.teacherAddEvent(title: _titleController.text, description: _descriptionController.text, date: _dateController.text);
                }
              })),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}