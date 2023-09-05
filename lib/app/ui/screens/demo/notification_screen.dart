import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sofproject/app/ui/themes/MyColors.dart';
import 'package:sofproject/app/ui/widgets/progress_loading.dart';

import '../../../controllers/incident_controller.dart';
import '../../../controllers/notification_controller.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    IncidentController.to.getNotification();
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor:  AppColors.primaryColor,
        title: Text("Notification",style: TextStyle(color: AppColors.white),),
      ),
      body:SingleChildScrollView(
        child: Column(
          children: [
            //
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: new Container(
            //       width: Get.width, child: _buildSearchBox()),
            // ),

               Obx(()=>
                   IncidentController.to.notificationLoading==true?
                       Container(
                         height: Get.height*0.8,
                         child: Center(
                           child: ProgressLoading(),
                         ),
                       ):
                   ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: IncidentController.to.notificationsList.length,
                    itemBuilder: (BuildContext context, index) {
                      return  Column(
                        children: [
             Container(
               width: Get.width,
               margin: EdgeInsets.symmetric(vertical: 4),
               decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(15),
                     color: Colors.white
               ),child: Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.start,
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: [
                       Container(
                         decoration: BoxDecoration(
                           color: Colors.deepPurple.withAlpha(60),
                           shape: BoxShape.circle
                         ),
                         child: Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Icon(Icons.people_outline,
                           color: Colors.deepPurple,),
                         ),
                       ),
                       SizedBox(width: 5,),
                       Flexible(
                           child:
                           Html(
                             data: """
               ${IncidentController.to.notificationsList[index]['NOTIFICATION_DESC']}
                   """,
                           ),
                       ),

                     ],
                   ),
               ),
             )
                        ],
                      );
                    },
                  ),
                ),


          ],
        ),
      )
    );
  }
  Widget _buildSearchBox() {
    return Row(
      children: [
        Container(
          width: Get.width * .95,
          child: Card(
            child: ListTile(
              leading: Icon(Icons.search),
              title: TextField(
                controller: NotificationController.to.searchController,
                decoration:
                InputDecoration(hintText: 'Search', border: InputBorder.none),
                onChanged: (value) {
                  NotificationController.to.searchValue = value;

                },
              ),
              trailing: IconButton(
                icon: Icon(Icons.cancel),
                onPressed: () {

                  NotificationController.to.searchController.text = "";
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

}
