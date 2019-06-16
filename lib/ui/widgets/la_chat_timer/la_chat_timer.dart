import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:latter/core/models/update_interval.dart';
import 'package:latter/core/services/interval_service.dart';
import 'package:latter/ui/styles/colors.dart';
import 'package:latter/ui/styles/text.dart';
import 'package:provider/provider.dart';

/// Sample linear data type.
class LinearData {
  final int section;
  final int value;

  LinearData(this.section, this.value);
}

class LaChatTimer extends StatelessWidget {
  final Duration updateDuration = Duration(minutes: 1);

  @override
  Widget build(BuildContext context) {
    IntervalService intervalService = Provider.of<IntervalService>(context);

    return StreamBuilder<UpdateInterval>(
        stream: intervalService.interval,
        builder: (context, snapshot) {
          if(snapshot.hasData) {

            final data = [
              new LinearData(0, updateDuration.inSeconds - snapshot.data.remaining.inSeconds),
              new LinearData(1, snapshot.data.remaining.inSeconds),
            ];

            List<charts.Series<LinearData, int>> series = [
              new charts.Series<LinearData, int>(
                id: 'Sales',
                domainFn: (LinearData d, _) => d.section,
                measureFn: (LinearData d, _) => d.value,
                colorFn: (LinearData d, _) => d.section == 1 ?  charts.Color.fromHex(code: '#9CA6D5') : charts.ColorUtil.fromDartColor(LaColors.activeBlue),
                data: data,
              )
            ];

            return Stack(
              children: <Widget>[
                Center(
                  child: Text(
                    snapshot.data.remaining.inSeconds.toString(),
                    style: body1TextStyle,
                  )),
                charts.PieChart(
                  series,
                  animate: false,
                  layoutConfig: charts.LayoutConfig(
                    bottomMarginSpec: charts.MarginSpec.defaultSpec,
                    topMarginSpec: null,
                    leftMarginSpec: null,
                    rightMarginSpec: null,
                  ),
                  defaultRenderer: charts.ArcRendererConfig(arcWidth: 2),
                )
              ],
            );
          } else {
            return Container();
          }
        });
  }
}
