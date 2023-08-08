// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:school_app/Student/profile_page.dart';
import 'package:school_app/utils/widgets/custom_page.dart';
import 'package:school_app/utils/images.dart';
import 'package:school_app/utils/strings.dart';
import 'package:school_app/utils/utility.dart';

class DocumentDetail extends StatefulWidget {
  final String? id;
  final String? name;
  const DocumentDetail({Key? key, this.id, this.name}) : super(key: key);

  @override
  State<DocumentDetail> createState() => _DocumentDetailState();
}

class _DocumentDetailState extends State<DocumentDetail> {
  DateTime todayDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        titleWidget: const Text(
          Strings.documentDetail,
          style: TextStyle(
              color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        automaticallyImplyLeading: false,
        child: ListView(
          padding: const EdgeInsets.only(bottom: 10, top: 50),
          children: [
            // ListTile(
            //   contentPadding: const EdgeInsets.only(right: 10),
            //   dense: true,
            //   isThreeLine: false,
            //   leading: SvgPicture.asset(
            //     AssetImages.drawerMyProfile,
            //     color: Colors.black,
            //     height: 30,
            //   ),
            //   title: const Text(
            //     "Jagrati Sonuja Class Teacher",
            //     maxLines: 1,
            //     overflow: TextOverflow.ellipsis,
            //     style: TextStyle(
            //         color: Colors.deepPurple,
            //         fontWeight: FontWeight.bold,
            //         fontSize: 15),
            //   ),
            //   subtitle: const Text(
            //     "To:Sameer Olyai,Carmei Olyai",
            //     maxLines: 1,
            //     overflow: TextOverflow.ellipsis,
            //     style: TextStyle(
            //         color: Colors.grey,
            //         fontWeight: FontWeight.bold,
            //         fontSize: 14),
            //   ),
            //   trailing:
            //       Text(DateFormat().add_jm().format(todayDate).toString()),
            // ),
            largeSizedBox,
            const Divider(color: Colors.grey),
            const Text(
              Strings.goodLuck,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            largeSizedBox,
            const Text(
              Strings.dearParents,
              style: TextStyle(fontSize: 15),
            ),
            largeSizedBox,
            const Text(
              Strings.greeting,
              style: TextStyle(fontSize: 15),
            ),
            largeSizedBox,
            largeSizedBox,
            const Text(
                Strings.greetingText),
            largeSizedBox,
            largeSizedBox,
            const Text(Strings.regards),
            smallSizedBox,
            const Text(Strings.attachment),
           const SizedBox(height:60 ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left:50,right: 50),
                child: Row(
                 // crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: (){},
                      child: const Text(
                        Strings.viewDetails,
                        style: TextStyle(fontSize: 12),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        primary: const Color.fromRGBO(105, 80, 255, 1.0),
                      ),
                    ),
                     ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        Strings.download,
                        style: TextStyle(fontSize: 12),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        primary: const Color.fromRGBO(105, 80, 255, 1.0),
                      ),
                    ),
                  ],

                ),
              ),
            ),
          ],
        ));
  }
}