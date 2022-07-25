import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:naija_network_ussd_code/theme/theme.dart';
import 'package:naija_network_ussd_code/components/reuses_widget.dart';
import 'package:naija_network_ussd_code/routes/route.dart' as route;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    themeBox = Hive.box<bool>('theme');
    var themeDB = themeBox.get('useLightTheme');
    lightTheme =
        themeDB == null ? lightTheme : themeBox.get('useLightTheme') as bool;
    super.initState();
  }

  rebuild() {
    themeBox.put('useLightTheme', !lightTheme);
    lightTheme = themeBox.get('useLightTheme') as bool;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor().lightOpacity,
      appBar: MyAppBar(
        title: 'All 9ja netwok codes',
        onPressed: (String value) {},
      ),
      body: Body(
        onPressed: (String value) {},
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => rebuild(),
        child: Icon(changeThemeIcon()),
        elevation: 2.0,
        backgroundColor: ThemeColor().primaryColor,
      ),
    );
  }
}

//==========================================
// variable
//==========================================
late Box<bool> themeBox;

changeThemeIcon() {
  late IconData iconMode;
  if (lightTheme == true) {
    return iconMode = Icons.nightlight;
  } else {
    return iconMode = Icons.brightness_high_rounded;
  }
}

const List<String> networkNames = ['MTN', 'AIRTEL', '9MOBILE', 'GLO'];
const List<String> networkImages = [
  'mtn.png',
  'airtel.png',
  '9mobile.png',
  'glo.png'
];

//==============================================================
// BODY
//==============================================================
class Body extends StatelessWidget {
  final ValueChanged<String> onPressed;
  const Body({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Center(
        child: GridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          children: [
            for (int i = 0; i < 4; i++)
              GestureDetector(
                onTap: () {
                  networkNames[i] == 'MTN'
                      ? Navigator.pushNamed(context, route.mtnPage)
                      : networkNames[i] == 'AIRTEL'
                          ? Navigator.pushNamed(context, route.airtelPage)
                          : networkNames[i] == '9MOBILE'
                              ? Navigator.pushNamed(context, route.etisalatPage)
                              : networkNames[i] == 'GLO'
                                  ? Navigator.pushNamed(context, route.gloPage)
                                  : null;
                },
                child: networkBox(networkNames[i], networkImages[i]),
              ),
          ],
        ),
      ),
    );
  }
}

//==============================================================
// SIM NETWORK CONTAINER
//==============================================================
Widget networkBox(networkName, networkImg) {
  return Container(
    margin: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
        color: ThemeColor().lightOpacity,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          width: 2.5,
          color: ThemeColor().primaryColor,
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 5.0,
            spreadRadius: 0.0,
            offset: const Offset(5.0, 5.0),
            color: ThemeColor().shadowColor,
          ),
        ]),
    child: Column(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
            child: Image(
              image: AssetImage('assets/img/$networkImg'),
            ),
          ),
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: TextWidget(
              text: networkName,
              fontSized: 15.0,
              color: ThemeColor().textColor),
        ),
      ],
    ),
  );
}
