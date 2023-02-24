import 'package:compass_1/src/icon_app/icon_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'back_button.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBack;
  final List<Widget>? actions;

  static const double kToolbarHeight = 110.0;

  const TopBar({this.showBack = true, this.title = "", this.actions});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Align(alignment: Alignment.centerLeft, child: NeumorphicBack()),
        if (showBack)
          Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
              focusColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              // overlayColor: Colors.transparent,
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SvgPicture.asset(
                    IconApp.back,
                    color: Color(0xff39414A),
                    width: 40,
                  ),
                  Positioned(
                    left: 0,
                    child: Icon(
                      Icons.chevron_left_outlined,
                      color: Colors.white,
                      size: 30,
                    ),
                  )
                ],
              ),
            ),
          ),
        Center(
          child: Text(
            this.title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: NeumorphicTheme.isUsingDark(context)
                  ? Colors.white
                  : const Color(0xff333333),
            ),
          ),
        ),
        Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: actions ?? [],
            )),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
