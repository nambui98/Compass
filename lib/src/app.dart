import 'package:compass_1/src/sample_feature/clock_sample.dart';
import 'package:compass_1/src/sample_feature/compass.dart';
import 'package:compass_1/src/sample_feature/home.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'sample_feature/sample_item_details_view.dart';
import 'sample_feature/sample_item_list_view.dart';
import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.settingsController,
  }) : super(key: key);

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    // Glue the SettingsController to the MaterialApp.
    //
    // The AnimatedBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.

    // return ClockSample();
    return AnimatedBuilder(
      animation: settingsController,
      builder: (BuildContext context, Widget? child) {
        // NeumorphicApp(
        //   debugShowCheckedModeBanner: false,
        //   title: 'Flutter Demo',
        //   themeMode: ThemeMode.light,
        //   theme: NeumorphicThemeData(
        //     baseColor: Color(0xFFFFFFFF),
        //     lightSource: LightSource.topLeft,
        //     depth: 10,
        //   ),
        //   darkTheme: NeumorphicThemeData(
        //     baseColor: Color(0xFF3E3E3E),
        //     lightSource: LightSource.topLeft,
        //     depth: 6,
        //   ),
        //   home: SampleItemListView(),
        // );

        return NeumorphicTheme(
          theme: const NeumorphicThemeData(
              defaultTextColor: Color(0xFF303E57),
              accentColor: Color(0xFF7B79FC),
              variantColor: Colors.black38,
              baseColor: Color(0xFFF8F9FC),
              depth: 8,
              intensity: 0.5,
              lightSource: LightSource.topLeft),
          darkTheme: const NeumorphicThemeData(
            baseColor: Color(0xFF3E3E3E),
            lightSource: LightSource.topLeft,
            depth: 6,
            defaultTextColor: Color(0xFF303E57),
            accentColor: Color(0xFF7B79FC),
            variantColor: Colors.black38,
            intensity: 0.5,
          ),
          themeMode: ThemeMode.light,
          child: MaterialApp(
            home: NeumorphicBackground(
              child: HomePage(),
            ),
            onGenerateRoute: (RouteSettings routeSettings) {
              return MaterialPageRoute<void>(
                settings: routeSettings,
                builder: (BuildContext context) {
                  switch (routeSettings.name) {
                    case SettingsView.routeName:
                      return SettingsView(controller: settingsController);
                    case SampleItemDetailsView.routeName:
                      return const SampleItemDetailsView();
                    case ClockFirstPage.routeName:
                      return ClockFirstPage();
                    case ComPassPage.routeName:
                      return ComPassPage();

                    // case Samli
                    case SampleItemListView.routeName:
                      return SampleItemListView();
                    default:
                      return const HomePage();
                  }
                },
              );
            },
          ),
        );

        return ClockSample();
        return NeumorphicApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          themeMode: ThemeMode.light,
          theme: NeumorphicThemeData(
            baseColor: Color(0xFFFFFFFF),
            lightSource: LightSource.topLeft,
            depth: 10,
          ),
          darkTheme: NeumorphicThemeData(
            baseColor: Color(0xFF3E3E3E),
            lightSource: LightSource.topLeft,
            depth: 6,
          ),
          home: SampleItemListView(),
        );
        // return MaterialApp(
        //   // Providing a restorationScopeId allows the Navigator built by the
        //   // MaterialApp to restore the navigation stack when a user leaves and
        //   // returns to the app after it has been killed while running in the
        //   // background.
        //   restorationScopeId: 'app',

        //   // Provide the generated AppLocalizations to the MaterialApp. This
        //   // allows descendant Widgets to display the correct translations
        //   // depending on the user's locale.
        //   localizationsDelegates: const [
        //     AppLocalizations.delegate,
        //     GlobalMaterialLocalizations.delegate,
        //     GlobalWidgetsLocalizations.delegate,
        //     GlobalCupertinoLocalizations.delegate,
        //   ],
        //   supportedLocales: const [
        //     Locale('en', ''), // English, no country code
        //   ],

        //   // Use AppLocalizations to configure the correct application title
        //   // depending on the user's locale.
        //   //
        //   // The appTitle is defined in .arb files found in the localization
        //   // directory.
        //   onGenerateTitle: (BuildContext context) =>
        //       AppLocalizations.of(context)!.appTitle,

        //   // Define a light and dark color theme. Then, read the user's
        //   // preferred ThemeMode (light, dark, or system default) from the
        //   // SettingsController to display the correct theme.
        //   theme: ThemeData(),
        //   darkTheme: ThemeData.dark(),
        //   themeMode: settingsController.themeMode,

        //   // Define a function to handle named routes in order to support
        //   // Flutter web url navigation and deep linking.
        //   onGenerateRoute: (RouteSettings routeSettings) {
        //     return MaterialPageRoute<void>(
        //       settings: routeSettings,
        //       builder: (BuildContext context) {
        //         switch (routeSettings.name) {
        //           case SettingsView.routeName:
        //             return SettingsView(controller: settingsController);
        //           case SampleItemDetailsView.routeName:
        //             return const SampleItemDetailsView();
        //           case SampleItemListView.routeName:
        //           default:
        //             return const SampleItemListView();
        //         }
        //       },
        //     );
        //   },
        // );
      },
    );
  }
}
