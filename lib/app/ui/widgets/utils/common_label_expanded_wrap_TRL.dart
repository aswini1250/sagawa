


 import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofproject/app/ui/widgets/colors.dart';

import 'fade_animation_TRL.dart';

class CommonExpandableWrap extends StatefulWidget {
    CommonExpandableWrap({Key? key,


     this.width=double.infinity*0.9,
      required this.child,
      required this.title
   }) : super(key: key);

  final double width;
  final Widget child;
  final String title;
  @override
  State<CommonExpandableWrap> createState() => _CommonExpandableWrapState();
}

class _CommonExpandableWrapState extends State<CommonExpandableWrap> {

  bool isExpand=false;

   @override
   Widget build(BuildContext context) {
     return Column(
       mainAxisAlignment: MainAxisAlignment.start,
       mainAxisSize: MainAxisSize.max,
       children: <Widget>[

         FadeAnimation(
             1.3,
             Container(
               width: MediaQuery.of(context).size.width,
               margin: const EdgeInsets.only(left:20.0,right:20,top:5,bottom: 5),
               padding: const EdgeInsets.all(5.0),
               decoration: BoxDecoration(
                 color: lightBGGold,
                 border: Border.all(color: lightBGGold),
                 borderRadius: BorderRadius.only(
                     topLeft: Radius.circular(10.0), //
                     topRight: Radius.circular(
                         10.0) //                 <--- border radius here
                 ),
               ),
               child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: <Widget>[
                     new Align(
                         alignment: Alignment.centerLeft,
                         child: new Text(
                           widget.title,
                           style: TextStyle(
                               fontSize: 13, color: Colors.black),
                         )),
                      IconButton(
                       icon: Icon(
                           isExpand == true
                               ? Icons.arrow_circle_up
                               : Icons.arrow_circle_down,
                           color: Colors.black,
                           size: 22),
                       onPressed: () {
                         setState(() {
                           isExpand=!isExpand;
                         });
                         //_key.currentState.openDrawer();
                       },
                     ),
                   ]),
             )),
         //expand_squenceevents
         isExpand == true
             ? Column(
             mainAxisAlignment: MainAxisAlignment.start,
             mainAxisSize: MainAxisSize.max,
             children: <Widget>[
               FadeAnimation(
                   1.4,
                   Container(
                       margin: const EdgeInsets.only(right:20,left: 20),
                     padding: EdgeInsets.symmetric(
                         horizontal: 20, vertical: 5),
                     width:widget.width,
                     // height: 5 * 24.0,
                     decoration: BoxDecoration(
                       color:lightBGExpandedChild,
                     ),
                     child:widget.child
                   )),
             ])
             : SizedBox(),


       ],
     );
   }
}
