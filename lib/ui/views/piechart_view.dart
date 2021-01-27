import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:Expenses_Tracker_App/core/enums/viewstate.dart';
import 'package:Expenses_Tracker_App/core/viewmodels/piechart_model.dart';
import 'package:Expenses_Tracker_App/ui/views/base_view.dart';
import 'package:pie_chart/pie_chart.dart';

class PieChartView extends StatelessWidget {
  const PieChartView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<PieChartModel>(
      onModelReady: (model) => model.init(true) ,
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('Thống kê'),
        ),
        body: model.state == ViewState.Busy
            ? CircularProgressIndicator()
            : SingleChildScrollView(
    child:  Container(
      alignment: Alignment.center,
          //elevation: 4,
          child: Column(
            children: <Widget>[
              ChipsChoice<int>.single(
                itemConfig: ChipsChoiceItemConfig(
                    elevation: 1, selectedColor: Colors.red),
                value: model.selectedMonthIndex,
                isWrapped: false,
                options: ChipsChoiceOption.listFrom<int, String>(
                  source: model.months,
                  value: (i, v) => i,
                  label: (i, v) => v,
                ),
                onChanged: (val) => model.changeSelectedMonth(val),
              ),
              ChipsChoice<int>.single(
                itemConfig: ChipsChoiceItemConfig(
                    elevation: 1, selectedColor: Colors.green),
                value: model.type == 'Tiền vào' ? 0 : 1,
                isWrapped: true,
                options: ChipsChoiceOption.listFrom<int, String>(
                  source: model.types,
                  value: (i, v) => i,
                  label: (i, v) => v,
                ),
                onChanged: (val) => model.changeType(val),
              ),
              model.dataMap.length == 0 ? Text('Không có dữ liệu cho tháng này') : PieChart(dataMap: model.dataMap),
            ],
          ),


    ),
        ),
      ),
    );
  }
}
