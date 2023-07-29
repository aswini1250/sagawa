import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Error400 extends StatelessWidget {
  const Error400({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        height: Get.height,
        color:Color.fromRGBO(125, 98, 196, 1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text("404",
              style: TextStyle(
                  fontSize: 100,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
              ),),
            Text("Whoops!",
            style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold
        ),),
            Text("Someone flew in and stole this page...",
              style: TextStyle(
                  color: Colors.white,
              ),),
            Container(
              height: 350,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/404.png")
                )
              )
            ),
            MaterialButton(
              height: 35,
              child: Text("Back"),
              onPressed: (){
              Get.back();
              },
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
