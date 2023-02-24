//  import 'package:example/lib/top_bar.dart';

import 'dart:math';

import 'package:compass_1/src/icon_app/icon_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';
import '../component/top_bar.dart';
import 'clock_second_sample.dart';

class ComPassPage extends StatefulWidget {
  static const routeName = '/compass';
  @override
  createState() => ComPassPageState();
}

class ComPassPageState extends State<ComPassPage> {
  bool _hasPermissions = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchPermissionStatus();
  }

  void _fetchPermissionStatus() {
    Permission.locationWhenInUse.status.then((status) {
      if (mounted) {
        setState(() => _hasPermissions = status == PermissionStatus.granted);
      }
    });
  }

  Widget _buildPermissionSheet(bool isDark) {
    return SafeArea(
      child: Container(
        alignment: Alignment.center,
        // color: Colors.amber,
        // color: const Color(0xffF3F8FF),
        child: NeumorphicButton(
          style: NeumorphicStyle(
              depth: 8,
              intensity: .9,
              shadowDarkColor: isDark
                  ? Colors.black.withOpacity(.6)
                  : const Color(0xffbbd0ed),
              shadowLightColor:
                  isDark ? Colors.white.withOpacity(.25) : Colors.white,
              color: isDark ? const Color(0xff272727) : const Color(0xffF3F8FF),
              shape: NeumorphicShape.flat),
          child: Text(
            'Request Permissions',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : const Color(0xff47515c),
            ),
          ),
          onPressed: () {
            Permission.locationWhenInUse.request().then((ignored) {
              _fetchPermissionStatus();
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = NeumorphicTheme.isUsingDark(context);

    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xff272727) : const Color(0xffF3F8FF),
      body: Builder(
        builder: (context) {
          if (!_hasPermissions) {
            return _buildPermissionSheet(isDark);
          } else {
            return SafeArea(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 9.0),
                    child: TopBar(
                      title: "COMPASS",
                      showBack: false,
                      actions: [
                        InkWell(
                          onTap: () {
                            NeumorphicTheme.of(context)?.themeMode =
                                NeumorphicTheme.isUsingDark(context)
                                    ? ThemeMode.light
                                    : ThemeMode.dark;
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: isDark
                                ? SvgPicture.asset(IconApp.light, width: 30)
                                : SvgPicture.asset(IconApp.dark, width: 30),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Expanded(child: NeumorphicClock()),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class NeumorphicClock extends StatelessWidget {
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
    bool isDark = NeumorphicTheme.isUsingDark(context);
    final kInnerDecoration = BoxDecoration(
      color: isDark ? const Color(0xff272727) : const Color(0xffF3F8FF),
      borderRadius: BorderRadius.circular(1000),
    );
    final kGradientBoxDecoration = BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [Colors.grey.shade700, Colors.black12, Colors.black54]
              : [Colors.white, const Color.fromRGBO(224, 237, 255, 1)]),
      borderRadius: BorderRadius.circular(1000),
    );

    double widthCircle =
        (((MediaQuery.of(context).size.width / 2) + 25 - 90 - 5) * 2) - 35;
    return StreamBuilder<CompassEvent>(
        stream: FlutterCompass.events,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error reading heading: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          double? direction = snapshot.data!.heading;
          if (direction == null) {
            return const Center(
              child: Text("Device does not have sensors !"),
            );
          }
          return Stack(
            // alignment: Alignment.center,
            clipBehavior: Clip.none,
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
                              style: NeumorphicStyle(
                                  depth: 40,
                                  intensity: .9,
                                  shadowDarkColor: isDark
                                      ? Colors.black.withOpacity(.6)
                                      : const Color(0xffbbd0ed),
                                  shadowLightColor: isDark
                                      ? Colors.white.withOpacity(.25)
                                      : Colors.white,
                                  boxShape: const NeumorphicBoxShape.circle(),
                                  color: isDark
                                      ? const Color(0xff272727)
                                      : const Color(0xffF3F8FF),
                                  shape: NeumorphicShape.flat),
                              child: Stack(
                                fit: StackFit.expand,
                                alignment: Alignment.center,
                                clipBehavior: Clip.none,
                                children: [
                                  Neumorphic(
                                    margin: const EdgeInsets.all(40),
                                    style: NeumorphicStyle(
                                        depth: NeumorphicTheme.embossDepth(
                                            context),
                                        shadowDarkColor: const Color.fromRGBO(
                                            26, 115, 232, .2),
                                        shadowLightColor: isDark
                                            ? Colors.black.withOpacity(.2)
                                            : Colors.white.withOpacity(.7),
                                        shadowDarkColorEmboss: isDark
                                            ? Colors.black.withOpacity(.5)
                                            : const Color(0xffccd8eb),
                                        shadowLightColorEmboss: isDark
                                            ? Colors.black.withOpacity(.5)
                                            : const Color.fromRGBO(
                                                26, 115, 232, .2),
                                        boxShape:
                                            const NeumorphicBoxShape.circle(),
                                        color: isDark
                                            ? const Color(0xff272727)
                                            : const Color(0xfff3f9ff),
                                        intensity: .7,
                                        shape: NeumorphicShape.flat),
                                    child: Neumorphic(
                                      margin: const EdgeInsets.all(30),
                                      style: NeumorphicStyle(
                                          depth: 10,
                                          shadowDarkColor: isDark
                                              ? Colors.black.withOpacity(.31)
                                              : Color.fromRGBO(
                                                  22, 115, 232, .52),
                                          shadowLightColor: isDark
                                              ? Colors.black.withOpacity(.51)
                                              : Colors.white,
                                          boxShape: NeumorphicBoxShape.circle(),
                                          color: isDark
                                              ? Color(0xff47515c)
                                              : Color(0xfff3f9ff),
                                          border: NeumorphicBorder(
                                              width: 5,
                                              color: isDark
                                                  ? Color(0xff47515c)
                                                  : Color(0xffe0edff)),
                                          intensity: 1,
                                          shape: NeumorphicShape.flat),
                                      child: Neumorphic(
                                        style: NeumorphicStyle(
                                            depth: isDark ? -10 : -4,
                                            shadowDarkColorEmboss: isDark
                                                ? Colors.black.withOpacity(.51)
                                                : const Color.fromRGBO(
                                                    26, 115, 232, .42),
                                            shadowLightColor: Colors.white,
                                            shadowLightColorEmboss: isDark
                                                ? Colors.black.withOpacity(.51)
                                                : Colors.white.withOpacity(1),
                                            boxShape:
                                                NeumorphicBoxShape.circle(),
                                            color: isDark
                                                ? Color(0xff47515c)
                                                : const Color(0xfff3f9ff),
                                            intensity: 1,
                                            shape: NeumorphicShape.flat),
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Text(
                                              "${getAngle(direction).floor()}\u00B0",
                                              style: TextStyle(
                                                  fontSize: 36,
                                                  fontWeight: FontWeight.w500,
                                                  color: isDark
                                                      ? Colors.white
                                                      : Color(0xff47515c),
                                                  fontFamily: 'Inter'),
                                            ),
                                            Positioned(
                                                bottom: 8,
                                                child: Text(
                                                  getDirection(direction),
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: isDark
                                                          ? Colors.white
                                                          : Color(0xff47515c),
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
                            Transform.rotate(
                              angle: (direction * (pi / 180) * -1),
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
                                                      ? isDark
                                                          ? Colors.white
                                                          : const Color(
                                                              0xff333333)
                                                      : isDark
                                                          ? Colors.white
                                                              .withOpacity(.5)
                                                          : const Color(
                                                                  0xff333333)
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
                                          child: Transform.rotate(
                                            angle: index != 0
                                                ? -pi * (index * 2) / 4
                                                : 0,
                                            child: Text(
                                              dataCompass[index].toString(),
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w500,
                                                  color: index == 0
                                                      ? const Color(0xfff70000)
                                                      : const Color(
                                                          0xff47515c)),
                                            ),
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
            ],
          );
        });
  }

  double getAngle(double direction) {
    return (direction < 0 ? 360 + direction : direction);
  }

  String getDirection(double direction) {
    double angle = getAngle(direction);
    if (angle >= 22.5 && angle <= 67.5) {
      return 'NE';
    } else if (angle >= 112.5 && angle <= 157.5) {
      return 'SE';
    } else if (angle >= 202.5 && angle <= 247.5) {
      return 'SW';
    } else if (angle >= 337.5 || angle <= 22.5) {
      return 'N';
    } else if (angle >= 67.5 && angle <= 112.5) {
      return 'E';
    } else if (angle >= 157.5 && angle <= 202.5) {
      return 'S';
    } else if (angle >= 247.5 && angle <= 292.5) {
      return 'SW';
    } else if (angle >= 292.5 && angle <= 337.5) {
      return 'NW';
    }
    return '';
  }
}
