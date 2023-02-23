// import 'package:example/lib/top_bar.dart';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../component/top_bar.dart';
import 'clock_second_sample.dart';

class ComPassPage extends StatefulWidget {
  static const routeName = '/compass';
  @override
  createState() => ComPassPageState();
}

class ComPassPageState extends State<ComPassPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF3F8FF),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 9.0),
              child: TopBar(
                actions: [],
              ),
            ),
            // Container(
            //   color: Colors.amber,
            //   width: 100,
            //   height: 100,
            // ),
            Flexible(child: NeumorphicClock()),
          ],
        ),
      ),
    );
  }
}

class NeumorphicClock extends StatelessWidget {
  final kInnerDecoration = BoxDecoration(
    color: const Color(0xfff3f8ff),
    borderRadius: BorderRadius.circular(1000),
  );

  final kGradientBoxDecoration = BoxDecoration(
    gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.white, Color.fromRGBO(224, 237, 255, 1)]),
    borderRadius: BorderRadius.circular(1000),
  );

  List<String> dataAngle = [
    "0\u3002",
    "30\u3002",
    "60\u3002",
    "90\u3002",
    "120\u3002",
    "150\u3002",
    "180\u3002",
    "210\u3002",
    "240\u3002",
    "270\u3002",
    "300\u3002",
    "330\u3002",
  ];
  List<String> dataCompass = ['N', 'E', 'S', 'W'];
  @override
  Widget build(BuildContext context) {
    double widthCircle =
        (((MediaQuery.of(context).size.width / 2) + 25 - 90 - 5) * 2) - 35;
    return Stack(
      clipBehavior: Clip.none,
      // fit: StackFit.expand,
      // alignment: Alignment.center,
      children: [
        Positioned(
          right: -25,
          left: -25,
          child: AspectRatio(
            aspectRatio: 1,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  child: Stack(
                    children: [
                      Neumorphic(
                        margin: const EdgeInsets.all(90),
                        style: const NeumorphicStyle(
                            depth: 40,
                            intensity: .9,
                            shadowDarkColor: Color(0xffbbd0ed),
                            shadowLightColor: Colors.white,
                            boxShape: NeumorphicBoxShape.circle(),
                            color: Color(0xfff3f8ff),
                            shape: NeumorphicShape.flat),
                        child: Stack(
                          fit: StackFit.expand,
                          alignment: Alignment.center,
                          clipBehavior: Clip.none,
                          children: [
                            Neumorphic(
                              margin: const EdgeInsets.all(40),
                              style: NeumorphicStyle(
                                  depth: NeumorphicTheme.embossDepth(context),
                                  shadowDarkColor:
                                      Color.fromRGBO(26, 115, 232, .2),
                                  shadowLightColor:
                                      Colors.white.withOpacity(.7),
                                  shadowDarkColorEmboss: Color(0xffccd8eb),
                                  shadowLightColorEmboss:
                                      Color.fromRGBO(26, 115, 232, .2),
                                  boxShape: NeumorphicBoxShape.circle(),
                                  color: Color(0xfff3f9ff),
                                  intensity: .7,
                                  shape: NeumorphicShape.flat),
                              child: Neumorphic(
                                margin: EdgeInsets.all(30),
                                style: NeumorphicStyle(
                                    depth: 10,
                                    shadowDarkColor:
                                        Color.fromRGBO(22, 115, 232, .52),
                                    shadowLightColor: Colors.white,
                                    boxShape: NeumorphicBoxShape.circle(),
                                    color: Color(0xfff3f9ff),
                                    border: NeumorphicBorder(
                                        width: 5, color: Color(0xffe0edff)),
                                    intensity: 1,
                                    shape: NeumorphicShape.flat),
                                child: Neumorphic(
                                  style: NeumorphicStyle(
                                      depth: -4,
                                      shadowDarkColorEmboss:
                                          Color.fromRGBO(26, 115, 232, .42),
                                      shadowLightColor: Colors.white,
                                      shadowLightColorEmboss:
                                          Colors.white.withOpacity(1),
                                      boxShape: NeumorphicBoxShape.circle(),
                                      color: Color(0xfff3f9ff),
                                      intensity: 1,
                                      shape: NeumorphicShape.flat),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Text(
                                        "260\u00B0",
                                        style: TextStyle(
                                            fontSize: 36,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff47515c),
                                            fontFamily: 'Inter'),
                                      ),
                                      Positioned(
                                          bottom: 8,
                                          child: Text(
                                            "NE",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xff47515c),
                                                fontFamily: 'Inter'),
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        // alignment: Alignment.center,
                        child: Transform.rotate(
                          angle: -pi / 6,
                          child: Center(
                            child: Stack(
                              children: [
                                ...List.generate(
                                  12,
                                  (index) => Transform.rotate(
                                    angle: pi * (index + 1) / 6,
                                    child: Container(
                                      width: widthCircle,
                                      height: widthCircle,
                                      alignment: Alignment.topCenter,
                                      child: Text(
                                        dataAngle[index],
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: index % 3 == 0
                                                ? FontWeight.w500
                                                : FontWeight.w400,
                                            color: index % 3 == 0
                                                ? Color(0xff333333)
                                                : Color(0xff333333)
                                                    .withOpacity(.5)),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Transform.rotate(
                        angle: -pi / 2,
                        child: Center(
                          child: Stack(
                            children: [
                              ...List.generate(
                                4,
                                (index) => Transform.rotate(
                                  angle: pi * (index + 1) / 2,
                                  child: Container(
                                    width: widthCircle + 94,
                                    height: widthCircle + 94,
                                    alignment: Alignment.topCenter,
                                    // color: const Color(0xFFE8581C),
                                    child: Text(
                                      dataCompass[index].toString(),
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w500,
                                          color: index == 0
                                              ? Color(0xfff70000)
                                              : Color(0xff47515c)),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  decoration: kInnerDecoration,
                ),
              ),
              decoration: kGradientBoxDecoration,
            ),
          ),
        ),

        // createLabels(widthCircle * 2 + 105, 4),
        // AspectRatio(
        //   aspectRatio: 1,
        //   child: Neumorphic(
        //     // margin: EdgeInsets.all(14),
        //     style: NeumorphicStyle(
        //       boxShape: NeumorphicBoxShape.circle(),
        //     ),
        //     child: Neumorphic(
        //       style: NeumorphicStyle(
        //         depth: 14,
        //         boxShape: NeumorphicBoxShape.circle(),
        //       ),
        //       margin: EdgeInsets.all(20),
        //       child: Neumorphic(
        //         style: NeumorphicStyle(
        //           depth: -8,
        //           boxShape: NeumorphicBoxShape.circle(),
        //         ),
        //         margin: EdgeInsets.all(10),
        //         child: Stack(
        //           fit: StackFit.expand,
        //           alignment: Alignment.center,
        //           children: [
        //             //the click center
        //             Neumorphic(
        //               style: NeumorphicStyle(
        //                 depth: -1,
        //                 boxShape: NeumorphicBoxShape.circle(),
        //               ),
        //               margin: EdgeInsets.all(65),
        //             ),
        //             Padding(
        //               padding: const EdgeInsets.all(16.0),
        //               child: Stack(
        //                 children: <Widget>[
        //                   //those childs are not "good" for a real clock, but will fork for a sample
        //                   Align(
        //                     alignment: Alignment.topCenter,
        //                     child: _createDot(context),
        //                   ),
        //                   Align(
        //                     alignment: Alignment.centerLeft,
        //                     child: _createDot(context),
        //                   ),
        //                   Align(
        //                     alignment: Alignment(-0.7, -0.7),
        //                     child: _createDot(context),
        //                   ),
        //                   Align(
        //                     alignment: Alignment(0.7, -0.7),
        //                     child: _createDot(context),
        //                   ),
        //                   Align(
        //                     alignment: Alignment(-0.7, 0.7),
        //                     child: _createDot(context),
        //                   ),
        //                   Align(
        //                     alignment: Alignment(0.7, 0.7),
        //                     child: _createDot(context),
        //                   ),
        //                   Align(
        //                     alignment: Alignment.centerRight,
        //                     child: _createDot(context),
        //                   ),
        //                   Align(
        //                     alignment: Alignment.bottomCenter,
        //                     child: _createDot(context),
        //                   ),
        //                   _buildLine(
        //                     context: context,
        //                     angle: 0,
        //                     width: 70,
        //                     color: NeumorphicTheme.accentColor(context),
        //                   ),
        //                   _buildLine(
        //                     context: context,
        //                     angle: 0.9,
        //                     width: 100,
        //                     color: NeumorphicTheme.accentColor(context),
        //                   ),
        //                   _buildLine(
        //                     context: context,
        //                     angle: 2.2,
        //                     width: 120,
        //                     height: 1,
        //                     color: NeumorphicTheme.variantColor(context),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }

  Widget _buildLine(
      {BuildContext? context,
      double angle = 0,
      double width = 0,
      double height = 6,
      Color? color}) {
    return Transform.rotate(
      angle: angle,
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(left: width),
          child: Neumorphic(
            style: NeumorphicStyle(
              depth: 20,
            ),
            child: Container(
              width: width,
              height: height,
              color: color,
            ),
          ),
        ),
      ),
    );
  }

  Widget _createDot(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(
        depth: -10,
        boxShape: NeumorphicBoxShape.circle(),
      ),
      child: SizedBox(
        height: 10,
        width: 10,
      ),
    );
  }
}

class NeumorphicSelector extends StatelessWidget {
  final double _elementHeight = 14;
  final double _spacing = 10;

  Widget _buildSimpleButton(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(
        depth: -4,
        boxShape: NeumorphicBoxShape.circle(),
      ),
      child: SizedBox(
        height: _elementHeight,
        width: _elementHeight,
      ),
    );
  }

  Widget _buildSelectedButton(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(
        depth: -4,
        boxShape: NeumorphicBoxShape.stadium(),
        color: Color(0xffE1E8F5),
      ),
      child: SizedBox(
        height: _elementHeight,
        width: 30,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildSimpleButton(context),
        SizedBox(
          width: _spacing,
        ),
        _buildSelectedButton(context),
        SizedBox(
          width: _spacing,
        ),
        _buildSimpleButton(context),
        SizedBox(
          width: _spacing,
        ),
        _buildSimpleButton(context),
      ],
    );
  }
}
