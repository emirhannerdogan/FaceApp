import 'package:flutter/material.dart';

class ProfilePageBox extends StatelessWidget{

  final IconData icon;
  final String text;

  const ProfilePageBox({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: (){
        // TODO: Click events
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
            color: const Color.fromRGBO(63, 51, 81, 1),
            borderRadius: BorderRadius.circular(10)
        ),
        child: SizedBox(
            width: screenSize.width * 0.95,
            height: screenSize.height * 0.07,
            child: Row(
              children: [
                const SizedBox(width: 10,),
                Transform.rotate(
                  angle: 90 * 3.1415926535897932 / 180,
                  child: Icon(
                    icon,
                    size: 30,
                    color: const Color.fromRGBO(233, 166, 166, 1),
                  ),
                ),
                const SizedBox(width: 10,),
                Text(
                    text,
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white)
                ),
              ],
            )),
      ),
    );
  }
}