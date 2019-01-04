import 'package:diablo_season_6p/db/DBProvider.dart';
import 'package:flutter/material.dart';

class ChallengeWidget extends StatefulWidget {
  final String title;
  bool isCompleted;
  VoidCallback onChallengeClicked;

  ChallengeWidget({@required this.title, @required this.isCompleted, this.onChallengeClicked});

  @override
  ChallengeWidgetState createState() => ChallengeWidgetState();
}

class ChallengeWidgetState extends State<ChallengeWidget> {
  //final Function onChallengeClicked;
  //bool isCompleted = false;
  //final String title;
  final DBProvider db = DBProvider();

  //ChallengeWidgetState(this.title, this.isCompleted, this.onChallengeClicked);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        switchChanged();
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: widget.isCompleted ? Colors.green : Colors.red,
            ),
            borderRadius: BorderRadius.circular(8.0)),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Opacity(
            opacity: widget.isCompleted ? 0.4 : 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  widget.title,
                  style: TextStyle(
                      fontSize: 22,
                      color: widget.isCompleted ? Colors.green : Colors.red,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      widget.isCompleted ? 'Completed' : 'Not completed',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 18,
                        color: widget.isCompleted ? Colors.green : Colors.red,
                      ),
                    ),
                    _getCheckMarkIfCompleted(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getCheckMarkIfCompleted() {
    return widget.isCompleted
        ? Image.asset('assets/check.png', height: 40, width: 40)
        : Container();
  }

  Future switchChanged() async {
    await db.update(widget.title, !widget.isCompleted ? 1 : 0);
    widget.onChallengeClicked;
    setState(()  {
      widget.isCompleted = !widget.isCompleted;
    });
  }
}
