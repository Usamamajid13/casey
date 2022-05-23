import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

class VotingScreen extends StatefulWidget {
  const VotingScreen({Key? key}) : super(key: key);

  @override
  State<VotingScreen> createState() => _VotingScreenState();
}

class _VotingScreenState extends State<VotingScreen> {
  var nameCount = 2;
  List<TextEditingController> controllers = [];

  @override
  void initState() {
    getNames();
    super.initState();
  }

  List<String> votes = [];

  getNames() async {
    votes.clear();
    controllers.clear();
    final prefs = await SharedPreferences.getInstance();
    var nameListCount = prefs.getStringList("names");
    var oldVotes = prefs.getStringList("votes");
    if (nameListCount == null) {
      for (int i = 0; i < 2; i++) {
        controllers.add(TextEditingController());
      }
      nameCount = 2;
      setState(() {});
    } else {
      for (int i = 0; i < nameListCount.length; i++) {
        nameCount = nameListCount.length;
        controllers.add(TextEditingController());
        controllers[i].text = nameListCount[i];
      }
    }
    if (oldVotes == null) {
      for (int i = 0; i < 2; i++) {
        votes.add("0");
      }
      nameCount = 2;
      votes.add("0");
      setState(() {});
    } else {
      for (int i = 0; i < oldVotes.length; i++) {
        votes.add("0");
        votes[i] = oldVotes[i];
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pinkColor,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
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
                    "VOTE FOR ONE \n PLAYER BELOW: ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  for (int i = 0; i < nameCount; i++)
                    controllers.isEmpty
                        ? const CupertinoActivityIndicator()
                        : Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  votingDialog(index: i,text: controllers[i].text);
                                },
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  height: 50,
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
                                              fontSize: 19),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                            child: Text(
                                          controllers[i].text.toString(),
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        // Text(
                                        //   votes[i].toString(),
                                        //   style: const TextStyle(
                                        //     color: Colors.black,
                                        //     fontSize: 18,
                                        //     fontWeight: FontWeight.w600,
                                        //   ),
                                        // ),
                                        // const SizedBox(
                                        //   width: 10,
                                        // )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
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
              onTap: (){
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
          )
        ],
      ),
    );
  }

  votingDialog({index,text}) {
    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return Dialog(
              child: GestureDetector(
                onTap: () async {
                  final prefs = await SharedPreferences.getInstance();
                  votes[index] = (int.parse(votes[index]) + 1).toString();
                  Navigator.pop(context);
                  prefs.setStringList("votes", votes);
                  getNames();
                },
                child: Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width * 0.4,
                  decoration: BoxDecoration(
                      color: darkPinkColor,
                      border: Border.all(
                        color: Colors.black,
                        width: 3,
                      )),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                        Text(
                          "Voting $text",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "SUBMIT",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
