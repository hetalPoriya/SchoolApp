// ignore_for_file: unused_import, prefer_const_literals_to_create_immutables, unused_field, prefer_final_fields, unnecessary_null_comparison, non_constant_identifier_names

import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:school_app/Controller/submitAssignmentController.dart';
import 'package:school_app/Model/assignmentModel.dart';
import 'package:school_app/Student/profile_page.dart';
import 'package:school_app/utils/animated_navigation.dart';
import 'package:school_app/utils/network_handler.dart';
import 'package:school_app/utils/student/app_widget.dart';
import 'package:school_app/utils/widgets/custom_page.dart';
import 'package:school_app/utils/images.dart';
import 'package:school_app/utils/strings.dart';
import 'package:school_app/utils/utility.dart';

import '../Controller/assignmentController.dart';
import 'assignments.dart';

class SubmitAssignment extends StatefulWidget {
  final int? id;
  const SubmitAssignment({
    Key? key,
    this.id,
  }) : super(key: key);

  @override
  State<SubmitAssignment> createState() => _SubmitAssignmentState();
}

class _SubmitAssignmentState extends State<SubmitAssignment> {
  TextEditingController _fileController = TextEditingController();
  TextEditingController? _classController;
  TextEditingController? _subjectController;
  TextEditingController? _sectionController;
  TextEditingController? _expiredateController;
  TextEditingController? _titleController;
  TextEditingController? _descriptionController = TextEditingController();
  late DateTime _dateTime;

  FilePickerResult? result;
  var _fileName = <String>[];
  PlatformFile? Pickedfile;
  bool isLoading = false;
  var fileToDisplay = <File>[];
  String? setFileName = "";
  var submitAssignmentController = Get.put(SubmitAssignmentController());
  NetworkHandler nr = NetworkHandler();

  @override
  void initState() {
    // TODO: implement initState
    log(assignmentController.pending_assignments[widget.id!].id);
    _titleController = TextEditingController(
        text: '${assignmentController.pending_assignments[widget.id!].title}');
    _classController = TextEditingController(
        text:
            '${assignmentController.pending_assignments[widget.id!].className}');
    _subjectController = TextEditingController(
        text:
            '${assignmentController.pending_assignments[widget.id!].subjectName}');
    _sectionController = TextEditingController(
        text:
            '${assignmentController.pending_assignments[widget.id!].sectionName}');
    _expiredateController = TextEditingController(
        text: DateFormat('dd-MM-yyyy').format(
            assignmentController.pending_assignments[widget.id!].expireAt));
    super.initState();
  }

  void PickFile() async {
    try {
      setState(() {
        isLoading = true;
      });
      result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: true,
      );

      setState(() {
        if (result != null) {
          result?.files.forEach((element) {
            try {
              //log(element.name);
              _fileName.add(element.name.toString());
              fileToDisplay.add(File(element.path!));
            } catch (e) {
              log("Something went wrong : $e");
            }
          });
        }
        //fileToDisplay.forEach((element) { log(element.path.split('/').last);});
        setFileName = _fileName.join(",");
        //log('File Name $setFileName');
        isLoading = false;
        _fileController.text = setFileName!;
      });
    } catch (e) {
      //log(e);
    }
  }

  var assignmentController = Get.put(AssignmentController());

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        titleWidget: const Text(
          Strings.submitAssignment,
          style: TextStyle(
              color: Colors.deepPurple,
              fontWeight: FontWeight.bold,
              fontSize: 20),
        ),
        automaticallyImplyLeading: false,
        child: ListView(
          padding: const EdgeInsets.only(bottom: 10, top: 70),
          children: [
            const Divider(color: Colors.grey),
            smallSizedBox,
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Row(
                children: [
                  const Text(
                    "${Strings.title}:",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            TextField(
                //enabled: false,
                readOnly: true,
                controller: _titleController,
                //initialValue: assignmentController.pending_assignments[widget.id!].title,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  hintText: (Strings.assignmentTitle),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  isDense: true,
                )),
            smallSizedBox,
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: [
                  const Text(
                    "${Strings.subjects}:",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            TextField(
                //enabled: false,
                readOnly: true,
                controller: _subjectController,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  hintText: (Strings.subject),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  isDense: true,
                )),
            smallSizedBox,
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: [
                  const Text(
                    Strings.classStrings,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            TextField(
                //enabled: false,
                readOnly: true,
                controller: _classController,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  hintText: Strings.classStrings,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  isDense: true,
                )),
            smallSizedBox,
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: [
                  const Text(
                    Strings.section,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            TextField(
                readOnly: true,
                controller: _sectionController,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  hintText: Strings.section,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  isDense: true,
                )),
            smallSizedBox,
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: const Text(
                Strings.uploadImage,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            SizedBox(
              height: 35,
              child: TextField(
                  onTap: () {
                    PickFile();
                  },
                  controller: _fileController,
                  readOnly: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                    hintText: ("       No File Chosen"),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: Container(
                        width: 80,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          border: Border.all(color: Colors.grey),
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(5.0),
                              bottomRight: Radius.circular(5)),
                        ),
                        child: const Center(
                          child: Text(Strings.chooseFile),
                        ),
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    isDense: true,
                  )),
            ),
            smallSizedBox,
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Row(
                children: [
                  const Text(
                    "${Strings.description}:",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  const Icon(
                    Icons.star,
                    size: 8,
                    color: Colors.red,
                  )
                ],
              ),
            ),
            TextField(
                controller: submitAssignmentController.decriptionController,
                keyboardType: TextInputType.multiline,
                maxLines: 2,
                cursorWidth: 2.0,
                // textAlign: TextAlign.left,
                decoration: const InputDecoration(
                  hintText: Strings.description,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  //isDense: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                )),
            smallSizedBox,
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: const Text(
                Strings.expireDate,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            TextField(
                controller: _expiredateController,
                readOnly: true,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  isDense: true,
                )),
            largeSizedBox,
            smallSizedBox,
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 50, right: 50),
                child: ElevatedButton(
                  onPressed: () async {
                    //NetworkHandler.postForm(fileToDisplay, "submit_assignment", assignmentController.pending_assignments[widget.id!].id);
                    bool isConnected = await nr.checkConnectivity();
                    if (isConnected) {
                      await submitAssignmentController.setvalues(
                          assignmentController
                              .pending_assignments[widget.id!].id,
                          fileToDisplay);
                      await submitAssignmentController.submitAssi();
                      SchedulerBinding.instance.addPostFrameCallback((_) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content:
                                Text(submitAssignmentController.status.value)));
                        Get.off(const Assignments(
                          name: "Assignments",
                        ));
                      });
                    } else {
                     StudentAppWidgets.noInternetAvailable(context: context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    primary: const Color.fromRGBO(105, 80, 255, 1.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        Strings.submit,
                        style: TextStyle(fontSize: 12),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Obx(
                        () => Visibility(
                            visible: submitAssignmentController.isLoading.value,
                            child: const SizedBox(
                                height: 15,
                                width: 15,
                                child: const CircularProgressIndicator(
                                  color: Colors.white,
                                ))),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}