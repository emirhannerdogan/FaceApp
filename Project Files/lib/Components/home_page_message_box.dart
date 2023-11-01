import 'package:flutter/material.dart';

class HomePageMessageBox extends StatelessWidget{

  final String username;
  final String message;
  final String shortName;

  HomePageMessageBox({required this.username, required this.message, required this.shortName});

  @override
  Widget build(BuildContext context) {

    final screenSize = MediaQuery.of(context).size;

    return DecoratedBox(
        decoration: BoxDecoration(
            color: Color.fromRGBO(63, 51, 81, 1),
            borderRadius: BorderRadius.circular(10)
        ),
        child: SizedBox(
            width: screenSize.width * 0.95,
            height: screenSize.height * 0.09,
            child: Row(
              children: [
                SizedBox(width: 10,),
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Color.fromRGBO(233, 166, 166, 1),
                  child: Text(
                      shortName
                  ),
                ),
                SizedBox(width: 10,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        username,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)
                    ),
                    Text(
                        message,
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white70)
                    )
                  ],
                )
              ],
            )),
    );
  }
}