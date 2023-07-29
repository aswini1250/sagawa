
 import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class CommonDropDown extends StatelessWidget {
   const CommonDropDown({
  required this.items,
   required this.title,
     required this.hintText,
     required this.labelText,
     required this.cb,
      this.initialValue,
   }) ;
final List<dynamic> items;
final String title;
   final String hintText;
   final String labelText;
   final Function(dynamic) cb;
   final String? initialValue;
   @override
   Widget build(BuildContext context) {
     return Padding(
       padding: const EdgeInsets.symmetric(horizontal: 0.0,vertical: 5),
       child: DropdownSearch<dynamic>(
         mode: Mode.DIALOG,
         showSelectedItem:false,
         items: items,
         itemAsString: (dynamic u) => u['$title'],
         label:labelText,
         hint:initialValue==null?"$hintText":initialValue,
         // label: "skjdsda",
         onChanged: (value){
           cb(value);
         },
         showSearchBox: true,
         filterFn: (instance, filter){
           print("****"+filter+"*** ${instance}");
           //print(instance);
           if("${instance['$title']}".toLowerCase().contains(filter.toLowerCase())){
             //print("search"+filter);
             return true;
           }
           else{
             return false;
           }
         },
         popupItemBuilder: (context,dynamic item,bool isSelected){
           return Container(
             margin: EdgeInsets.symmetric(horizontal: 8),
             decoration: !isSelected
                 ? null
                 : BoxDecoration(
               border: Border.all(color: Theme.of(context).primaryColor),
               borderRadius: BorderRadius.circular(5),
               color: Colors.white,
             ),
             child: Padding(
               padding: const EdgeInsets.all(8.0),
               child: Text("${item['$title']}"),
             ),
           );
         },
       ),
     );
   }
 }
