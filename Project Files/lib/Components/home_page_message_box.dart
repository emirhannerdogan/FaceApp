import 'package:flutter/material.dart';

class HomePageMessageBox extends StatelessWidget{

  final String username;
  final String message;
  final String shortName;

  const HomePageMessageBox({super.key, required this.username, required this.message, required this.shortName});

  @override
  Widget build(BuildContext context) {

    final screenSize = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: (){
        // TODO: What will the program do when one of the message boxes is clicked
        print(username);
      },
      child: DecoratedBox(
          decoration: BoxDecoration(
              color: const Color.fromRGBO(63, 51, 81, 1),
              borderRadius: BorderRadius.circular(10)
          ),
          child: SizedBox(
              width: screenSize.width * 0.95,
              height: screenSize.height * 0.09,
              child: Row(
                children: [
                  const SizedBox(width: 10,),
                  CircleAvatar(
                    radius: screenSize.height * 0.03, // 25
                    backgroundColor: const Color.fromRGBO(233, 166, 166, 1),
                    child: Text(
                        shortName
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          username,
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)
                      ),
                      Text(
                          message,
                          style: const TextStyle(
                              fontSize: 15,
                              color: Colors.white70)
                      )
                    ],
                  )
                ],
              )),
      ),
    );
  }
}