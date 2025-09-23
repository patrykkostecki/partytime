import 'package:flutter/material.dart';
import 'package:partytime/components/navbar.dart';
import 'package:partytime/style/app_colors.dart';

class ChallangePage extends StatelessWidget {
  const ChallangePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(),
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/backgrounds/background3.png'),
            // colorFilter: ColorFilter.mode(
            //   Colors.black.withOpacity(0.3),
            //   BlendMode.dstATop,
            // ),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 27),
              Text(
                "Wyzwanie \n dla Adam",
                style: TextStyle(
                  fontFamily: 'Jomhuria',
                  fontSize: 96,
                  color: Colors.white,
                  height: 0.80,
                ),
              ),
              SizedBox(height: 30),
              Container(
                width: 300,
                height: 200,
                decoration: BoxDecoration(
                  color: AppColors.basicButton,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Center(
                    child: Text(
                      "Musi oblać Cię piwem osoba po prawej stronie",
                      style: TextStyle(
                        fontFamily: 'PlexSans',
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(left: 70.0),
                child: SizedBox(
                  width: 270,
                  height: 78,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Punkt',
                      style: TextStyle(
                        fontFamily: 'Jomhuria',
                        fontSize: 64,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.questionGame,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 70.0),
                child: SizedBox(
                  width: 270,
                  height: 78,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Szot',
                      style: TextStyle(
                        fontFamily: 'Jomhuria',
                        fontSize: 64,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.challangeGame,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
