import 'package:air_quality_application/models/viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'dart:io';
import 'dart:isolate';
class DataSample {
  double temperature1;

  DataSample({
    required this.temperature1,
  });
}
class BackgroundCollectingTask with ChangeNotifier{
  // static BackgroundCollectingTask of(
  //   BuildContext context, {
  //   bool rebuildOnChange = false,
  // }) =>
  //     ScopedModel.of<BackgroundCollectingTask>(
  //       context,
  //       rebuildOnChange: rebuildOnChange,
  //     );
  BackgroundCollectingTask();
  late BluetoothConnection _connection;
  List<int> _buffer = List<int>.empty(growable: true);

  // @TODO , Such sample collection in real code should be delegated
  // (via `Stream<DataSample>` preferably) and then saved for later
  // displaying on chart (or even stright prepare for displaying).
  // @TODO ? should be shrinked at some point, endless colleting data would cause memory shortage.
  List<DataSample> samples = List<DataSample>.empty(growable: true);

  bool inProgress = false;
  BackgroundCollectingTask._fromConnection(this._connection, DataViewModel viewModel) {
    _connection.input!.listen((data) {
      _buffer += data;
      print('listen: ${Isolate.current.debugName}');
      while (true) {
        // If there is a sample, and it is full sent
        int index = 0;
        print('index: $index');
        if (index >= 0 && data.length - index >= 7) {
          // final DataSample sample = DataSample(
          //     temperature1: (data[index + 1] + data[index + 2] / 100));
          var str = '';
          for (var i in data){           
            str += String.fromCharCode(i);
          }
          // print(str);
          // samples.add(sample);
          viewModel.onChanged(double.parse(str));
          notifyListeners();                  
          break;
            // var arduinoTemp = double.parse(str);
            // viewModel.onChanged(double.parse(str));
          // Note: It shouldn't be invoked very often - in this example data comes at every second, but if there would be more data, it should update (including repaint of graphs) in some fixed interval instead of after every sample.
          //print("${sample.timestamp.toString()} -> ${sample.temperature1} / ${sample.temperature2}");
        }
        // Otherwise break
        else {
          break;
        }
      }
    }).onDone(() {
      inProgress = false;
      notifyListeners();
    });
  }
//co the sai o day 1'
    static Future<BackgroundCollectingTask> connect(
      BluetoothDevice server, DataViewModel viewModel) async {
        print('ConnectStart');
    final BluetoothConnection connection =
        await BluetoothConnection.toAddress(server.address);
            print('ConnectStop');
        print('ConnectStart');

    final result = BackgroundCollectingTask._fromConnection(connection, viewModel);
                print('ConnectStop');

    return result;
  }

    void dispose() {
    _connection.dispose();
  }
//co the sai o day
    Future<void> start() async {
    inProgress = true;
    _buffer.clear();
    samples.clear();
    notifyListeners();
    await _connection.output.allSent;
  }

    Future<void> cancel() async {
    inProgress = false;
    notifyListeners();
    await _connection.finish();
  }

  // Future<void> pause() async {
  //   inProgress = false;
  //   notifyListeners();
  //   _connection.output.add(ascii.encode('stop'));
  //   await _connection.output.allSent;
  // }

  // Future<void> reasume() async {
  //   inProgress = true;
  //   notifyListeners();
  //   _connection.output.add(ascii.encode('start'));
  //   await _connection.output.allSent;
  // }

  DataSample getLastOf() {
    // DateTime startingTime = DateTime.now().subtract(duration);
    // int i = samples.length;
    // do {
    //   i -= 1;
    //   if (i <= 0) {
    //     break;
    //   }
    // } while (samples[i].timestamp.isAfter(startingTime));
    print(samples.last);
    return samples.last;
  }
}
