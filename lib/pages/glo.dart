import 'package:naija_network_ussd_code/components/reuses_widget.dart';
import 'package:naija_network_ussd_code/theme/theme.dart';
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';

class Glo extends StatefulWidget {
  const Glo({Key? key}) : super(key: key);
  @override
  State<Glo> createState() => _GloState();
}

class _GloState extends State<Glo> {
  @override
  void initState() {
    gloBox = Hive.box('gloNetwork');
    rerunFunction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: MyAppBar(
        title: 'GLO network codes',
        onPressed: (String value) {},
      ),
      body: Stack(
        children: [
          Body(
            onPressed: (value) {
              if (value != '') {
                if (value.keys.toString() == '(desc)') {
                  showCodeDetailsWidget = true;
                  codeDescription = value['desc'];
                  floatingActionBtnIcon = Icons.close_rounded;
                }
              }
              setState(() {});
            },
          ),
          if (showAddMoreWidget == true)
            AddMore(
              onPressed: (String value) {
                showAddMoreWidget = false;
                floatingActionBtnIcon = Icons.add;
                setState(() {});
              },
            ),
          if (showCodeDetailsWidget == true) const CodeDetailsWidget(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (floatingActionBtnIcon == Icons.add) {
            showAddMoreWidget = true;
            showCodeDetailsWidget = false;
            showEdgitWidget = false;
            floatingActionBtnIcon = Icons.close_rounded;
          } else {
            showAddMoreWidget = false;
            showCodeDetailsWidget = false;
            floatingActionBtnIcon = Icons.add;
            _titleController.clear();
            _shortCodeController.clear();
            _descriptionController.clear();
          }
          setState(() {});
        },
        child: Icon(floatingActionBtnIcon),
        backgroundColor: ThemeColor().primaryColor,
      ),
    );
  }
}

//==============================================================
// BODY
//==============================================================
class Body extends StatelessWidget {
  final ValueChanged onPressed;
  const Body({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.fromLTRB(10.0, 95.0, 10.0, 10.0),
        child: Column(
          children: [
            for (int i = dbNetworkDetails.length - 1; i >= 0; i--)
              GestureDetector(
                  onTap: () => onPressed(
                      {'desc': dbNetworkDetails.elementAt(i)['description']}),
                  onLongPress: () {
                    int codeIndex = gloBox.toMap().keys.elementAt(i);
                    List<String> popupDialogText = ['Edit', 'Delete'];
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const TextWidget(
                            text: 'Choose an action!',
                            fontSized: 20.0,
                          ),
                          titlePadding:
                              const EdgeInsets.only(top: 10.0, left: 10.0),
                          contentPadding:
                              const EdgeInsets.only(bottom: 10.0, left: 10.0),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              for (var a = 0; a < popupDialogText.length; a++)
                                TextButton(
                                  onPressed: () {
                                    if (a == 0) {
                                      showEdgitWidget = true;
                                      showAddMoreWidget = true;
                                      floatingActionBtnIcon =
                                          Icons.close_rounded;
                                      _titleController.text = dbNetworkDetails
                                          .elementAt(i)['title']
                                          .toString();
                                      _shortCodeController.text =
                                          dbNetworkDetails
                                              .elementAt(i)['shortcode']
                                              .toString();
                                      _descriptionController.text =
                                          dbNetworkDetails
                                              .elementAt(i)['description']
                                              .toString();
                                      codeIndexThatNeedChanges = codeIndex; //?!
                                    } else {
                                      gloBox.deleteAll([codeIndex]);
                                    }
                                    rerunFunction();
                                    onPressed('');
                                    Navigator.pop(context);
                                  },
                                  style: TextButton.styleFrom(
                                    backgroundColor: a == 0
                                        ? ThemeColor().primaryColor
                                        : Colors.red,
                                  ),
                                  child: TextWidget(text: popupDialogText[a]),
                                ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: codesWidget(
                      dbNetworkDetails.elementAt(i)['shortcode'] as String,
                      dbNetworkDetails.elementAt(i)['title'] as String)),
            // for the normal inbuilt networks codes
            for (int i = builtInNetworkDetails.length - 1; i >= 0; i--)
              GestureDetector(
                onTap: () => onPressed({
                  'desc': builtInNetworkDetails.elementAt(i)['description']
                }),
                child: codesWidget(
                    builtInNetworkDetails.elementAt(i)['shortcode'] as String,
                    builtInNetworkDetails.elementAt(i)['title'] as String),
              ),
          ],
        ),
      ),
    );
  }
}

//==================================
// ADD MORE CODES TO THE LIST WIDGET
//==================================
class AddMore extends StatelessWidget {
  final ValueChanged<String> onPressed;
  const AddMore({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.grey.withOpacity(0.7),
      padding: const EdgeInsets.only(top: 50.0),
      child: Center(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: ThemeColor().secondaryColor,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                popupMenuTitleWidget('ADD NEW CODE'),
                for (var i = 0; i < allHintText.length; i++)
                  textFieldWidget(
                      textFieldHeight[i], allHintText[i], allController[i]),
                Container(
                  width: double.infinity,
                  height: 40.0,
                  margin: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: ThemeColor().primaryColor,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: TextButton(
                    onPressed: () {
                      final String title = _titleController.text;
                      final String shortCode = _shortCodeController.text;
                      final String description = _descriptionController.text;

                      if (title.isEmpty ||
                          shortCode.isEmpty ||
                          description.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: TextWidget(
                                  text: 'Some text field are empty',
                                  color: ThemeColor().textColor),
                              backgroundColor: ThemeColor().lightOpacity),
                        );
                      } else {
                        if (showEdgitWidget == false) {
                          int increementedNumber = gloBox.length > 0
                              ? gloBox.keys.last + 1
                              : gloBox.length;
                          gloBox.put(
                            increementedNumber,
                            {
                              'code': shortCode,
                              'title': title,
                              'desc': description
                            },
                          );
                        } else {
                          gloBox.put(
                            codeIndexThatNeedChanges,
                            {
                              'code': shortCode,
                              'title': title,
                              'desc': description
                            },
                          );
                          showEdgitWidget = false;
                        }
                        onPressed('');
                        rerunFunction();
                      }

                      _titleController.clear();
                      _shortCodeController.clear();
                      _descriptionController.clear();
                    },
                    child: TextWidget(
                        text: 'Add code', color: ThemeColor().primaryTextColor),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//==================================
// DESCRIPTION WIDGET
//==================================
class CodeDetailsWidget extends StatelessWidget {
  const CodeDetailsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.grey.withOpacity(0.7),
      child: Center(
        child: Container(
          height: 300.0,
          width: double.infinity,
          margin: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: ThemeColor().secondaryColor,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              popupMenuTitleWidget('DESCRIPTION'),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  child: TextWidget(text: codeDescription),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//==================================
// TEXT FEILD WIDGET
//==================================
Widget textFieldWidget(height, hintText, controller) {
  return Container(
    height: height,
    margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
    padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
    decoration: BoxDecoration(
      color: ThemeColor().lightOpacity,
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: TextField(
      controller: controller,
      cursorColor: ThemeColor().primaryColor,
      style: const TextStyle(),
      decoration: InputDecoration(
        hintText: hintText,
        border: InputBorder.none,
      ),
    ),
  );
}

//==========================
// CODE WIDGET CONTAINER
//==========================
Widget codesWidget(shortcode, title) {
  return Container(
    height: 65.0,
    margin: const EdgeInsets.only(bottom: 10.0),
    padding: const EdgeInsets.all(10.0),
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
      ],
    ),
    child: Row(
      children: [
        Expanded(
          child: TextWidget(text: title),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: TextWidget(
            text: shortcode,
            fontSized: 17.0,
            fontWeighted: FontWeight.bold,
          ),
        ),
        Container(
          width: 40.0,
          height: 40.0,
          decoration: BoxDecoration(
            color: ThemeColor().primaryColor,
            borderRadius: BorderRadius.circular(50.0),
          ),
          child: IconButton(
            onPressed: () {
              launchFilter({'dial': shortcode});
            },
            icon: Icon(
              Icons.phone,
              color: ThemeColor().primaryTextColor,
            ),
          ),
        )
      ],
    ),
  );
}

//==================================
// VARIABLES
//==================================
late Box gloBox;

bool showEdgitWidget = false;

late Set<Map<String, String>> dbNetworkDetails;

late int codeIndexThatNeedChanges;

String codeDescription = 'Description unavailable!';

IconData floatingActionBtnIcon = Icons.add;

bool showAddMoreWidget = false;
bool showCodeDetailsWidget = false;

TextEditingController _titleController = TextEditingController();
TextEditingController _shortCodeController = TextEditingController();
TextEditingController _descriptionController = TextEditingController();

List<String> allHintText = [
  'Enter code title here',
  'Enter short code here',
  'Enter code description here'
];

List<TextEditingController> allController = [
  _titleController,
  _shortCodeController,
  _descriptionController
];

List<double> textFieldHeight = [47.0, 47.0, 80.0];

//==========================================
// USER DATABASE (HIVE) NETWORK CODE OBJECT
//==========================================
rerunFunction() {
  dbNetworkDetails = {
    for (var i = 0; i < gloBox.length; i++)
      {
        'shortcode': '${gloBox.toMap()[gloBox.keys.elementAt(i)]['code']}',
        'title': '${gloBox.toMap()[gloBox.keys.elementAt(i)]['title']}',
        'description': '${gloBox.toMap()[gloBox.keys.elementAt(i)]['desc']}'
      },
  };
}

//=============================
// BUILT IN NETWORK CODE OBJECT
//=============================
Set<Map<String, String>> builtInNetworkDetails = {
  {'shortcode': '#124#', 'title': 'Check airtime balance', 'description': ''},
  {'shortcode': '*999#', 'title': 'Check data balance', 'description': ''},
  {'shortcode': '#123#', 'title': 'Glo recharge line', 'description': ''},
  {'shortcode': '#453#', 'title': 'Glo yakata', 'description': ''},
};
