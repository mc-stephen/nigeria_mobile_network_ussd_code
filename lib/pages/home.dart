import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:nigeria_mobile_network_ussd_code/theme/theme.dart';
import 'package:nigeria_mobile_network_ussd_code/routes/route.dart' as route;
import 'package:nigeria_mobile_network_ussd_code/components/component.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    themeBox = Hive.box<bool>('theme');
    if (themeBox.isNotEmpty) {
      bool theme = themeBox.getAt(0) as bool;
      lightTheme = theme;
      return;
    }
    lightTheme = true;
  }

  rebuild() {
    themeBox.putAt(0, !lightTheme);
    lightTheme = themeBox.getAt(0) as bool;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor().lightOpacity,
      appBar: MyAppBar(
        title: 'All 9ja netwok USSD codes',
        onPressed: (String value) {},
      ),
      body: const Body(),
      floatingActionButton: FloatingActionButton(
        elevation: 2.0,
        onPressed: () => rebuild(),
        backgroundColor: ThemeColor().primaryColor,
        child: Icon(themeIcon()),
      ),
    );
  }
}

//==========================================
// variable
//==========================================
late Box<bool> themeBox;

themeIcon() =>
    lightTheme ? Icons.nightlight_round : Icons.brightness_high_rounded;

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
  const Body({Key? key}) : super(key: key);

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
                  Navigator.pushNamed(context, route.codePage, arguments: {});
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
