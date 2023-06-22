import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';

void main() {
  // Intl.defaultLocale = 'vi';
  // initializeDateFormatting('vi', '');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: Time(),
    );
  }
}

class Time extends StatefulWidget {
  @override
  _TimeState createState() => _TimeState();
}
void parseMonth(DateTime date){
  switch (DateFormat('MMM').format(date)) {
    case "Jan":
      // date = "T1";
      break;
  }
}
class _TimeState extends State<Time> with SingleTickerProviderStateMixin {

  bool pickerIsExpanded = false;
  int _pickerYear = DateTime.now().year;
  DateTime _selectedMonth = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    1,
  );

  dynamic _pickerOpen = false;

  void switchPicker() {
    setState(() {
      _pickerOpen ^= true;
    });
  }


  List<Widget> generateRowOfMonths(from, to) {
    List<Widget> months = [];
    for (int i = from; i <= to; i++) {
      DateTime dateTime = DateTime(_pickerYear, i, 1);
      final backgroundColor = dateTime.isAtSameMomentAs(_selectedMonth)
          ? Colors.grey
          : Colors.transparent;

      months.add(
        AnimatedSwitcher(
          duration: kThemeChangeDuration,
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          child: TextButton(
            key: ValueKey(backgroundColor),
            onPressed: () {
              setState(() {
                _selectedMonth = dateTime;
              });
            },
            style: TextButton.styleFrom(
              backgroundColor: backgroundColor,
              shape: CircleBorder(),
            ),
            child: Text(
              DateFormat('MMM').format(dateTime),
            ),
          ),
        ),
      );
    }
    return months;
  }

  List<Widget> generateMonths() {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: generateRowOfMonths(1, 6),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: generateRowOfMonths(7, 12),
      ),
    ];
  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    // initializeDateFormatting(DateFormat.MONTH, "vi");
  }
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Material(
              color: Theme.of(context).cardColor,
              child: AnimatedSize(
                curve: Curves.easeInOut,
                vsync: this,
                duration: Duration(milliseconds: 300),
                child: Container(
                  height: _pickerOpen ? null : 0.0,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Năm ${_pickerYear.toString()}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _pickerYear = _pickerYear - 1;
                              });
                            },
                            icon: Icon(Icons.navigate_before_rounded),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _pickerYear = _pickerYear + 1;
                              });
                            },
                            icon: Icon(Icons.navigate_next_rounded),
                          ),
                        ],
                      ),
                      ...generateMonths(),
                      SizedBox(
                        height: 10.0,
                      ),
                      ElevatedButton(onPressed: switchPicker, child: Text("Submit"))
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(DateFormat.yMMMM().format(_selectedMonth)),
            ElevatedButton(
              onPressed: switchPicker,
              child: Text(
                'Select date',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
