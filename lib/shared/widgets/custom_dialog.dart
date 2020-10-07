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
          height: MediaQuery.of(context).size.height * 0.45,
          child: Column(
            children: [
              Stack(
                children: [
                  IconButton(
                    icon: Icon(Icons.close),
                    color: Colors.black,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Center(
                      child: Text(
                        title,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              content,
            ],
          ),
        ),
      ),
    );
  }
}
