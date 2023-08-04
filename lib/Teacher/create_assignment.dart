// ignore_for_file: unused_import, prefer_const_literals_to_create_immutables, unused_field, prefer_final_fields, unnecessary_null_comparison, non_constant_identifier_names, prefer_const_constructors

import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:school_app/Controller/TeacherNewMsgController.dart';
import 'package:school_app/Controller/assignmentController.dart';
import 'package:school_app/Controller/teacherMarkAttendanceController.dart';
import 'package:school_app/Model/teacherClassesSectionsModel.dart';
import 'package:school_app/Student/profile_page.dart';
import 'package:school_app/utils/animated_navigation.dart';

import 'package:school_app/utils/student/app_widget.dart';
import 'package:school_app/utils/student/dropdown_widget.dart';
import 'package:school_app/utils/widgets/custom_drop_down.dart';
import 'package:school_app/utils/widgets/custom_page.dart';
import 'package:school_app/utils/images.dart';
import 'package:school_app/utils/strings.dart';
import 'package:school_app/utils/utility.dart';
import 'package:school_app/utils/widgets/form_validator.dart';
import 'package:school_app/utils/widgets/widgets.dart';

class CreateAssignment extends StatefulWidget {
  const CreateAssignment({
    Key? key,
  }) : super(key: key);

  @override
  State<CreateAssignment> createState() => _CreateAssignmentState();
}

class _CreateAssignmentState extends State<CreateAssignment> {
  String? classValue;
  String? subjectValue;
  String? sectionValue;

  String? statusValue = 'Active';
  List<String> status = [
    'Active',
    'Disabled',
  ];

  var teacherMarkAttendanceController =
      Get.put(TeacherMarkAttendanceController());

  var assignmentController =
      Get.put(AssignmentController());

  TextEditingController _urlController = TextEditingController();
  TextEditingController _fileController = TextEditingController();
  TextEditingController _expiredateController = TextEditingController(text: DateFormat("dd-MM-yyyy").format(DateTime.now()));
  TextEditingController _dateController = TextEditingController(text: DateFormat("dd-MM-yyy").format(DateTime.now()));
  TextEditingController _titleController = TextEditingController();
  TextEditingController _studentController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  DateTime todayDate = DateTime.now();


  FilePickerResult? result;
  String? _fileName;
  PlatformFile? Pickedfile;
  bool isLoading = false;
  File? fileToDisplay;
  bool? isImage;

  ClassesSection? selectedValue;

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

        log('File Nmae $_fileName');
        log('File Nmae $Pickedfile');
        log('File Nmae $fileToDisplay');
      }
      setState(() {
        isLoading = false;
        if(_fileName.toString().contains('.jpg') || _fileName.toString().contains('.png')){
          log('enter');
          isImage= true;
        }else{
          isImage = false;
        }
        _fileController.text = _fileName!;
      });
    } catch (e) {
      //log(e);
    }
  }

  @override
  void initState() {

    teacherMarkAttendanceController.getClassesSections();
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
                    image: AssetImage(AssetImages.create1),
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
          body: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
              children: [
                Center(
                  child: Text("Create Assignment", style: deepPurpleStyle),
                ),
                smallSizedBox,
                StudentAppWidgets.titleTextMarked(text: 'Title:'),
                StudentAppWidgets.textFormFieldWidget(
                    hintText: "Assignment Title",
                    validator: FormValidator.emptyFieldValidation(value: _titleController.text),
                    textEditingController: _titleController),
                smallSizedBox,
                StudentAppWidgets.titleTextMarked(text: 'Class:'),
                DropDownWidget.classesDropDown(),
                smallSizedBox,
                StudentAppWidgets.titleTextMarked(text: 'Section:'),
                DropDownWidget.sectionDropDown(),
                smallSizedBox,
                StudentAppWidgets.titleTextMarked(text: 'Subject:'),
                DropDownWidget.subjectDropDown(),
                smallSizedBox,

                StudentAppWidgets.titleText(text:   "Link:",),
                StudentAppWidgets.textFormFieldWidget(hintText: "Link", textEditingController: _urlController),

                smallSizedBox,
                StudentAppWidgets.titleTextMarked(text: "Descriptions:"),
                StudentAppWidgets.textFormFieldWidget(hintText: "Description", textEditingController: _descriptionController,validator: FormValidator.emptyFieldValidation(value: _descriptionController.text),),

                smallSizedBox,
                StudentAppWidgets.titleText(text: 'Schedule Date'),
                StudentAppWidgets.textFormFieldWidget(hintText:'Schedule Date' , textEditingController: _dateController,readOnly: true,onTap:() =>
                 StudentAppWidgets.calenderView(context: context,dateTime: todayDate,dateController: _dateController)
                 ),

                smallSizedBox,
                StudentAppWidgets.titleText(text:  "Expire Date",),
                StudentAppWidgets.textFormFieldWidget(hintText:'Expire Date' , textEditingController: _expiredateController,readOnly: true,onTap:() =>  StudentAppWidgets.calenderView(context: context,dateTime: todayDate,dateController: _expiredateController)
                 ),

                smallSizedBox,
                StudentAppWidgets.titleText(text:  "Status:"),
              CustomDropDown(    items: status
                  .map((status) => DropdownMenuItem<String>(
                value: status,
                child: Text(
                  status,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ))
                  .toList(),
                hintText: 'Select Status',
                onChanged: ( value) {
               setState(() {
                 statusValue = value!;
               });
                },),
                smallSizedBox,
                StudentAppWidgets.titleText(text: 'Upload Image:'),

                StudentAppWidgets.textFormFieldWidget(hintText: "No File Chosen", textEditingController: _fileController,suffixIcon: GestureDetector(
                  onTap: (){
                    PickFile();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Container(
                      width: 90,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        border: Border.all(color: Colors.grey),
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(5.0),
                            bottomRight: Radius.circular(5)),
                      ),
                      child: const Center(
                        child: Text('Choose file'),
                      ),
                    ),
                  ),
                ),),


                largeSizedBox,
                smallSizedBox,
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 50, right: 50),
                    child: ElevatedButton(
                      onPressed: () {

                        if(_formKey.currentState!.validate()){
                          assignmentController.createTeacherAssignment(title: _titleController.value.text,description: _descriptionController.value.text,date: _dateController.value.text,expireDate: _expiredateController.value.text,link: _urlController.value.text,activeStatus: statusValue
                            ,file: fileToDisplay?.path,path: _fileController.value.text,isImage: isImage);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        maximumSize: Size(150, 50),
                        minimumSize: Size(150, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        primary: const Color.fromRGBO(105, 80, 255, 1.0),
                      ),
                      child: const Text(
                        "Add",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                ),
                smallSizedBox,
              ],
            ),
          ),
        ));
  }
}