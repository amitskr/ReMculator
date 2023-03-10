import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String userInput = "";
  String result = "0";

  List<String> buttonList = [
    'AC',
    '(',
    ')',
    '/',
    '7',
    '8',
    '9',
    '*',
    '4',
    '5',
    '6',
    '+',
    '1',
    '2',
    '3',
    '-',
    'C',
    '0',
    '.',
    '=',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Column(children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 3,
          child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            Container(
              padding: const EdgeInsets.all(10),
              alignment: Alignment.centerRight,
              color: const Color.fromARGB(255, 5, 113, 190),
              // decoration: const BoxDecoration(
              //     image: DecorationImage(
              //         image: AssetImage('assets/images/weebpreview.jpg'),
              //         fit: BoxFit.cover)),
              child: Text(
                userInput,
                style: const TextStyle(
                  fontSize: 32,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              alignment: Alignment.centerRight,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/Rem.webp'),
                      fit: BoxFit.cover)),
              child: Text(
                result,
                style: const TextStyle(
                  fontSize: 48,
                  color: Colors.white,
                ),
              ),
            ),
          ]),
        ),
        const Divider(color: Colors.white),
        Expanded(
          child: Container(
              padding: const EdgeInsets.all(10),
              child: GridView.builder(
                  itemCount: buttonList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12),
                  itemBuilder: (BuildContext context, int index) {
                    return customButton(buttonList[index]);
                  })),
        )
      ]),
    );
  }

  Widget customButton(String text) {
    return InkWell(
      splashColor: Colors.white,
      onTap: () {
        setState(() {
          handleButtons(text);
        });
      },
      child: Ink(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 5, 113, 190),
            borderRadius: BorderRadius.circular(10),
            // boxShadow: const [
            //   BoxShadow(
            //     blurRadius: 4,
            //     color: Colors.white,
            //     spreadRadius: 0.5,
            //     offset: Offset(-3, -3),
            //   )
            //]
          ),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          )),
    );
  }

  handleButtons(String text) {
    if (text == "AC") {
      userInput = "";
      result = "0";
      return;
    }

    if (text == "C") {
      if (userInput.isNotEmpty) {
        userInput = userInput.substring(0, userInput.length - 1);
        return;
      } else {
        return null;
      }
    }

    if (text == '=') {
      result = calculate();
      if (result.endsWith(".0")) {
        result = result.replaceAll(".0", "");
      }
    }

    userInput = userInput + text;
  }

  String calculate() {
    try {
      var exp = Parser().parse(userInput);
      var eval = exp.evaluate(EvaluationType.REAL, ContextModel());
      return eval.toString();
    } catch (e) {
      return "Error";
    }
  }
}
