import 'package:flutter/material.dart';
import 'package:sorttrash/quiz/quizmultiples.dart';
import '../button.dart';
import 'package:audioplayers/audioplayers.dart';
import '../../composents/game_settings.dart';

class QuizGestes extends StatefulWidget {
  final String question;
  final String photo1;
  final String photo2;
  final int reponseCorrecte;
  final EXPLICATION explication;
  final String SoundPath;
  const QuizGestes({
    super.key,
    required this.question,
    required this.photo1,
    required this.photo2,
    required this.reponseCorrecte,
    required this.explication,
    required this.SoundPath,
  });

  @override
  State<QuizGestes> createState() => _QuizGestesState();
}

class _QuizGestesState extends State<QuizGestes> {
  int? reponseUtilisateur;
  final _player = AudioPlayer();
  final _audio = AudioCache();
  String showState = "none";
  Future<void> waitAndPop() async {
    await Future.delayed(const Duration(seconds: 1));
    Navigator.pop(context);
  }

  void replay() {
    Navigator.pop(context, true);
  }

  void decoy() {}

  @override
  void initState() {
    _audio.load('music/correct.mp3');
    _audio.load('music/wrong.mp3');
    _audio.load(widget.SoundPath);
    _player.play(AssetSource(widget.SoundPath));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg-image3.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 0.05 * MediaQuery.of(context).size.height,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children:  [
                    SizedBox(
                      width: 20.0,
                    ),
                   InkWell(
                      onTap: () async {
                        _player.stop();
                        await Navigator.popAndPushNamed(context, '/Nquiz');
                      },
                      child: Container(
                        height: 40.0,
                        width: 40.0,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 102, 235, 0),
                              spreadRadius: 0,
                              blurRadius: 0,
                              offset: const Offset(
                                  0, 4.2), // changes position of shadow
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Center(
                          child: Container(
                            height: 35.0,
                            width: 35.0,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 102, 235, 0),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    GamesSettings(
                      functionToBeUsed: replay,
                      functionToResumeTimer: decoy,
                      functionToStopTimer: decoy,
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                  ],
                ),
              ],
            ),
            Stack(
              children: [
                Container(
                  //le container qui contient le corps du quiz
                  height: 0.72 * MediaQuery.of(context).size.height,
                ),
                Positioned(
                  child: Center(
                    child: Container(
                      //le carré blanc qui contient les quiz
                      height: 0.7 * MediaQuery.of(context).size.height,
                      width: 0.75 * MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(33.0),
                        color: Colors.white.withOpacity(0.8),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 0, 0, 0)
                                .withOpacity(0.5),
                            offset: const Offset(0, 5),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 0.4 * MediaQuery.of(context).size.height,
                            width: 0.6 * MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  height:
                                      0.38 * MediaQuery.of(context).size.height,
                                  width:
                                      0.22 * MediaQuery.of(context).size.width,
                                  child: Stack(
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          setState(() {
                                            reponseUtilisateur = 1;
                                            showState =
                                                widget.reponseCorrecte == 1
                                                    ? "yes"
                                                    : "no";
                                            if (showState == "yes") {
                                              _player.play(AssetSource(
                                                  'music/correct.mp3'));
                                              _player.stop();
                                            } else {
                                              _player.play(AssetSource(
                                                  'music/wrong.mp3'));
                                              _player.stop();
                                            }
                                          });
                                          await waitAndPop();
                                        },
                                        child: Container(
                                          height: 0.35 *
                                              MediaQuery.of(context)
                                                  .size
                                                  .height,
                                          width: 0.2 *
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            border: Border.all(
                                              width: 2.0,
                                              color: showState == "yes" &&
                                                      reponseUtilisateur == 1
                                                  ? Colors.green
                                                  : showState == "no" &&
                                                          reponseUtilisateur ==
                                                              1
                                                      ? Colors.red
                                                      : const Color.fromARGB(
                                                          255, 251, 194, 240),
                                            ),
                                            color:
                                                Colors.white.withOpacity(0.8),
                                            boxShadow: [
                                              BoxShadow(
                                                color: const Color.fromARGB(
                                                        255, 0, 0, 0)
                                                    .withOpacity(0.5),
                                                offset: const Offset(0, 5),
                                                blurRadius: 10,
                                              ),
                                            ],
                                          ),
                                          child: Image(
                                            image: AssetImage(widget.photo1),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: -1,
                                        right: -1,
                                        child: showState == "yes" &&
                                                reponseUtilisateur == 1
                                            ? SizedBox(
                                                height: 0.1 *
                                                    MediaQuery.of(context)
                                                        .size
                                                        .height,
                                                width: 0.05 *
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width,
                                                child: const Image(
                                                  image: AssetImage(
                                                      "assets/images/juste.png"),
                                                ),
                                              )
                                            : showState == "no" &&
                                                    reponseUtilisateur == 1
                                                ? SizedBox(
                                                    height: 0.1 *
                                                        MediaQuery.of(context)
                                                            .size
                                                            .height,
                                                    width: 0.05 *
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    child: const Image(
                                                      image: AssetImage(
                                                          "assets/images/faux.png"),
                                                    ),
                                                  )
                                                : Container(),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height:
                                      0.38 * MediaQuery.of(context).size.height,
                                  width:
                                      0.22 * MediaQuery.of(context).size.width,
                                  child: Stack(
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          setState(() {
                                            reponseUtilisateur = 2;
                                            showState =
                                                widget.reponseCorrecte == 2
                                                    ? "yes"
                                                    : "no";
                                            if (showState == "yes") {
                                              _player.play(AssetSource(
                                                  'music/correct.mp3'));
                                              _player.stop();
                                            } else {
                                              _player.play(AssetSource(
                                                  'music/wrong.mp3'));
                                              _player.stop();
                                            }
                                          });
                                          await waitAndPop();
                                        },
                                        child: Container(
                                          height: 0.35 *
                                              MediaQuery.of(context)
                                                  .size
                                                  .height,
                                          width: 0.2 *
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            border: Border.all(
                                              width: 2.0,
                                              color: showState == "yes" &&
                                                      reponseUtilisateur == 2
                                                  ? Colors.green
                                                  : showState == "no" &&
                                                          reponseUtilisateur ==
                                                              2
                                                      ? Colors.red
                                                      : const Color.fromARGB(
                                                          255, 251, 194, 240),
                                            ),
                                            color:
                                                Colors.white.withOpacity(0.8),
                                            boxShadow: [
                                              BoxShadow(
                                                color: const Color.fromARGB(
                                                        255, 0, 0, 0)
                                                    .withOpacity(0.5),
                                                offset: const Offset(0, 5),
                                                blurRadius: 10,
                                              ),
                                            ],
                                          ),
                                          child: Image(
                                            image: AssetImage(widget.photo2),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: -1,
                                        right: -1,
                                        child: showState == "yes" &&
                                                reponseUtilisateur == 2
                                            ? SizedBox(
                                                height: 0.1 *
                                                    MediaQuery.of(context)
                                                        .size
                                                        .height,
                                                width: 0.05 *
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width,
                                                child: const Image(
                                                  image: AssetImage(
                                                      "assets/images/juste.png"),
                                                ),
                                              )
                                            : showState == "no" &&
                                                    reponseUtilisateur == 2
                                                ? SizedBox(
                                                    height: 0.1 *
                                                        MediaQuery.of(context)
                                                            .size
                                                            .height,
                                                    width: 0.05 *
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    child: const Image(
                                                      image: AssetImage(
                                                          "assets/images/faux.png"),
                                                    ),
                                                  )
                                                : Container(),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            //le container des questions
                            height: 0.15 * MediaQuery.of(context).size.height,
                            width: 0.6 * MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 242, 220, 247),
                              borderRadius: BorderRadius.circular(18.0),
                              border: Border.all(
                                color: const Color.fromARGB(255, 251, 194, 240),
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(181, 44, 43, 43)
                                      .withOpacity(0.5),
                                  offset: const Offset(0, 5),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            alignment: Alignment.center,
                            child: Center(
                                child: Text(
                              widget.question,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 218, 78, 204),
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: () async {
                _player.stop();
                _player.play(AssetSource(widget.SoundPath));
              },
              child: Container(
                height: 40.0,
                width: 40.0,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(255, 210, 23, 5),
                      spreadRadius: 0,
                      blurRadius: 0,
                      offset:
                          const Offset(0, 4.2), // changes position of shadow
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Center(
                  child: Container(
                    height: 35.0,
                    width: 35.0,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 210, 23, 5),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.volume_up,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
