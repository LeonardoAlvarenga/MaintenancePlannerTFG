import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerAndPreviewWidget extends StatefulWidget {
  final TextEditingController dateControllerPreview;
  final TextEditingController dateControllerIso;

  final String dateLabel;
  final String errorMessage;

  DatePickerAndPreviewWidget({
    @required this.dateControllerPreview,
    @required this.dateControllerIso,
    @required this.dateLabel,
    @required this.errorMessage,
  });

  @override
  _DatePickerAndPreviewWidgetState createState() =>
      _DatePickerAndPreviewWidgetState();
}

class _DatePickerAndPreviewWidgetState
    extends State<DatePickerAndPreviewWidget> {
  Future<void> _showDatePicker() async {
    try {
      final response = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1980),
        lastDate: DateTime.now(),
      );
      widget.dateControllerPreview.text =
          DateFormat('dd/MM/yyyy').format(response);
      widget.dateControllerIso.text = response.toIso8601String();
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * .6,
          child: TextFormField(
            validator: (value) {
              if (value == null || value == '') {
                return widget.errorMessage;
              } else {
                return null;
              }
            },
            readOnly: true,
            textAlign: TextAlign.end,
            controller: widget.dateControllerPreview,
            decoration: InputDecoration(
              labelText: widget.dateLabel,
              border: OutlineInputBorder(),
            ),
          ),
        ),
        SizedBox(width: 15),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).appBarTheme.color,
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 2.5,
                spreadRadius: 0.2,
                offset: Offset(
                  1.0,
                  2.5,
                ), // shadow direction: bottom right
              )
            ],
          ),
          child: IconButton(
            icon: Icon(
              Icons.calendar_today,
              color: Colors.white,
            ),
            onPressed: _showDatePicker,
          ),
        ),
        SizedBox(width: 5),
      ],
    );
  }
}
