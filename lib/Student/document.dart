// ignore_for_file: unused_import, avoid_web_libraries_in_flutter



import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:school_app/Controller/documentController.dart';
import 'package:school_app/Student/document1.dart';
import 'package:school_app/Student/document_list.dart';
import 'package:school_app/Student/profile_page.dart';
import 'package:school_app/utils/animated_navigation.dart';
import 'package:school_app/utils/colors.dart';
import 'package:school_app/utils/constants.dart';
import 'package:school_app/utils/student/app_widget.dart';
import 'package:school_app/utils/widgets/custom_page.dart';
import 'package:school_app/utils/images.dart';
import 'package:school_app/utils/strings.dart';
import 'package:school_app/utils/utility.dart';

import '../utils/network_handler.dart';

class Documents extends StatefulWidget {
const   Documents({Key? key}) : super(key: key);

  @override
  State<Documents> createState() => _DocumentsState();
}

class _DocumentsState extends State<Documents> {
  var documentController = Get.put(DocumentController());
  NetworkHandler nr = NetworkHandler();
  @override
  void initState() {
    _init();
    super.initState();
  }
  _init() async {
    bool isConnected = await nr.checkConnectivity();

    if (isConnected) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        documentController.getStuDecument();
      });
    }
    else{
     StudentAppWidgets.noInternetAvailable(context: context);
    }
  }
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      automaticallyImplyLeading: false,
      child: Padding(
        padding: const EdgeInsets.only(top:60),
        child: Obx(
        () => documentController.isLoading ==true?
        StudentAppWidgets.loadingWidget():Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(Strings.document.toUpperCase(),
            style: titleTextStyle,),
           
            Text(
              DateFormat('dd MMMM yyyy').format(DateTime.now()),
              style: TextStyle(color: Colors.grey[700], fontSize: 16),
            ),
            divider,
            largeSizedBox,
             Expanded(
                  child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
               child: ListView.builder(
                shrinkWrap: true,
                itemCount: documentController.docdata.keys.length,
                itemBuilder: (context, index) {

                  String key = documentController.docdata.keys.elementAt(index);
                  var entry = documentController.docdata.entries.elementAt(index);
                  return GestureDetector(
                  onTap: () =>AnimatedNavigation.pushAnimatedNavigation(context,Document1(monthLength: entry.value["month_folder"].length, yearIndex: index,)) ,
                    child: Card(
                      color: ColorConstants.kGreyColor100,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child:Row(
                    
                          children: [
                          SvgPicture.asset(AssetImages.folder,
                            height:30,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              entry.value["year_folder"],
                              style: const TextStyle(
                                  color: Colors.black,
                                   fontWeight: FontWeight.bold,
                                   fontSize: 14),
                            ),
                           
                          ],
                        ),
                      ),
                    ),
                  );
                },
            ),
             ),
         ), ],
        )),
      ),
    );
  }
}