import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sorttrash/button.dart';
import '../StartPage/settings.dart';
import '../player_box.dart';
import 'key_container.dart';


class ShowChallenge extends StatefulWidget {

  ShowChallenge({Key? key, required this.challengeInformation})
      : super(key: key);
  final String challengeInformation;

  @override
  State<ShowChallenge> createState() => _ShowChallengeState();
}

class _ShowChallengeState extends State<ShowChallenge> {
  final User? user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    globalMusicPlayerStartPage.stop();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/bg-image2.png'),
              fit: BoxFit.fill),
        ),
        child: Stack(
          children: [
            Center(
              child: Container(
                height: 0.6 * MediaQuery.of(context).size.height,
                width: 0.5 * MediaQuery.of(context).size.width,
                color: Colors.transparent,
              ),
            ),
            Center(
              child: Container(
                height: 0.52 * MediaQuery.of(context).size.height,
                width: 0.4 * MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black54,
                      spreadRadius: 0,
                      blurRadius: 0,
                      offset: Offset(0, 7), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 0.26 * MediaQuery.of(context).size.width,
                      height: 0.07 * MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(255, 221, 80, 1),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(width: 1, color: Colors.black54)),
                      child: const Center(
                        child: Text(
                          'Challenge',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Digitalt',
                              fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(height: 0.05555*MediaQuery.of(context).size.height,),
                    Center(child : Text( widget.challengeInformation,textAlign: TextAlign.center, style: const TextStyle( fontSize: 14, fontFamily: 'Digital',color: sm1, ),))

                  ],
                ),
              ),
            ),

            Positioned(left : 0.65*MediaQuery.of(context).size.width,
                top: 0.21666*MediaQuery.of(context).size.height,
                child: const RoundButton(myIcon: Icons.exit_to_app, href: '/games', couleur: Color.fromRGBO(255,221,80, 1), shadowColor: Colors.transparent,)),
            Positioned(
                left: 0.65 * MediaQuery.of(context).size.width,
                top: 0.21666 * MediaQuery.of(context).size.height,
                child: const RoundButton(
                  myIcon: Icons.exit_to_app,
                  href: '/',
                  couleur: Color.fromRGBO(255, 221, 80, 1),
                  shadowColor: Colors.transparent,
                )),
            Positioned(
                left: 0.43 * MediaQuery.of(context).size.width,
                top: 0.694444 * MediaQuery.of(context).size.height,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: sm1,
                        side: const BorderSide(width: 3, color: Colors.white),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        padding: EdgeInsets.only(
                            left: 0.0387 * MediaQuery.of(context).size.width,
                            right: 0.0387 * MediaQuery.of(context).size.width,
                            top: 8,
                            bottom: 10)),
                    onPressed: () {
                      playerProgress.lastChallengeDate = DateTime.now();
                      try {
                        if (currentProfileIndex == 1) {
                          offlineProgress.setChild(
                              globalChildKey, playerProgress);
                          if (parentBox.isEmpty) {
                            parentBox.add(offlineProgress);
                          } else {
                            parentBox.putAt(0, offlineProgress.returnParent());
                          }
                        } else {
                          onlineProgress.setChild(
                              onlineGlobalChildKey, playerProgress);
                          onlineParentBox.put(
                              user!.uid, onlineProgress.returnParent());
                          onlineProgress
                              .returnParent()
                              .updateData(onlineProgress.getUID());
                        }
                      } catch (e) {
                        print(e);
                      }

                    } else {
                      onlineProgress.setChild(onlineGlobalChildKey, playerProgress);
                      onlineParentBox.put(user!.uid, onlineProgress.returnParent());
                      onlineProgress.returnParent().updateData(onlineProgress.getUID());
                    }
                  } catch (e) {
                    print(e);
                  }
                  Navigator.pushNamed(context, '/games');
                }, child: Text('Terminé')))
          ],
        ),
      ),
    );
  }
}
