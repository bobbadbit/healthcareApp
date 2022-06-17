import 'package:flutter/material.dart';

class InfoBigCard extends StatelessWidget {
  final String firstText, secondText;
  final Widget icon;

  const InfoBigCard(
      {Key? key,
      required this.firstText,
      required this.secondText,
      required this.icon})
      : super(key: key);

  Widget verifyText(TextTheme textTheme) {
    return (firstText.isNotEmpty) ? Text(firstText, style: textTheme.headline4,):
        Text('Not Available', style: textTheme.headline6,);
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.only(left: 16, top: 16, bottom: 24, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
                child: icon),
            verifyText(theme),
            Text(
              secondText,
              style: theme.subtitle1,
            )
          ],
        ),
      ),
    );
  }
}
