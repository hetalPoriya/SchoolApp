// ignore_for_file: unused_import

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:school_app/Student/document_details.dart';
import 'package:school_app/Student/profile_page.dart';
import 'package:school_app/utils/animated_navigation.dart';
import 'package:school_app/utils/colors.dart';
import 'package:school_app/utils/constants.dart';
import 'package:school_app/utils/student/app_widget.dart';
import 'package:school_app/utils/widgets/custom_page.dart';
import 'package:school_app/utils/images.dart';
import 'package:school_app/utils/strings.dart';
import 'package:school_app/utils/utility.dart';
import 'package:school_app/utils/widgets/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Controller/documentController.dart';

class DocumentList extends StatefulWidget {
  final int docLength;
  final int yearIndex;
  final int monthIndex;
  DocumentList({Key? key, required this.docLength,required this.yearIndex, required this.monthIndex}) : super(key: key);

  @override
  State<DocumentList> createState() => _DocumentListState();
}

class _DocumentListState extends State< DocumentList > {
  var documentController = Get.put(DocumentController());
 
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      automaticallyImplyLeading: false,
      child: Padding(
        padding: const EdgeInsets.only(top: 60, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Strings.documentList.toUpperCase(),
              style: titleTextStyle,
            ),
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
                child:  Obx(
                      ()=> documentController.isLoading ==true?
                  StudentAppWidgets.loadingWidget()
                          : ListView.builder(
                    itemCount: widget.docLength,
                    itemBuilder: (context, index) {
                      var entry = documentController.docdata.entries.elementAt(widget.yearIndex);
                      return Padding(
                          padding: const EdgeInsets.only(top: 5.0, bottom: 6.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15.0)),
                              border: Border.all(
                                width: 1.0,
                                color: Colors.grey,
                              ),
                            ),
                            child: ListTile(
                              onTap: () {},
                              title: const Text(Strings.document,style: TextStyle(fontSize: 12),),
                              leading: SizedBox(
                                width: 25,
                                child: Center(
                                  child: SvgPicture.asset(
                                    AssetImages.drawerMyProfile,
                                    color: Colors.black,
                                    height: 25,
                                  ),
                                ),
                              ),
                              trailing:ElevatedButton(
                                onPressed: ()
                                async {
                                  AnimatedNavigation.pushAnimatedNavigation(
                                    context,
                                    AppWidget.launchUrlWidget(entry.value["month_folder"][widget.monthIndex]["documents"][index]["document"]),
                                  );
                                },
                                 child: const Text(Strings.viewDetails,style: TextStyle(fontSize: 12),),
                               style: ElevatedButton.styleFrom(
                                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0),
                                  ),
                                primary: const Color.fromRGBO(105, 80, 255, 1.0), 
                                ),) ,
                            ),
                          ),
                        );
                      }
                      )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}