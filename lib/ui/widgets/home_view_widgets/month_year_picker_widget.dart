import 'package:flutter/material.dart';
import 'package:Expenses_Tracker_App/core/viewmodels/home_model.dart';

class PickMonthOverlay extends StatefulWidget {
  final HomeModel model;
  final BuildContext context;

  const PickMonthOverlay({Key key, this.model, this.context})
      : super(key: key);

  @override
  _PickMonthOverlayState createState() => _PickMonthOverlayState();
}

class _PickMonthOverlayState extends State<PickMonthOverlay> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 60.0),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.model.months.length,
          itemBuilder: (Context, i) {
            return Container(
              padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 8.0),
              child: InkWell(
                onTap: () {
                  widget.model.monthClicked(widget.model.months[i]);
                },
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  color:   widget.model.getColor(widget.model.months[i]),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      child: Center(
                          child: Text(
                            widget.model.months[i].toString(),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w300),
                          )),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
