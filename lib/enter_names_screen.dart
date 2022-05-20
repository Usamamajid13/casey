import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

class EnterNameScreen extends StatefulWidget {
  const EnterNameScreen({Key? key}) : super(key: key);

  @override
  State<EnterNameScreen> createState() => _EnterNameScreenState();
}

class _EnterNameScreenState extends State<EnterNameScreen> {
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  var nameCount = 2;
  List<TextEditingController> controllers = [];

  @override
  void initState() {
    getNames();
    super.initState();
  }

  getNames() async {
    final prefs = await SharedPreferences.getInstance();
    var nameListCount = prefs.getStringList("names");
    if(nameListCount == null)
      {
        for(int i = 0 ; i < 2 ;i++)
          {

            controllers.add(TextEditingController());
          }
        nameCount = 2;
        setState(() {

        });
      }
    else{
      for(int i = 0 ;i < nameListCount.length;i++)
        {
          nameCount = nameListCount.length;
          controllers.add(TextEditingController());
          controllers[i].text = nameListCount[i];
        }
    }
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pinkColor,
      body: Form(
        key: globalFormKey,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 70,
                    ),
                    Image.asset(
                      "assets/logo.png",
                      scale: 7,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "ENTER NAMES:",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    for (int i = 0; i < nameCount; i++)
                      controllers.length == 0 ? CupertinoActivityIndicator() : Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: const BoxDecoration(
                              color: lightPinkColor,
                            ),
                            child: Center(
                              child: Row(
                                children: [
                                  Text(
                                    "${i + 1}:",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 17),
                                  ),
                                  Expanded(
                                      child: TextFormField(
                                        validator: (val) => !val!.isNotEmpty
                                            ? "Please Enter a name"
                                            : null,
                                        controller: controllers[i],
                                    decoration:
                                        const InputDecoration(border: InputBorder.none),
                                  )),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (nameCount < 25) {
                          nameCount++;
                          controllers.add(TextEditingController());
                        }
                        setState(() {});
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 15),
                        decoration: const BoxDecoration(
                          color: lightPinkColor,
                        ),
                        child: Center(
                          child: Text(
                            ("+").toString(),
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 17),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (nameCount > 2) {
                          nameCount--;
                          controllers.removeLast();
                        }
                        setState(() {});
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 15),
                        decoration: const BoxDecoration(
                          color: lightPinkColor,
                        ),
                        child: Center(
                          child: Text(
                            ("-").toString(),
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 17),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: GestureDetector(
                onTap: () async {
                  if(validateAndSave())
                    {
                      final prefs = await SharedPreferences.getInstance();
                      List<String> allNames = [];
                      List<String> allVotes = [];
                      for(int i = 0 ; i < controllers.length ;i++)
                      {
                        allNames.add( controllers[i].text);
                        allVotes.add("0");
                      }
                      prefs.setStringList("names", allNames);
                      prefs.setStringList("votes", allVotes);
                      Navigator.pop(context);
                    }
                },
                child: Container(
                  width: 100,
                  height: 100,
                  margin: const EdgeInsets.only(top: 40, right: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 3),
                    color: lightPinkColor,
                  ),
                  child: Center(
                    child: Text(
                      ("Save & Return").toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 17),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: GestureDetector(
                onTap: () async {
                      final prefs = await SharedPreferences.getInstance();
                      prefs.remove("names");
                      Navigator.pop(context);
                },
                child: Container(
                  width: 100,
                  height: 100,
                  margin: const EdgeInsets.only(top: 40, right: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 3),
                    color: lightPinkColor,
                  ),
                  child: Center(
                    child: Text(
                      ("Clear Names").toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 17),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }
}
