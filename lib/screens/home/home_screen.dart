import 'package:air_quality_application/components/InfoBigCard.dart';
import 'package:air_quality_application/models/Data.dart';
import 'package:air_quality_application/models/Predict.dart';
import 'package:air_quality_application/models/viewmodel.dart';
import 'package:air_quality_application/service/HttpService.dart';
import 'package:air_quality_application/service/blue_tooth_service.dart';
import 'package:air_quality_application/utils/constants.dart';
import 'package:air_quality_application/utils/string_utils.dart';
import 'package:air_quality_application/utils/styleguides/colors.dart';
import 'package:air_quality_application/utils/widget_functions.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:air_quality_application/utils/widget_extensions.dart';
import 'package:provider/provider.dart';
import 'dart:isolate';
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var httpService = Provider.of<HttpService>(context, listen: false);
    var theme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;
    var viewModel = Provider.of<DataViewModel>(context, listen:false);
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            width: size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [darkBlueGradientColor, lightBlueGradientColor])),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'Infomation',
                style: theme.headline5?.apply(
                    fontWeightDelta: -2,
                    fontSizeFactor: 1.2,
                    color: Colors.white),
              ).center(),
            ),
          ),
          addVerticalSpace(15),
                 ValueListenableBuilder<double>(                  
                   valueListenable: viewModel.tempNotifier,
                   builder: (BuildContext context,double data, _) {
                     //print('viewmodel changed');
                     //print('homescreen: ');
                     //print(Isolate.current.debugName);
                     print('value listenable builder: $data');
                     return _DetailList( temperature: data);
                   },
                 ),
        ],
      ),
    ));
  }
}

// class _Prediction extends StatelessWidget {
//   int f1, f8, f24;
//   _Prediction({Key? key, required this.f1, required this.f8, required this.f24})
//       : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           _PredictItem(aqi: f1, title: 'F1 AQI'),
//           _PredictItem(aqi: f8, title: 'F8 AQI'),
//           _PredictItem(aqi: f24, title: 'F24 AQI')
//         ],
//       ),
//     );
//   }
// }

// class _PredictItem extends StatelessWidget {
//   String title;
//   int aqi;
//   String status = StatusCode.good;
//   _PredictItem({Key? key, required this.aqi, required this.title})
//       : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     var theme = Theme.of(context).textTheme;
//     var color = Colors.green.shade800;
//     var lightColor = Colors.green.shade600;
//     if (aqi > 50) {
//       color = Colors.yellow.shade800;
//       lightColor = Colors.yellow.shade700;
//       status = StatusCode.moderate;
//     }
//     if (aqi > 100) {
//       color = Colors.deepOrange.shade700;
//       lightColor = Colors.deepOrange.shade500;
//       status = StatusCode.unhealthySensitive;
//     }
//     if (aqi > 150) {
//       color = Colors.redAccent.shade700;
//       lightColor = Colors.redAccent.shade400;
//       status = StatusCode.unhealthy;
//     }
//     if (aqi > 200) {
//       color = Colors.purple.shade700;
//       lightColor = Colors.purple.shade400;
//       status = StatusCode.veryUnhealthy;
//     }
//     if (aqi > 300) {
//       color = Colors.red.shade900;
//       lightColor = Colors.red.shade700;
//       status = StatusCode.hazardous;
//     }
//     return Container(
//       width: size.width / 4,
//       padding: const EdgeInsets.symmetric(vertical: 16),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(colors: [color, lightColor]),
//         borderRadius: BorderRadius.circular(15),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Text(
//             title,
//             style: theme.headline3
//                 ?.apply(color: Colors.white, fontWeightDelta: -2),
//           ).center(),
//           addVerticalSpace(10),
//           Text(
//             'AQI: $aqi',
//             style: theme.headline5?.apply(
//                 color: Colors.white, fontWeightDelta: -1, fontSizeFactor: 1.2),
//           ).center(),
//           addVerticalSpace(10),
//           Text(
//             status,
//             style:
//                 theme.bodyText1?.apply(color: Colors.white, fontWeightDelta: 1),
//           ).center()
//         ],
//       ),
//     );
//   }
// }

class _DetailList extends StatelessWidget {
  double temperature;
  _DetailList(
      {Key? key,
      required this.temperature,})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      color: Colors.white,
      child: Table(
        children: [
          TableRow(
            children: [
              InfoBigCard(
                firstText: 'Not available',
                secondText: 'Heart-rate',
                icon: Icon(
                  Icons.priority_high_outlined,
                  size: 25,
                  color: lightBlueGradientColor,
                ),
              ),
              InfoBigCard(
                firstText: 'Not available',
                secondText: 'Breath',
                icon: Icon(
                  Icons.speed,
                  size: 25,
                  color: lightBlueGradientColor,
                ),
              ),
            ],
          ),
          TableRow(
            children: [
              InfoBigCard(
                firstText: 'Not available',
                secondText: 'BloodPressure',
                icon: Icon(
                  Icons.speed,
                  size: 25,
                  color: lightBlueGradientColor,
                ),
              ),
              InfoBigCard(
                firstText: 'Not available',
                secondText: 'Emotional',
                icon: Icon(
                  Icons.delete_sweep_rounded,
                  size: 25,
                  color: lightBlueGradientColor,
                ),
              ),
            ],
          ),
          TableRow(
            children: [
              InfoBigCard(
                firstText: '$temperature \u2070C',
                secondText: 'temperature',
                icon: Icon(
                  Icons.whatshot,
                  size: 25,
                  color: lightBlueGradientColor,
                ),
              ),
              InfoBigCard(
                firstText: 'Not available',
                secondText: 'humidity',
                icon: Icon(
                  Icons.water_damage_outlined,
                  size: 25,
                  color: lightBlueGradientColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
