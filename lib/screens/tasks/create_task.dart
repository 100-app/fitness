import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart'; //this is an external package for formatting date and time

class CreateTask extends StatefulWidget {
  @override
  _CreateTask createState() => _CreateTask();
}

class _CreateTask extends State<CreateTask> {
  CalendarFormat format = CalendarFormat.month;
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Form(
              child: Column(
                children: <Widget>[
                  TableCalendar(
                      focusedDay: DateTime.now(),
                      firstDay: DateTime(2000),
                      lastDay: DateTime(2050),
                      calendarFormat: format,
                      onFormatChanged: (CalendarFormat _format) {
                        setState(() {
                          format = _format;
                        });
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
