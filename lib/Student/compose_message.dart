// ignore_for_file: unused_import

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:school_app/Controller/getTeacherController.dart';
import 'package:school_app/Controller/stuCompMsgController.dart';
import 'package:school_app/Model/getTeacherModel.dart';
import 'package:school_app/Student/profile_page.dart';
import 'package:school_app/utils/animated_navigation.dart';
import 'package:school_app/utils/student/app_widget.dart';
import 'package:school_app/utils/widgets/custom_page.dart';
import 'package:school_app/utils/images.dart';
import 'package:school_app/utils/strings.dart';
import 'package:school_app/utils/utility.dart';
import 'package:multiselect/multiselect.dart';

import '../Controller/messageController.dart';
import '../utils/network_handler.dart';
import 'message.dart';

class ComposeMessage extends StatefulWidget {
  const ComposeMessage({
    Key? key,
  }) : super(key: key);

  @override
  State<ComposeMessage> createState() => _ComposeMessageState();
}

class _ComposeMessageState extends State<ComposeMessage> {
  TextEditingController _teacherController = TextEditingController();
  TextEditingController _subjectController = TextEditingController();
  TextEditingController _messageController = TextEditingController();
  var getTeacherController = Get.put(GetTeacherController());
  var stuCompMsgController = Get.put(StuCompMsgController());
  var messageController = Get.put(MessageController());
  NetworkHandler nr = NetworkHandler();
  String? selected;
  var selectedValue;
  DateTime todayDate = DateTime.now();
  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() async {
    bool isConnected = await nr.checkConnectivity();

    if (isConnected) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        getTeacherController.getStuTeacher();
      });
    }
    else{
     StudentAppWidgets.noInternetAvailable(context: context);
    }
  }
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        titleWidget: const Text(
          Strings.composeNewMessage,
          style: TextStyle(
              color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        automaticallyImplyLeading: false,
        child: Obx(
        ()=> getTeacherController.isLoading ==true?
        StudentAppWidgets.loadingWidget():ListView(
          padding: const EdgeInsets.only(bottom: 10, top: 50),
          children: [
            ListTile(
              contentPadding: const EdgeInsets.only(right: 10),
              dense: true,
              isThreeLine: false,
              leading: SvgPicture.asset(
                AssetImages.drawerMyProfile,
                color: Colors.black,
                height: 30,
              ),
              title: Text(
                "${Strings.to} ${stuCompMsgController.teacherController.text}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
              trailing:
                  Text(DateFormat().add_jm().format(todayDate).toString()),
            ),
            const Divider(color: Colors.grey),
            smallSizedBox,
            const Text(
              Strings.composeNewMessage,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            largeSizedBox,
            const Text(
              Strings.toTeacher,
              style: TextStyle(fontSize: 15),
            ),
            largeSizedBox,
            TextField(
              readOnly: true,
                controller: stuCompMsgController.teacherController,
                decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  hintText: (Strings.selectTeacher),
                  border: OutlineInputBorder(),
                  isDense: true,
                )),
            /*DropDownMultiSelect(
              onChanged: (List<String> x) {
                setState(() {
                  selected =x;
                });
              },
              options: [
                for(var i in getTeacherController.teachers.value)
                  i.teacherName,
                ],
              decoration: const InputDecoration(
                contentPadding:
                EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                //hintText: ("Select Teacher"),
                border: OutlineInputBorder(),
                isDense: true,
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(color: Colors.grey)),
              ),
              selectedValues: selected,
              whenEmpty: 'Select Teacher',
             // enabled: false,
            ),*/

            /*DropdownButtonFormField(
              hint: selected == null
                  ? Text('Select Teacher')
                  : Text(
                selected!,
                style: TextStyle(color: Colors.blue),
              ),
              decoration: const InputDecoration(
                contentPadding:
                EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                border: OutlineInputBorder(),
                isDense: true,
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(color: Colors.grey)),
                focusColor: Colors.black,
                //isDense: true,
              ),
              isExpanded: true,
              iconSize: 30.0,
              style: TextStyle(color: Colors.black),
              items: [
                  for(var i in getTeacherController.teachers)
                    DropdownMenuItem<String>(
                    value: i.teacherId.toString(),
                    child: Text(i.teacherName),
                  ),
              ],
              onChanged: (val) async{
                await stuCompMsgController.setTeacherId(val);
                setState(
                      (){
                        log(val);
                  },
                );
              },
            ),*/
            largeSizedBox,
            TextField(
                controller: stuCompMsgController.subjectController,
                decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  hintText: (Strings.subjects),
                  border: OutlineInputBorder(),
                  isDense: true,
                )),
            largeSizedBox,
            TextField(
                controller: stuCompMsgController.messageController,
                keyboardType: TextInputType.multiline,
                maxLines: 6,
                cursorWidth: 2.0,
               // textAlign: TextAlign.left,
                decoration: const InputDecoration(
                  hintText: Strings.messages,
                  border: OutlineInputBorder(),
                  //isDense: true,
                )),
            largeSizedBox,
            smallSizedBox,
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 50, right: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          primary: const Color.fromRGBO(105, 80, 255, 1.0),
                        ),
                        child: const Text(
                          Strings.discard,
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async{
                        bool isConnected = await nr.checkConnectivity();
                        if(isConnected){
                          await stuCompMsgController.compMsg();
                          SchedulerBinding.instance.addPostFrameCallback((_) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(stuCompMsgController.status.value))
                            );
                            Get.off(
                                const Message(
                                  name: Strings.message,
                                )
                            );
                          });
                        }
                        else{
                         StudentAppWidgets.noInternetAvailable(context: context);
                        }
                        //await messageController.getStuMessages();
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
                            Strings.sendMessage,
                            style: TextStyle(fontSize: 12),
                          ),
                          SizedBox(width: 5,),
                          Visibility(
                              visible: stuCompMsgController.isLoading.value,
                              child: SizedBox(
                                  height: 15,
                                  width: 15,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ))),
                          SizedBox(width: 5,),
                        ],
                      ),
                    ),
                    //SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ],
        )));
  }
}