import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final Widget content;
  const CustomDialog({@required this.title, @required this.content});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(22)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.4,
          child: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              content,
            ],
          ),
        ),
      ),
    );
  }
}
