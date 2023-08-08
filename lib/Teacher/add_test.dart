// ignore_for_file: unused_import, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, unused_field, prefer_final_fields

import 'dart:io';

import 'package:better_player/better_player.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:school_app/Controller/teacherMarkAttendanceController.dart';
import 'package:school_app/Student/profile_page.dart';
import 'package:school_app/Teacher/Tests.dart';
import 'package:school_app/Teacher/upload_video.dart';
import 'package:school_app/utils/animated_navigation.dart';
import 'package:school_app/utils/colors.dart';
import 'package:school_app/utils/constants.dart';
import 'package:school_app/utils/student/app_widget.dart';
import 'package:school_app/utils/student/dropdown_widget.dart';
import 'package:school_app/utils/widgets/custom_app_bar.dart';
import 'package:school_app/utils/widgets/custom_drop_down.dart';
import 'package:school_app/utils/widgets/custom_page.dart';
import 'package:school_app/utils/images.dart';
import 'package:school_app/utils/strings.dart';
import 'package:school_app/utils/utility.dart';
import 'package:school_app/utils/widgets/form_validator.dart';
import 'package:school_app/utils/widgets/video_player.dart';

class AddTest extends StatefulWidget {
  final String? id;
  final String? name;
  const AddTest({Key? key, this.id, this.name}) : super(key: key);

  @override
  State<AddTest> createState() => _AddTestState();
}

class _AddTestState extends State<AddTest> {
  FilePickerResult? result;
  String? _fileName;
  PlatformFile? Pickedfile;
  bool isLoading = false;
  File? fileToDisplay;

  @override
  void initState() {
    teacherMarkAttendanceController.getClassesSections();
    super.initState();
  }

  void PickFile() async {
    try {
      setState(() {
        isLoading = true;
      });
      result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: false,
      );
      if (result != null) {
        _fileName = result?.files.first.name;
        Pickedfile = result!.files.first;
        fileToDisplay = File(Pickedfile!.path.toString());
      }
      setState(() {
        isLoading = false;
        _file1Controller.text = _fileName!;
      });
    } catch (e) {
      //log(e);
    }
  }

  late DateTime _dateTime;
  TextEditingController _option1Controller = TextEditingController();
  TextEditingController _questionController = TextEditingController();
  TextEditingController _file1Controller = TextEditingController();
  TextEditingController _option2Controller = TextEditingController();
  TextEditingController _file2Controller = TextEditingController();
  TextEditingController _option3Controller = TextEditingController();
  TextEditingController _file3Controller = TextEditingController();
  TextEditingController _option4Controller = TextEditingController();
  TextEditingController _file4Controller = TextEditingController();

  TextEditingController _testNameController = TextEditingController();
  TextEditingController _file5Controller = TextEditingController();
  TextEditingController _validtillController = TextEditingController();
  static var teacherMarkAttendanceController =
      Get.put(TeacherMarkAttendanceController());

  String? selectedValue2;
  List<DropdownMenuItem<String>> answer = [
    DropdownMenuItem(
      value: 'Option 1',
      child: Text('Option 1'),
    ),
    DropdownMenuItem(
      value: 'Option 2',
      child: Text('Option 2'),
    ),
    DropdownMenuItem(
      value: 'Option 3',
      child: Text('Option 3'),
    ),
    DropdownMenuItem(
      value: 'Option 4',
      child: Text('Option 4'),
    ),
  ];
  DateTime todayDate = DateTime.now();
  int currentStep = 0;

  List<Step> getSteps() => <Step>[
        Step(
            state: currentStep > 0 ? StepState.complete : StepState.indexed,
            isActive: currentStep >= 0,
            title: const Text(
              Strings.createTest,
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
            ),
            content: ListView(
              shrinkWrap: true,
              physics: AlwaysScrollableScrollPhysics(),
              children: [

                StudentAppWidgets.titleTextMarked(text: Strings.test),
                StudentAppWidgets.textFormFieldWidget(
                    hintText: Strings.inputTestName,
                    textEditingController: _testNameController),
                smallSizedBox,
                StudentAppWidgets.titleTextMarked(text: Strings.classStrings),
                DropDownWidget.classesDropDown(),
                smallSizedBox,
                StudentAppWidgets.titleTextMarked(text: Strings.subject),
                DropDownWidget.subjectDropDown(),

                smallSizedBox,
                StudentAppWidgets.titleTextMarked(text: Strings.validTill),
                StudentAppWidgets.textFormFieldWidget(
                    hintText: "dd-mm-yyyy",
                    textEditingController: _validtillController,
                    readOnly: true,
                    onTap: () => StudentAppWidgets.calenderView(
                        context: context,
                        dateTime: todayDate,
                        dateController: _validtillController)),
              ],
            )),
        Step(
            state: currentStep > 1 ? StepState.complete : StepState.indexed,
            isActive: currentStep >= 1,
            title: const Text(Strings.addQnA,
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
            content: ListView(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              children: [
                Row(
                  children: [
                    Text(
  Strings.testName,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      _testNameController.text,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                smallSizedBox,
                Row(
                  children: [
                    Text(
                      Strings.classStrings,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      teacherMarkAttendanceController.className.value ?? '',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                smallSizedBox,
                Row(
                  children: [
                    Text(
                      Strings.subject,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      teacherMarkAttendanceController.subjectName.value ?? '',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                smallSizedBox,
                Row(
                  children: [
                    Text(
                      "${Strings.validTill}:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      _validtillController.text,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                largeSizedBox,
                StudentAppWidgets.titleTextMarked(text: 'Option 1'),
                StudentAppWidgets.textFormFieldWidget(
                    hintText: 'Option 1',
                    textEditingController: _option1Controller,
                    validator: FormValidator.emptyFieldValidation(
                        value: _option1Controller.text)),
                smallerSizedBox,
                StudentAppWidgets.textFormFieldWidget(
                    hintText: Strings.noFileChosen,
                    textEditingController: _file1Controller,
                    readOnly: true,
                    onTap: () => PickFile(),
                    suffixIcon: chooseFilePrefix()),
                smallSizedBox,
                StudentAppWidgets.titleTextMarked(text: 'Option 2'),
                StudentAppWidgets.textFormFieldWidget(
                    hintText: 'Option 2',
                    textEditingController: _option2Controller,
                    validator: FormValidator.emptyFieldValidation(
                        value: _option2Controller.text)),
                smallerSizedBox,
                StudentAppWidgets.textFormFieldWidget(
                    hintText: Strings.noFileChosen,
                    textEditingController: _file2Controller,
                    readOnly: true,
                    onTap: () => PickFile(),
                    suffixIcon: chooseFilePrefix()),
                smallSizedBox,
                StudentAppWidgets.titleTextMarked(text: 'Option 3'),
                StudentAppWidgets.textFormFieldWidget(
                    hintText: 'Option 3',
                    textEditingController: _option3Controller,
                    validator: FormValidator.emptyFieldValidation(
                        value: _option3Controller.text)),
                smallerSizedBox,
                StudentAppWidgets.textFormFieldWidget(
                    hintText: Strings.noFileChosen,
                    textEditingController: _file3Controller,
                    readOnly: true,
                    onTap: () => PickFile(),
                    suffixIcon: chooseFilePrefix()),
                smallSizedBox,
                StudentAppWidgets.titleTextMarked(text: 'Option 4'),
                StudentAppWidgets.textFormFieldWidget(
                    hintText: 'Option 4',
                    textEditingController: _option4Controller,
                    validator: FormValidator.emptyFieldValidation(
                        value: _option4Controller.text)),
                smallerSizedBox,
                StudentAppWidgets.textFormFieldWidget(
                    hintText: Strings.noFileChosen,
                    textEditingController: _file4Controller,
                    readOnly: true,
                    onTap: () => PickFile(),
                    suffixIcon: chooseFilePrefix()),
                smallSizedBox,

                StudentAppWidgets.titleTextMarked(text:Strings.answer),
                CustomDropDown(
                  hintText: Strings.selectAnswer,
                  items: answer,
                  selectedValue: selectedValue2,
                  onChanged: (value) {
                    setState(() {
                      //selectedValue = value!;
                    });
                  },
                ),
                smallSizedBox,
                StudentAppWidgets.titleTextMarked(text:'${Strings.description}:'),
               StudentAppWidgets.textFormFieldWidget(hintText: Strings.description, textEditingController: _questionController,validator: FormValidator.emptyFieldValidation(value: _questionController.text)),

                smallSizedBox,
                StudentAppWidgets.titleText(text: Strings.uploadFile),
                StudentAppWidgets.textFormFieldWidget(
                    hintText: Strings.noFileChosen,
                    textEditingController: _file5Controller,
                    readOnly: true,
                    onTap: () => PickFile(),
                    suffixIcon: chooseFilePrefix()),

              ],
            )),
        Step(
            isActive: currentStep >= 2,
            title: const Text(Strings.assignStudents,
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
            content: Center(
              child: Text(Strings.assignStudents),
            ))
      ];
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
            onPressed: () =>
                AnimatedNavigation.pushReplacementAnimatedNavigation(
                    context, TeacherTest()),
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
        body: Padding(
          padding:
              const EdgeInsets.only(top: 20, bottom: 10, left: 10, right: 10),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             StudentAppWidgets.titleTextHeading(title: Strings.createTest),
              Expanded(
                child: Theme(
                  data: Theme.of(context).copyWith(
                      colorScheme: ColorScheme.light(primary: Colors.deepPurple)),
                  child: Stepper(
                    elevation: 0,
                    physics: ScrollPhysics(),
                    type: StepperType.horizontal,
                    steps: getSteps(),
                    currentStep: currentStep,
                    onStepContinue: () {
                      final isLastStep = currentStep == getSteps().length - 1;
                      if (isLastStep) {
                      } else {
                        setState(() => currentStep += 1);
                      }
                    },
                    onStepTapped: (step) => setState(() => currentStep = step),
                    onStepCancel: currentStep == 0
                        ? null
                        : () => setState(() => currentStep -= 1),
                    // controlsBuilder: (context, {onStepContinue, onStepCancel}) {
                    //   Row(
                    //     children: [
                    //       Expanded(
                    //         child: ElevatedButton(onPressed: onStepContinue,
                    //          child:Text("Next"),
                    //          ),
                    //       ),
                    //         Expanded(
                    //           child: ElevatedButton(onPressed: onStepCancel,
                    //                                    child:Text("Back"),
                    //                                    ),
                    //         ),
                    //     ],
                    //   ),
                    // },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  chooseFilePrefix() => Container(
        width: 90,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          border: Border.all(color: Colors.grey),
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(5.0), bottomRight: Radius.circular(8)),
        ),
        child: const Center(
          child: Text('Choose file'),
        ),
      );
}