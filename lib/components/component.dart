import 'package:flutter/material.dart';
import 'package:nigeria_mobile_network_ussd_code/routes/route.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:nigeria_mobile_network_ussd_code/theme/theme.dart';

//=====================================================================
// USSD CODE PAGE ARGUMENT
//=====================================================================
class CodePageArgument {
  final String networkName;
  CodePageArgument({required this.networkName});
}

//=====================================================================
// URL LUNCHER PACKAGE TO OPEN OR SEND URLS, MSG, PHONE CALLS AND EMAIL
//=====================================================================
launchFilter(value) {
  if (value.keys.toString() == '(dial)') {
    final String number = Uri.encodeComponent(value['dial']);
    final url = 'tel:$number';
    launchFunction(url);
  } else if (value.keys.toString() == '(link)') {
    final String link = value['link'];
    launch(link);
  } else if (value.keys.toString() == '(mail)') {
    final toMail = value['mail']['toMail'];
    final subject = value['mail']['subject'];
    final message = value['mail']['message'];
    final String mail = 'mailto:$toMail?subject=$subject&body=$message';
    launch(mail);
  }
}

//==========================
dynamic context;
launchFunction(url) async =>
    await canLaunch(url) ? await launch(url) : throw 'error can\'t launch $url';

//==============================================================
// MY CUSTOM APP BAR
//==============================================================
List<String> popupButtonItemTexts = [
  'More apps',
  'Follow me',
  'About developer',
  'Rate us',
  'Feedback'
];

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final ValueChanged<String> onPressed;
  const MyAppBar({Key? key, required this.title, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
      ),
      elevation: 2.0,
      backgroundColor: ThemeColor().primaryColor,
      automaticallyImplyLeading: false,
      title: Text(title),
      actions: [
        PopupMenuButton(
          onSelected: (val) {
            if (val == 'More apps') {
              launchFilter({'link': ''});
            } else if (val == 'Follow me') {
              launchFilter({'link': 'https://twitter.com/emeka_michael'});
            } else if (val == 'About developer') {
              launchFilter({'link': 'https://mc-stephen.000webhostapp.com'});
            } else if (val == 'Rate us') {
              launchFilter({'link': ''});
            } else if (val == 'Feedback') {
              launchFilter({
                'mail': {
                  'toMail': 'stephenugo939@gmail.com',
                  'subject': 'All 9ja Network Codes',
                  'message':
                      'Hi There! i love your app, but i will like to also say : '
                },
              });
            }
          },
          color: ThemeColor().lightOpacity,
          icon: const Icon(
            Icons.more_vert_rounded,
          ),
          itemBuilder: (_) => [
            for (var popupButtonItemText in popupButtonItemTexts)
              PopupMenuItem(
                height: 40.0,
                value: popupButtonItemText,
                child: TextWidget(
                    text: popupButtonItemText,
                    fontSized: 14.0,
                    color: ThemeColor().textColor),
              ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

//==================================================
// POP UP BOX TITLE WIDGET (ADD MORE / DESCRIPTION)
//==================================================
Widget popupMenuTitleWidget(text) {
  return Container(
    width: double.infinity,
    alignment: Alignment.center,
    padding: const EdgeInsets.all(10.0),
    decoration: const BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: Colors.grey,
        ),
      ),
    ),
    child: TextWidget(text: text, color: ThemeColor().textColor),
  );
}

//===============================================
// TEXT WIDGET
//===============================================
class TextWidget extends StatelessWidget {
  final String text;
  final fontSized;
  final color;
  final textAligned;
  final fontWeighted;
  const TextWidget(
      {Key? key,
      required this.text,
      this.fontSized,
      this.color,
      this.textAligned,
      this.fontWeighted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAligned ?? TextAlign.start,
      style: TextStyle(
        fontWeight: fontWeighted ?? FontWeight.normal,
        fontSize: fontSized ?? 15.0,
        color: color ?? ThemeColor().textColor,
      ),
    );
  }
}

//==============================================================
/// SNACK BAR WIDGET
//==============================================================
class SnackBarWidget extends SnackBar {
  const SnackBarWidget({
    Key? key,
    required super.content,
    super.backgroundColor = Colors.pink,
  }) : super(key: key);
}

showSnackBar(msg) {
  BuildContext v = navigatorKey.currentContext as BuildContext;
  ScaffoldMessenger.of(v).showSnackBar(SnackBarWidget(content: Text(msg)));
}
