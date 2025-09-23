// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:partytime/components/navbar.dart';
import 'package:partytime/config/app_routes.dart';
import 'package:partytime/style/app_colors.dart';

class PlayersPage extends StatelessWidget {
  const PlayersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 27),
            Text(
              'Podaj ilość\n    graczy',
              style: TextStyle(
                fontSize: 96,
                fontFamily: 'Jomhuria',
                color: Colors.white,
                height: 0.67,
              ),
            ),
            Spacer(),
            Container(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(width: 13),
                  UnconstrainedBox(
                    child: SizedBox(
                      height: 37,
                      width: 37,
                      child: Image.asset('assets/pictures/people-group.png'),
                    ),
                  ),
                  SizedBox(width: 20),
                  SizedBox(
                    width: 70,
                    height: 40,
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: AppColors.ininput),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: AppColors.ininput),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: AppColors.ininput),
                        ),
                        hintText: "0",
                        hintStyle: const TextStyle(color: Colors.white54),
                        filled: true,
                        fillColor: const Color.fromARGB(99, 156, 152, 152),

                        contentPadding: EdgeInsets.symmetric(vertical: 8),
                      ),

                      style: const TextStyle(color: Colors.white, fontSize: 20),
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              width: 156,
              height: 58,
              decoration: BoxDecoration(
                color: AppColors.input,
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
            ),
            Spacer(),

            SizedBox(height: 10),
            Row(
              children: [
                SizedBox(width: 12),
                Row(
                  children: [
                    Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(width: 13),
                          UnconstrainedBox(
                            child: SizedBox(
                              height: 37,
                              width: 37,
                              child: Image.asset('assets/pictures/user.png'),
                            ),
                          ),
                          SizedBox(width: 20),
                          SizedBox(
                            width: 210,
                            height: 40,
                            child: TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                    color: AppColors.ininput,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                    color: AppColors.ininput,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                    color: AppColors.ininput,
                                  ),
                                ),
                                hintStyle: const TextStyle(
                                  color: Colors.white54,
                                ),
                                filled: true,
                                fillColor: const Color.fromARGB(
                                  99,
                                  156,
                                  152,
                                  152,
                                ),

                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 8,
                                ),
                              ),

                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      width: 300,
                      height: 58,
                      decoration: BoxDecoration(
                        color: AppColors.input,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 10),
                SizedBox(
                  width: 58,
                  height: 58,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: UnconstrainedBox(
                      child: SizedBox(
                        width: 10,
                        height: 10,
                        child: Image.asset('assets/pictures/plus-small.png'),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.input,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                SizedBox(width: 12),
                Row(
                  children: [
                    Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(width: 13),
                          UnconstrainedBox(
                            child: SizedBox(
                              height: 37,
                              width: 37,
                              child: Image.asset('assets/pictures/user.png'),
                            ),
                          ),
                          SizedBox(width: 20),
                          SizedBox(
                            width: 210,
                            height: 40,
                            child: TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                    color: AppColors.ininput,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                    color: AppColors.ininput,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                    color: AppColors.ininput,
                                  ),
                                ),
                                hintStyle: const TextStyle(
                                  color: Colors.white54,
                                ),
                                filled: true,
                                fillColor: const Color.fromARGB(
                                  99,
                                  156,
                                  152,
                                  152,
                                ),

                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 8,
                                ),
                              ),

                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      width: 300,
                      height: 58,
                      decoration: BoxDecoration(
                        color: AppColors.input,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 10),
                SizedBox(
                  width: 58,
                  height: 58,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: UnconstrainedBox(
                      child: SizedBox(
                        width: 10,
                        height: 10,
                        child: Image.asset('assets/pictures/plus-small.png'),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.input,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                SizedBox(width: 12),
                Row(
                  children: [
                    Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(width: 13),
                          UnconstrainedBox(
                            child: SizedBox(
                              height: 37,
                              width: 37,
                              child: Image.asset('assets/pictures/user.png'),
                            ),
                          ),
                          SizedBox(width: 20),
                          SizedBox(
                            width: 210,
                            height: 40,
                            child: TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                    color: AppColors.ininput,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                    color: AppColors.ininput,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                    color: AppColors.ininput,
                                  ),
                                ),
                                hintStyle: const TextStyle(
                                  color: Colors.white54,
                                ),
                                filled: true,
                                fillColor: const Color.fromARGB(
                                  99,
                                  156,
                                  152,
                                  152,
                                ),

                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 8,
                                ),
                              ),

                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      width: 300,
                      height: 58,
                      decoration: BoxDecoration(
                        color: AppColors.input,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 10),
                SizedBox(
                  width: 58,
                  height: 58,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: UnconstrainedBox(
                      child: SizedBox(
                        width: 10,
                        height: 10,
                        child: Image.asset('assets/pictures/plus-small.png'),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.input,
                    ),
                  ),
                ),
              ],
            ),

            Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.start);
              },
              child: Text(
                'Zaczynajmy!',
                style: TextStyle(fontSize: 48, fontFamily: "Jomhuria"),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.firstButton,
                foregroundColor: Colors.white,
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
