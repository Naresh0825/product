
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:product/commons/exporter.dart';
import 'package:product/pages/mainpage.dart';
import 'package:product/widgets/custom_clipper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Map<String, dynamic> _deviceData = <String, dynamic>{};
  String? deviceId;
  bool showDeviceId = false;
  String year = '';

  bool _passwordVisible = false;

  final formKey = GlobalKey<FormState>();

  TextEditingController? serverTextController;
  TextEditingController? userNameTextController;
  TextEditingController passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    year = DateTime.now().toIso8601String().split('-')[0];
    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SizedBox(
            height: size.height,
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: -size.height * 0.15,
                  right: -size.width * 0.4,
                  child: SizedBox(
                    child: Transform.rotate(
                      angle: -pi / 3.5,
                      child: ClipPath(
                        clipper: ClipPainter(),
                        child: Container(
                          height: size.height * 0.5,
                          width: size.width,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                ColorManager.darkWhite,
                                ColorManager.blue,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: AppWidth.w30),
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: size.height * 0.2),
                          // RichText(
                          //   textAlign: TextAlign.center,
                          //   text: TextSpan(
                          //       text: 'Login',
                          //       style: getSemiBoldStyle(
                          //         fontSize: FontSize.s30,
                          //         color: ColorManager.blue,
                          //       ),
                          //       children: [
                          //         TextSpan(
                          //           text: ' Now',
                          //           style: getSemiBoldStyle(
                          //             color: ColorManager.black,
                          //             fontSize: FontSize.s30,
                          //           ),
                          //         ),
                          //       ]),
                          // ),
                          SizedBox(height: AppHeight.h50),
                          // Column(
                          //   children: <Widget>[
                          //     Container(
                          //       margin: EdgeInsets.symmetric(
                          //           vertical: AppHeight.h10),
                          //       child: Column(
                          //         crossAxisAlignment: CrossAxisAlignment.start,
                          //         children: <Widget>[
                          //           Text(
                          //             "UserName",
                          //             style: getBoldStyle(
                          //               fontSize: FontSize.s15,
                          //               color: ColorManager.black,
                          //             ),
                          //           ),
                          //           SizedBox(
                          //             height: AppHeight.h10,
                          //           ),
                          //           TextFormField(
                          //             controller: userNameTextController,
                          //             validator: (value) {
                          //               if (value == null || value.isEmpty) {
                          //                 return '*Required';
                          //               }
                          //               return null;
                          //             },
                          //             decoration: InputDecoration(
                          //               border: InputBorder.none,
                          //               fillColor: ColorManager.redWhite,
                          //               filled: true,
                          //               hintText: 'User Name',
                          //               suffixIcon: Icon(
                          //                 Icons.person,
                          //                 color: ColorManager.blue,
                          //                 size: FontSize.s20,
                          //               ),
                          //               enabledBorder: OutlineInputBorder(
                          //                 borderSide: BorderSide(
                          //                     color: ColorManager.blueGrey),
                          //               ),
                          //               focusedBorder: OutlineInputBorder(
                          //                 borderSide: BorderSide(
                          //                     color: ColorManager.primary),
                          //               ),
                          //               errorBorder: OutlineInputBorder(
                          //                 borderSide: BorderSide(
                          //                     color: ColorManager.red),
                          //               ),
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //     ),
                          //     Container(
                          //       margin: EdgeInsets.symmetric(
                          //           vertical: AppHeight.h10),
                          //       child: Column(
                          //         crossAxisAlignment: CrossAxisAlignment.start,
                          //         children: <Widget>[
                          //           Text(
                          //             "Password",
                          //             style: getBoldStyle(
                          //               fontSize: FontSize.s15,
                          //               color: ColorManager.black,
                          //             ),
                          //           ),
                          //           SizedBox(
                          //             height: AppHeight.h10,
                          //           ),
                          //           TextFormField(
                          //             controller: passwordTextController,
                          //             obscureText: !_passwordVisible,
                          //             validator: (value) {
                          //               if (value == null || value.isEmpty) {
                          //                 return '*Required';
                          //               }
                          //               return null;
                          //             },
                          //             decoration: InputDecoration(
                          //               border: InputBorder.none,
                          //               fillColor: ColorManager.redWhite,
                          //               filled: true,
                          //               hintText: 'Password',
                          //               suffixIcon: IconButton(
                          //                 icon: Icon(
                          //                   _passwordVisible
                          //                       ? Icons.visibility
                          //                       : Icons.visibility_off,
                          //                   color: ColorManager.blue,
                          //                 ),
                          //                 onPressed: () {
                          //                   setState(
                          //                     () {
                          //                       _passwordVisible =
                          //                           !_passwordVisible;
                          //                     },
                          //                   );
                          //                 },
                          //               ),
                          //               enabledBorder: OutlineInputBorder(
                          //                 borderSide: BorderSide(
                          //                     color: ColorManager.blueGrey),
                          //               ),
                          //               focusedBorder: OutlineInputBorder(
                          //                 borderSide: BorderSide(
                          //                     color: ColorManager.primary),
                          //               ),
                          //               errorBorder: OutlineInputBorder(
                          //                 borderSide: BorderSide(
                          //                     color: ColorManager.red),
                          //               ),
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          // SizedBox(height: AppHeight.h20),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const MainPage()));
                            },
                            child: Container(
                              width: size.width,
                              padding:
                                  EdgeInsets.symmetric(vertical: AppHeight.h14),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(AppRadius.r6)),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: Colors.grey.shade200,
                                    offset: const Offset(2, 4),
                                    blurRadius: 5,
                                    spreadRadius: 2,
                                  ),
                                ],
                                gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    ColorManager.blue,
                                    ColorManager.blue,
                                  ],
                                ),
                              ),
                              child: Text(
                                'Let\'s Go',
                                style: getRegularStyle(
                                  color: ColorManager.white,
                                  fontSize: FontSize.s20,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: AppHeight.h12,
                          ),
                          Row(
                            children: _deviceData.keys.map(
                              (String property) {
                                deviceId = _deviceData[property];
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      showDeviceId = !showDeviceId;
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        height: size.height * 0.05,
                                        child: Center(
                                            child: Text(
                                          showDeviceId
                                              ? 'Hide ID: '
                                              : 'Show ID ',
                                          style: getBoldStyle(
                                            color: ColorManager.black,
                                            fontSize: FontSize.s14,
                                          ),
                                        )),
                                      ),
                                      SizedBox(
                                        height: size.height * 0.05,
                                        child: Center(
                                          child: Text(
                                            showDeviceId ? '  $deviceId' : '  ',
                                            style: getMediumStyle(
                                              color: ColorManager.black,
                                              fontSize: FontSize.s14,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: size.height * 0.04,
                  right: size.width * 0.04,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: TextFormField(
                                controller: serverTextController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: ColorManager.blue,
                                    ),
                                  ),
                                  labelText: "Enter server name",
                                  hintText: "http://182.93.82.199:8085/webmart",
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    // showAlertDialog(context);
                                    // FocusScope.of(context).requestFocus(FocusNode());
                                    // var siteName = Strings.webMartUrl.split(":8")[0];

                                    // var newSiteName = siteName.split("//")[1];

                                    // final ping = Ping(newSiteName, count: 3);

                                    // ping.stream.listen(
                                    //   (event) {
                                    //     developer.log(event.summary.toString(), name: 'sum');

                                    //     if (event.summary != null) {
                                    //       if (event.summary!.received >= 2) {
                                    //         readLoginServiceProvider.isIpError = false;
                                    //         Fluttertoast.cancel();
                                    //         Fluttertoast.showToast(
                                    //           msg: "Connection Successful",
                                    //           toastLength: Toast.LENGTH_LONG,
                                    //           gravity: ToastGravity.BOTTOM,
                                    //         );
                                    //       } else {
                                    //         readLoginServiceProvider.isIpError = true;
                                    //         Fluttertoast.cancel();
                                    //         Fluttertoast.showToast(
                                    //           msg: "IP Error",
                                    //           toastLength: Toast.LENGTH_LONG,
                                    //           gravity: ToastGravity.BOTTOM,
                                    //           backgroundColor: ColorManager.error,
                                    //         );
                                    //       }
                                    //     }
                                    //   },
                                    // );
                                  },
                                  child: const Text("Ping"),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  child: const Text("OK"),
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Cancel"))
                              ],
                            );
                          },
                        );
                      },
                      icon: Icon(
                        Icons.settings,
                        color: ColorManager.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> showExitPopup() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              'Exit App',
              style: getBoldStyle(
                fontSize: FontSize.s18,
                color: ColorManager.error,
              ),
            ),
            content: Text(
              'Do you want to exit an App?',
              style: getRegularStyle(
                fontSize: FontSize.s16,
                color: ColorManager.black,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                //return false when click on "NO"
                child: Text(
                  'No',
                  style: getRegularStyle(
                    fontSize: FontSize.s14,
                    color: ColorManager.green,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                //return true when click on "Yes"
                child: Text(
                  'Yes',
                  style: getRegularStyle(
                    fontSize: FontSize.s14,
                    color: ColorManager.error,
                  ),
                ),
              ),
            ],
          ),
        ) ??
        false; //if showDialouge had returned null, then return false
  }
}
