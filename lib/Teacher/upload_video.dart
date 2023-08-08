// ignore_for_file: unused_import, prefer_const_literals_to_create_immutables, unused_field, prefer_final_fields, prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:school_app/Controller/uploadVideoController.dart';
import 'package:school_app/Student/profile_page.dart';
import 'package:school_app/Teacher/video.dart';
import 'package:school_app/utils/animated_navigation.dart';
import 'package:school_app/utils/student/app_widget.dart';
import 'package:school_app/utils/student/dropdown_widget.dart';
import 'package:school_app/utils/widgets/custom_page.dart';
import 'package:school_app/utils/images.dart';
import 'package:school_app/utils/strings.dart';
import 'package:school_app/utils/utility.dart';
import 'package:multiselect/multiselect.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:school_app/utils/widgets/form_validator.dart';
import 'package:school_app/utils/widgets/widgets.dart';

import '../utils/network_handler.dart';

class UploadVideo extends StatefulWidget {
  const UploadVideo({
    Key? key,
  }) : super(key: key);

  @override
  State<UploadVideo> createState() => _UploadVideoState();
}

class _UploadVideoState extends State<UploadVideo> {
  String? selectedValue;
  List<String> items = [
    'I',
    'II',
    'III',
  ];
  String? selectedValue1;
  List<String> multiSelectedValue = [];
  List<String> subject = [
    'Php',
    'Python',
    'Java',
  ];
  String? selectedValue2;
  List<String> student = [
    'Amar',
    'Select Student',
  ];
  List? _myStudents;

  TextEditingController _urlController = TextEditingController();
  TextEditingController _studentController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  DateTime todayDate = DateTime.now();
  var uploadVideoController = Get.put(UploadVideoController());
  NetworkHandler nr = NetworkHandler();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _init();
    _myStudents = [];
    super.initState();
  }

  _init() async {
    bool isConnected = await nr.checkConnectivity();

    if (isConnected) {
      uploadVideoController.isSubjectVisible(false);
      uploadVideoController.getClass();
    } else {
     StudentAppWidgets.noInternetAvailable(context: context);
    }
  }

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
                    image: AssetImage(AssetImages.upload),
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
          body: Obx(() => uploadVideoController.isLoading == true
              ? StudentAppWidgets.loadingWidget()
              : Form(
            key: _formKey,
                  child: ListView(
                    padding:
                        const EdgeInsets.only(top: 20, left: 15, right: 15),
                    children: [
                      Center(
                        child: Text(
                          Strings.uploadVideo,
                          style: deepPurpleStyle,
                        ),
                      ),
                      const Divider(color: Colors.grey),
                      smallSizedBox,
                      StudentAppWidgets.titleTextMarked(text: Strings.classStrings),
                      DropDownWidget.teacherClassesDropDown(),
                      Visibility(
                        visible: uploadVideoController.isSubjectVisible.value,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            smallSizedBox,
                            StudentAppWidgets.titleText(text: Strings.subject),
                            DropDownWidget.getSubjectFromClassesDropDown(),
                          ],
                        ),
                      ),
                      smallSizedBox,
                      StudentAppWidgets.titleText(text: Strings.videoUrl),
                      StudentAppWidgets.textFormFieldWidget(
                          hintText: 'Enter URL',
                          textEditingController:
                              uploadVideoController.videoUrlController,validator: FormValidator.emptyFieldValidation(value: uploadVideoController.videoUrlController.text)),
                      Visibility(
                          visible: uploadVideoController.isSubjectVisible.value,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              smallSizedBox,
                              MultiSelectFormField(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 0.5),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                autovalidate: AutovalidateMode.disabled,
                                chipBackGroundColor: Colors.grey,
                                chipLabelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Roboto',
                                    color: Colors.white),
                                dialogTextStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Roboto',
                                ),
                                checkBoxActiveColor: Colors.blue,
                                checkBoxCheckColor: Colors.white,
                                dialogShapeBorder: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(12.0))),
                                title: Text(
                                  Strings.students,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.length == 0) {
                                    return 'Please select one or more students';
                                  }
                                  return null;
                                },
                                dataSource: [
                                  for (var i in uploadVideoController.students)
                                    {
                                      "display": "${i.studentName}",
                                      "value": "${i.studentId}",
                                    },
                                ],
                                textField: 'display',
                                valueField: 'value',
                                okButtonLabel: 'OK',
                                cancelButtonLabel: 'CANCEL',
                                hintWidget: Text(Strings.pleaseChooseOneOrMore),
                                initialValue: _myStudents,
                                onSaved: (value) {
                                  if (value == null) return;
                                  uploadVideoController.studentIdList(value);
                                  setState(() {
                                    _myStudents = value;
                                  });
                                },
                              ),
                            ],
                          )),
                      smallSizedBox,
                      StudentAppWidgets.titleText(text: "${Strings.description}:"),
                      StudentAppWidgets.textFormFieldWidget(
                        hintText: Strings.description,
                        textEditingController:
                            uploadVideoController.videoDescController,
                        validator: FormValidator.emptyFieldValidation(value: uploadVideoController.videoDescController.text)
                      ),
                      largeSizedBox,
                      smallSizedBox,
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(width: 20,),
                            Expanded(
                                child: StudentAppWidgets
                                    .elevatedButtonWithVisibility(
                              context: context,
                              isVisible:
                                  uploadVideoController.isUploadLoading.value,
                              text: Strings.submit,
                              onPressed: () async {
                                bool isConnected = await nr.checkConnectivity();
                                if (isConnected) {

                                if(_formKey.currentState!.validate()){
                                  await uploadVideoController.uploadVideo();
                                  SchedulerBinding.instance
                                      .addPostFrameCallback((_) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(uploadVideoController
                                                .status.value)));
                                    Get.off(const TeacherVideo(
                                      name: Strings.video,
                                    ));
                                  });
                                }
                                } else {
                                 StudentAppWidgets.noInternetAvailable(context: context);
                                }
                              },
                            )),
                            SizedBox(width: 20,),
                            Expanded(
                              child: StudentAppWidgets.elevatedButton(
                                  context: context,
                                  text: Strings.close,
                                  onPressed: () => Navigator.of(context).pop()),
                            ),
            SizedBox(width: 20,),
                          ],
                        ),
                      ),
                    ],
                  ),
                ))),
    );
  }
}