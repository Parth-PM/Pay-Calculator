import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Assignment 1',
      theme: ThemeData(
        primarySwatch: Colors.blue,      
      ),
      home: const MyHomePage(title: 'Pay Calculator'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final hrsControls = TextEditingController();
  final rates = TextEditingController();
  double regularPay = 0;
  double overtimePay = 0;
  double totalPay = 0;
  double tax = 0;

  @override
  void dispose() {
    hrsControls.dispose();
    rates.dispose();
    super.dispose();
  }

  void _calculate() {
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() {
      var hours = double.parse(hrsControls.text);
      var rate = double.parse(rates.text);
      if (hours <= 40) {
        regularPay = hours * rate;
        totalPay = regularPay;
        overtimePay = 0;
      } else {
        regularPay = 40 * rate;
        totalPay = ((hours - 40) * rate * 1.5 + 40 * rate);
        overtimePay = (hours - 40) * rate * 1.5;
      }
      tax = totalPay * 0.18;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.title, style: TextStyle(color: Colors.black),),
        toolbarHeight: 40,
        backgroundColor: Colors.yellow,
      ),
      body: body(),
    );
  }

  Widget body() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              margin: const EdgeInsets.all(15),
              height: 525,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 227, 227, 227),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              child: Column(children: [hours(), rate(), calculate(), report()]),
            ),
          ),
          Container(
            height: 100,
            margin: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 145, 145, 145),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            child: Align(
              alignment: Alignment.center,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SizedBox(
                      height: 30,
                      child: Text(
                        'Parth Maru',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      '301209761',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )
                  ]),
            ),
          )
        ]),
      ),
    );
  }

  Widget hours() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        Container(
          height: 60,
          margin: const EdgeInsets.fromLTRB(25, 10, 25, 0),
          padding: const EdgeInsets.fromLTRB(30, 10, 40, 0),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: TextFormField(
            controller: hrsControls,
            decoration: const InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide.none),
                hintText: 'Number of hours'),
            keyboardType: TextInputType.number,
          ),
        )
      ],
    );
  }

  Widget rate() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        Container(
          height: 60,
          margin: const EdgeInsets.fromLTRB(25, 0, 25, 0),
          padding: const EdgeInsets.fromLTRB(30, 10, 40, 0),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: TextField(
              controller: rates,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  hintText: 'Hourly rate'),
              keyboardType: TextInputType.number),
        )
      ],
    );
  }

  showAlertDialog(BuildContext context) {
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      content: const Text("Please enter the Hours and Rate value."),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget calculate() {
    return Container(
      width: 170,
      margin: const EdgeInsets.all(25),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          padding: const EdgeInsets.all(15),
          foregroundColor: Color.fromARGB(255, 255, 255, 255),
          backgroundColor: Colors.blue, // foreground
        ),
        onPressed: () {
          if (hrsControls.text.isEmpty || rates.text.isEmpty) {
            showAlertDialog(context);
            return;
          }
          _calculate();
        },
        child: const Text(
          'Calculate', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget report() {
    return Container(
      height: 220,
      width: 500,
      margin: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Report',
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline),
            ),
            Row(
              children: [
                const Text(
                  'Regular pay :', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                Text(
                  '$regularPay',
                   style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Row(
              children: [
                const Text(
                  'Overtime pay :', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                Text(
                  overtimePay.toString(),
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Row(
              children: [
                const Text(
                  'Total pay :', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                Text(
                  totalPay.toString(),
                  style: const TextStyle( fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Row(
              children: [
                const Text(
                  'Tax :', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                Text(
                  tax.toString(),
                  style: const TextStyle( fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ],
            )
          ]),
    );
  }
}
