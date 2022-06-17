import 'package:air_quality_application/models/Recommend.dart';
import 'package:air_quality_application/service/HttpService.dart';
import 'package:air_quality_application/utils/string_utils.dart';
import 'package:air_quality_application/utils/styleguides/colors.dart';
import 'package:air_quality_application/utils/widget_functions.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:air_quality_application/utils/widget_extensions.dart';
import 'package:provider/provider.dart';

class RecommendScreen extends StatelessWidget {
  int aqi = 108;
  String status = 'Unhealthy for Sensitive Groups';
  @override
  Widget build(BuildContext context) {
    var httpService = Provider.of<HttpService>(context, listen: false);
    var theme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder(
          stream: httpService.fetchRecommend(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Event event = snapshot.data as Event;
              final predictMap = parseDynamicToMap(event.snapshot.value);
              Recommend recommend = Recommend.fromJson(predictMap);
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    width: size.width,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          darkBlueGradientColor,
                          lightBlueGradientColor
                        ])),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Recommend',
                        style: theme.headline5?.apply(
                            fontWeightDelta: -2,
                            fontSizeFactor: 1.2,
                            color: Colors.white),
                      ).center(),
                    ),
                  ),
                  addVerticalSpace(15),
                  Text('Current AQI', style: theme.headline3?.apply()),
                  addVerticalSpace(15),
                  Text(
                    '${recommend.aqi}',
                    style: theme.headline4?.apply(
                      fontSizeFactor: 1.5,
                    ),
                  ),
                  addVerticalSpace(15),
                  Text(
                    status,
                    style: theme.headline6?.apply(
                        color: Colors.deepOrange.shade700, fontSizeFactor: 1.5),
                  ),
                  addVerticalSpace(16),
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    child: _DetailRecommend(
                        sensitive:
                        recommend.sensitive,
                        effect:
                        recommend.effect,
                        caution:
                        recommend.caution),
                  )
                ],
              );
            }
            return CircularProgressIndicator(
            ).center();
          },
        ),
      ),
    );
  }
}

class _DetailRecommend extends StatelessWidget {
  String sensitive, effect, caution;
  _DetailRecommend(
      {Key? key,
      required this.sensitive,
      required this.effect,
      required this.caution})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sensitive Groups',
            style: theme.headline4?.apply(),
          ),
          addVerticalSpace(10),
          Text(
            sensitive,
            style: theme.headline6?.apply(
                fontSizeFactor: 1.2,
                fontWeightDelta: -1,
                color: Colors.grey.shade800,
                heightFactor: 1.5),
          ),
          addVerticalSpace(30),
          Text(
            'Health Effects Statements',
            style: theme.headline4?.apply(),
          ),
          addVerticalSpace(10),
          Text(
            effect,
            style: theme.headline6?.apply(
                fontSizeFactor: 1.2,
                fontWeightDelta: -1,
                color: Colors.grey.shade800,
                heightFactor: 1.5),
          ),
          addVerticalSpace(30),
          Text(
            'Cautionary Statements',
            style: theme.headline4?.apply(),
          ),
          addVerticalSpace(10),
          Text(
            caution,
            style: theme.headline6?.apply(
                fontSizeFactor: 1.2,
                fontWeightDelta: -1,
                color: Colors.grey.shade800,
                heightFactor: 1.5),
          ),
        ],
      ),
    );
  }
}
