import 'package:flutter/material.dart';
class IDE extends StatefulWidget {
  const IDE({Key? key}) : super(key: key);

  @override
  State<IDE> createState() => _IDEState();
}

class _IDEState extends State<IDE> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF464646),
      body: bodyScreen(),

    );
  }

  Widget bodyScreen(){
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title(),
            Expanded(child: textEditor(),)
          ],
        ),
        Positioned(bottom: 50,
          left: 15,child: Container(
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF292525)
            ),
            padding: const EdgeInsets.all(9),
            child: const Icon(
              Icons.save,
              color: Color(0xFFD9D9D9),
              size: 50,
            ),
          ),),
        Positioned(bottom: 50, left: 0, right: 0,child: Container(
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF292525)
          ),
          alignment: Alignment.center,
          padding: const EdgeInsets.all(9),
          child: const Icon(
            Icons.bluetooth_audio,
            color: Color(0xFFD9D9D9),
            size: 50,
          ),
        )),
        Positioned(bottom: 50, right: 15,child: Container(
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF292525)
          ),
          padding: const EdgeInsets.all(9),
          child: const Icon(
            Icons.play_arrow,
            color: Color(0xFFD9D9D9),
            size: 50,
          ),
        ))
      ],
    );
  }

  Widget title(){
    return Row(
      children: [
        Container(
          margin:const  EdgeInsets.only(top: 40, left: 20, right: 20,bottom: 10),
          child: const Icon(
            Icons.menu, color: Colors.white,size: 30,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 40, left: 10, bottom: 10),
          child: const Text(
            "TOD",
            style: TextStyle(color: Colors.white, fontSize: 30,fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Widget textEditor(){
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF908585),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.only(bottom: 105,top: 10,left: 20,right: 20),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: const TextField(
        keyboardType: TextInputType.multiline,
        maxLines: null,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Put your code here',
        ),
      ),
    );
  }
}
