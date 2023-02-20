// ignore_for_file: public_member_api_docs, unused_local_variable

import 'package:flutter/material.dart';
import 'package:mindful_flutter_util/src/ui/widget_util.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// An about icon button used on the example's app app bar.
class AboutIconButton extends StatelessWidget {
  const AboutIconButton({super.key, this.color});

  /// The color used on the icon button.
  ///
  /// If null, default to Icon() class default color.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.info, color: color),
      onPressed: () {
        showAppAboutDialog(context);
      },
    );
  }
}

// This [showAppAboutDialog] function is based on the [AboutDialog] example
// that exist(ed) in the Flutter Gallery App.
Future<void> showAppAboutDialog(BuildContext context) async {
  final theme = Theme.of(context);
  final aboutTextStyle = theme.textTheme.bodyLarge!;
  final footerStyle = theme.textTheme.bodySmall!;
  final linkStyle =
      theme.textTheme.bodyLarge!.copyWith(color: theme.colorScheme.primary);

  final media = MediaQuery.of(context);
  final width = media.size.width;
  final height = media.size.height;

  // Get the card's ShapeBorder from the themed card shape.
  // This was kind of interesting to do, seem to work, for this case at least.
  final shapeBorder = theme.cardTheme.shape;
  var buttonRadius = 4.0; // Default un-themed value
  if (shapeBorder is RoundedRectangleBorder?) {
    final border = shapeBorder?.borderRadius;
    if (border is BorderRadius?) {
      final radius = border?.topLeft;
      buttonRadius = radius?.x == radius?.y ? (radius?.x ?? 4.0) : 4.0;
    }
  }
  final packageInfo = await PackageInfo.fromPlatform();
  final appName = packageInfo.appName;
  final packageName = packageInfo.packageName;
  final version = packageInfo.version;
  final buildNumber = packageInfo.buildNumber;

  showAboutDialog(
    context: context,
    applicationName: appName,
    // packageName: packageName,
    // title: title(context),
    applicationVersion: '$version Build-$buildNumber',
    applicationIcon:
        // Container(height: 30,width: 30,child: Image.asset("assets/icons.png"),),
        Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // FlexThemeModeOptionButton(
        //   optionButtonBorderRadius: buttonRadius,
        //   selected: true,
        //   width: 30,
        //   height: 30,
        //   flexSchemeColor: FlexSchemeColor(
        //     primary: theme.colorScheme.primary,
        //     primaryContainer: theme.colorScheme.primaryContainer,
        //     secondary: theme.colorScheme.secondary,
        //     secondaryContainer: theme.colorScheme.secondaryContainer,
        //   ),
        // ),
        SizedBox(
          height: 60,
          width: 60,
          child: Image.asset('assets/icons.png'),
        ),
        const Divider(),
        // Container(
        //   height: 60,
        //   width: 60,
        //   child: IconButton(
        //       // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
        //       icon: FaIcon(FontAwesomeIcons.facebook, size: 40),
        //       onPressed: () async {
        //         await launchUrl(Uri.parse('fb://profile/100047632187836'));
        //       }),
        // ),
        // Container(
        //   height: 60,
        //   width: 60,
        //   child: IconButton(
        //     // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
        //     icon: FaIcon(FontAwesomeIcons.github,size: 40),
        //     onPressed: () {
        //       print("Pressed");
        //     })
        // ),
      ],
    ),
    // applicationLegalese:
    //     '${copyright}\n${author}\n${license}',
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(top: 24),
        child: RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                style: aboutTextStyle,
                text: 'The ${title(context)} application  '
                    'features of the math dictionary \n\n'
                    'To learn more, check out our project on github ',
              ),
              // LinkTextSpan(
              //   style: linkStyle,
              //   uri: packageUri,
              //   text: 'pub.dev',
              // ),
              TextSpan(
                style: aboutTextStyle,
                text: '. It also includes the source '
                    'code of this application.\n\n',
              ),
              // TextSpan(
              //   style: footerStyle,
              //   text: 'Built with Flutter ${flutterVersion} \n'
              //       // 'using ${packageName} '
              //       // '${packageVersion}\n'
              //       'Media size (w:${width.toStringAsFixed(0)}, '
              //       'h:${height.toStringAsFixed(0)})\n\n',
              // ),
            ],
          ),
        ),
      ),
    ],
  );
}
