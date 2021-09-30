import 'package:cs_test/models/models.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MedicationCell extends StatefulWidget {
  final Medication medication;

  @override
  State<StatefulWidget> createState() => _MedicationCellState();

  MedicationCell({Key key, @required this.medication}) : super(key: key);
}

class _MedicationCellState extends State<MedicationCell> {
  double _animatedHeight = 0.0;

  @override
  Widget build(BuildContext context) {
    var medication = this.widget.medication;

    return Stack(children: [
      AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        child: Container(
            margin: EdgeInsets.only(top: 60, left: 48, right: 20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildDropdownRow(context, "assets/icons/count-down.svg",
                      medication.remainingTime),
                  // Medication do not have this
                  _buildDropdownRow(
                      context,
                      "assets/icons/healthcare-provider.svg",
                      "Dr. Peter Vadas"),
                  // Medication do not have this
                  _buildDropdownRow(context, "assets/icons/date-calendar.svg",
                      "no appointment"),
                  // Medication do not have this
                  _buildDropdownRow(context, "assets/icons/documents-files.svg",
                      "1 Document"),
                  Divider(
                    thickness: 3,
                  ),
                  _buildNoteRow(context, medication.notes)
                ])),
        margin: EdgeInsets.only(left: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(100),
              blurRadius: 10.0,
              spreadRadius: 1.0,
              offset: Offset(
                0.0, // horizontal, move right 10
                5.0, // vertical, move down 10
              ),
            )
          ],
        ),
        height: _animatedHeight,
      ),
      GestureDetector(
          onTap: () => setState(() {
            _animatedHeight != 0.0
                ? _animatedHeight = 0.0
                : _animatedHeight = 300.0;
          }),
          child: Container(
              padding: EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(19),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(100),
                    blurRadius: 10.0,
                    spreadRadius: 1.0,
                    offset: Offset(
                      0.0,
                      5.0,
                    ),
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                      child: Container(
                        width: 60,
                        height: 60,
                        padding: EdgeInsets.all(16),
                        child: SvgPicture.asset("assets/icons/medication.svg",
                            color: _animatedHeight == 0.0 ? Theme.of(context).primaryColor : Colors.white),
                        decoration: BoxDecoration(
                            color: _animatedHeight == 0.0 ? Color.fromARGB(255, 237, 246, 245) : Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(15)),
                      )),
                  Flexible(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Medication",
                              style: TextStyle(fontWeight: FontWeight.w200)),
                          Text("${medication.name} ${medication.dosage}${medication.dosageType}",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ],
                      )),
                  Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Time",
                              style: TextStyle(fontWeight: FontWeight.w200)),
                          Text(DateFormat("hh:mma").format(medication.closestTimeIntervalToNow),
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ],
                      )),
                  Flexible(
                      child: Container(
                        child: _animatedHeight == 0.0 ? SvgPicture.asset("assets/icons/arrow-drop-down.svg") : SvgPicture.asset("assets/icons/arrow-up.svg"),
                      ))
                ],
              ))),
    ]);
  }

  Widget _buildDropdownRow(BuildContext context, String asset, String text) {
    return Row(children: <Widget>[
      SvgPicture.asset(
        asset,
        width: 16,
        height: 16,
      ),
      Padding(
        child: Text(text, style: TextStyle(fontWeight: FontWeight.w300)),
        padding: EdgeInsets.only(left: 8),
      )
    ]);
  }

  Widget _buildNoteRow(BuildContext context, String notes) {
    return Row(
      children: <Widget>[
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Notes", style: TextStyle(fontWeight: FontWeight.w200)),
              Text(notes, style: TextStyle(fontWeight: FontWeight.w300))],
          ),
        )
      ],
    );
  }
}