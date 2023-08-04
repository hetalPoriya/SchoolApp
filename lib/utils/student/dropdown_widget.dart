import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_app/Controller/teacherMarkAttendanceController.dart';
import 'package:school_app/Model/getSubjectByClass.dart';
import 'package:school_app/Model/teacherClassesSectionsModel.dart';


class DropDownWidget {

  static List<String> statusModel = [
    'Active',
    'Disabled',
  ];
  static String statusValue = 'Active';

  static var teacherMarkAttendanceController =
      Get.put(TeacherMarkAttendanceController());

  static inputDec({required String hintText}) => InputDecoration(
      focusColor: Colors.white,
      contentPadding: const EdgeInsets.all(12.0),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey, width: 0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey, width: 0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey, width: 0.5),
        borderRadius: BorderRadius.circular(20),
      ),

      hintText: hintText,
  );


  static classesDropDown() => Obx(() => DropdownButtonFormField<ClassesSection>(
        decoration: inputDec(hintText: 'Select Class'),
        value: teacherMarkAttendanceController.classValue,
        onChanged: (ClassesSection? newValue) {
          teacherMarkAttendanceController.classValue = newValue!;
        },
        items: teacherMarkAttendanceController.classesSections == []
            ? []
            : List.generate(
                teacherMarkAttendanceController.classesSections.length,
                (index) {
                return DropdownMenuItem<ClassesSection>(
                  value: teacherMarkAttendanceController.classesSections[index],
                  child: Row(
                    children: [
                      Text(
                        teacherMarkAttendanceController
                            .classesSections[index].className
                            .toString(),
                      ),
                    ],
                  ),
                  onTap: () async {
                    log('class id${teacherMarkAttendanceController.classesSections[index].classId}');
                    log('class id${teacherMarkAttendanceController.classesSections[index].className}');

                    teacherMarkAttendanceController.classId.value =
                        teacherMarkAttendanceController
                            .classesSections[index].classId;
                    teacherMarkAttendanceController.className.value =
                        teacherMarkAttendanceController
                            .classesSections[index].className
                            .toString();
                    teacherMarkAttendanceController.getSubjectByClassSection();
                  },
                );
              }),
      ));

  static sectionDropDown() => Obx(() => DropdownButtonFormField<ClassesSection>(
        decoration: inputDec(hintText: 'Select Class'),
        value: teacherMarkAttendanceController.sectionValue,
        onChanged: (ClassesSection? newValue) {
          teacherMarkAttendanceController.sectionValue = newValue!;
        },
        items: teacherMarkAttendanceController.classesSections == []
            ? []
            : List.generate(
            teacherMarkAttendanceController.classesSections.length,
                (index) {
              return DropdownMenuItem<ClassesSection>(
                value: teacherMarkAttendanceController.classesSections[index],
                child: Row(
                  children: [
                    Text(
                      teacherMarkAttendanceController
                          .classesSections[index].sectionName
                          .toString(),
                    ),
                  ],
                ),
                onTap: () async {


                  teacherMarkAttendanceController.sectionId.value =
                      teacherMarkAttendanceController
                          .classesSections[index].sectionId;
                  teacherMarkAttendanceController.sectionName.value =
                      teacherMarkAttendanceController
                          .classesSections[index].sectionName
                          .toString();
                },
              );
            }),
      ));

  static subjectDropDown() => Obx(() => DropdownButtonFormField<Subject>(
    decoration: inputDec(hintText: 'Select Subject'),
    value: teacherMarkAttendanceController.subjectValue,
    onChanged: (Subject? newValue) {
      teacherMarkAttendanceController.subjectValue = newValue!;
    },
    items: teacherMarkAttendanceController.subject == []
        ? []
        : List.generate(
        teacherMarkAttendanceController.subject.length,
            (index) {
          return DropdownMenuItem<Subject>(
            value: teacherMarkAttendanceController.subject[index],
            child: Row(
              children: [
                Text(
                  teacherMarkAttendanceController
                      .subject[index].name
                      .toString(),
                ),
              ],
            ),
            onTap: () async {


              teacherMarkAttendanceController.subjectId.value =
                  teacherMarkAttendanceController
                        .subject[index].id;
              teacherMarkAttendanceController.subjectName.value =
                  teacherMarkAttendanceController
                      .classesSections[index].name
                      .toString();
            },
          );
        }),
  ));

  static statusDropdown({String? value}) => Obx(() => DropdownButtonFormField<String>(
    decoration: inputDec(hintText: 'Select Status'),
    value: statusValue,
    onChanged: ( newValue) {
      statusValue = newValue!;
    },
    items: List.generate(
        statusModel.length,
            (index) {
          return DropdownMenuItem<String>(
            value: statusValue,
            child: Row(
              children: [
                Text(
                  statusModel[index]
                      .toString(),
                ),
              ],
            ),
            onTap: onTap
          );
        }),
  ));

}