import 'package:flutter/material.dart';

class ForgetPassword_Page extends StatefulWidget {
  const ForgetPassword_Page({Key?  key}) : super(key: key);

  @override
  State<ForgetPassword_Page> createState() => _ForgetPassword_PageState();
}

class _ForgetPassword_PageState extends State<ForgetPassword_Page> {
 // String _r_email;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {


    Size size = MediaQuery
        .of(context)
        .size;
    double width = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      backgroundColor: Color(0xff354144),
      body: Form(
        key: _formKey,
        child: Container(
          alignment: Alignment.center,
          height: size.height * 0.7,
          width: size.width * 1,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(120),
                  bottomRight: Radius.circular(120)),
              boxShadow: const [
                BoxShadow(color: Color(0xffff0100), spreadRadius: 2),
              ],
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.grey.shade100, Colors.grey.shade200])),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 300.0,bottom: 50.0),
                    child: MaterialButton(onPressed: (){
                      Navigator.pop(context);
                    },
                      color: Color(0xff354144),
                      textColor: Colors.white,
                      child: Icon(
                          Icons.arrow_back_ios_rounded,size: 20
                      ),
                      padding: EdgeInsets.only(bottom: 4),
                      shape: CircleBorder(),

                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Image.asset('assets/images/flashlogo.png',
                      height: 100, width: 200,
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(right: 330.0),
                  //   child: MaterialButton(onPressed: (){},
                  //   color: Color(0xff354144),
                  //     textColor: Colors.white,
                  //     child: Icon(
                  //       Icons.arrow_back_ios_rounded,size: 20
                  //     ),
                  //     padding: EdgeInsets.only(bottom: 4),
                  //     shape: CircleBorder(),
                  //
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 200,
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: const Text(
                      'Please Enter Your Registered Email',
                      style: TextStyle(
                          color: Colors.black,
                          letterSpacing: 1,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),

                  ),
                  Container(
                    width: size.width * 0.8,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.grey.withOpacity(0.7)),
                    child: TextFormField(
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return 'Please Enter Email?';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.person,
                          color: Color(0xff354144),
                        ),
                        hintText: "Email",
                        // prefixText: "Email",
                        hintStyle: TextStyle(color: Colors.black),
                      ),
                      onChanged: (value){
                        setState(() {
                          // _r_email = value;
                        });
                      },
                    ),

                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: SizedBox(
                      height: size.height * 0.06,
                      width: size.width * 0.8,
                      child: ElevatedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Color(0xff354144),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                        ),
                        // color: const Color(0xff354144),
                        onPressed: () {
                          if(_formKey.currentState!.validate()){
                            _formKey.currentState!.save();
                            // return (_r_email);
                          }

                          // Navigator.push(
                          //     context,
                          //     PageTransition(
                          //         type: PageTransitionType.fade,
                          //         child: DashboardTRLPage()));
                        },
                        child: const Text(
                          'SUBMIT',
                          style: TextStyle(color: Colors.white, letterSpacing: 1),
                        ),
                      ),
                    ),
                  )

                  // const SizedBox(
                  //   height: 10,
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}
